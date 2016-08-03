#!/bin/bash
# cp git-hooks/pre-push.sh .git/hooks/pre-push; chmod 700 .git/hooks/pre-push

protected_branch='master'

commits=`git log @{u}..`

current_branch=`git symbolic-ref HEAD | awk -F'/' '{print $NF}'`

if [ $current_branch == $protected_branch ]; then
    echo "ERROR: $current_branch 브랜치에는 직접 push 할 수 없습니다."
    echo "       대신에 Pull Request 를 사용해 주세요."
    exit 1
fi

exit 0

# vim: set fenc=utf8 expandtab sw=4 ts=4:
