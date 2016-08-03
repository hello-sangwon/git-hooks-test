#!/bin/bash
# cp git-hooks/pre-commit.sh .git/hooks/pre-commit; chmod a+x .git/hooks/pre-commit

PYTHON_LINT=`which pep8`
JS_LINT=`which jslint`
CSS_LINT=`which csslint`

IFS=$'\n'
for line in $(git diff --cached --name-status); do
    status=`echo $line | awk '{print $1}'`
    filename=`echo $line | awk '{print $2}'`
    if [ $status == "M" ] || [ $status == "A" ]; then
        # do lint
        FILE_EXT=`echo $filename | awk -F'.' '{print $NF}'`
        # python
        if [ "x$FILE_EXT" == "xpy" ]; then
            $PYTHON_LINT $filename > /dev/null
            if [ $? -gt 0 ]; then
                echo -e "\033[31mAborted due to warnings:\033[0m "
                echo " [FILE: $filename] ${PYTHON_LINT##/*/} 를 통과하지 못 했습니다."
                exit 1
            fi
        fi

        # javascript
        if [ "x$FILE_EXT" == "xjs" ]; then
            $JS_LINT $filename > /dev/null
            if [ $? -gt 0 ]; then
                echo -e "\033[31mAborted due to warnings:\033[0m "
                echo " [FILE: $filename] ${JS_LINT##/*/} 를 통과하지 못 했습니다."
                exit 1
            fi
        fi

        # css
        if [ "x$FILE_EXT" == "xcss" ]; then
            result=`$CSS_LINT $filename`
            echo $result | grep 'csslint: No errors in ' > /dev/null
            if [ $? -gt 0 ]; then
                echo -e "\033[31mAborted due to warnings:\033[0m "
                echo " [FILE: $filename] ${CSS_LINT##/*/} 를 통과하지 못 했습니다."
                exit 1
            fi
        fi
    fi
done

exit 0

# vim: set fenc=utf8 expandtab sw=4 ts=4:
