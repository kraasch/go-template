#!/bin/bash

### read values.
echo "Your first name:"
read FIRSTNAME
if $(test -z "$FIRSTNAME"); then
  FIRSTNAME='Alex'
fi
echo "Your last name:"
read LASTNAME
if $(test -z "$LASTNAME"); then
  LASTNAME='Kraasch'
fi
echo "Your github username:"
read GITHUB
if $(test -z "$GITHUB"); then
  GITHUB='kraasch'
fi
echo "Your email adddress:"
read EMAIL
if $(test -z "$EMAIL"); then
  EMAIL='alex@kraasch.eu'
fi
echo "New module name:"
read MODULE
if $(test -z "$MODULE"); then
  MODULE='mymodule'
fi
echo "Underlying package name:"
read PACKAGE
if $(test -z "$PACKAGE"); then
  PACKAGE='mypackage'
fi

### other values.
YEAR=$(date +%Y)

### move files.
mv ./cmd/MODULE.go ./cmd/"$MODULE".go
mv ./pkg/PACKAGE/ ./pkg/"$PACKAGE"
rm ./README.md
mv ./NEWREADME.md ./README.md
rm ./.goreleaser.yaml
mv ./NEW.goreleaser.yaml ./.goreleaser.yaml

### replace values.
sed -i "s/MODULE/$MODULE/g" ./Makefile
sed -i "s/PACKAGE/$PACKAGE/g" ./pkg/"$PACKAGE"/main.go
sed -i "s/PACKAGE/$PACKAGE/g" ./pkg/"$PACKAGE"/main_test.go
sed -i "s/FIRSTNAME/$FIRSTNAME/g" ./LICENSE
sed -i "s/LASTNAME/$LASTNAME/g" ./LICENSE
sed -i "s/MYYEAR/$YEAR/g" ./LICENSE
sed -i "s/GITHUB/$GITHUB/g" ./cmd/"$MODULE".go
sed -i "s/MODULE/$MODULE/g" ./cmd/"$MODULE".go
sed -i "s/PACKAGE/$PACKAGE/g" ./cmd/"$MODULE".go
sed -i "s/MODULE/$MODULE/g" ./README.md
sed -i "s/GITHUB/$GITHUB/g" ./README.md
sed -i "s/EMAIL/$EMAIL/g" ./README.md

### delete lines.
sed -i "/<REMOVE>/d" ./Makefile

### get the latest gitignore.
curl -s 'https://raw.githubusercontent.com/github/gitignore/refs/heads/main/Go.gitignore' >>.gitignore

### init go package.
go mod init github.com/"$GITHUB"/"$MODULE"
go mod tidy

### remove old repo and do first git commit.
rm -rf .git
rm ./init.sh
git init
git add .
git commit -m "Init."

### run go test.
make test
