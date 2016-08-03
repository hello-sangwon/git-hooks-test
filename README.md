# git-hooks-test

## 목적
* github flow 연습

## 설치 방법
```shell
$ pip install pep8
$ npm install -g jslint
$ npm install -g csslint
```

## git 설정 방법
```shell
$ cp git-hooks/pre-commit.sh .git/hooks/pre-commit; chmod a+x .git/hooks/pre-commit
$ cp git-hooks/pre-push.sh .git/hooks/pre-push; chmod a+x .git/hooks/pre-push
```
