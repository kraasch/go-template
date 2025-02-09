#!/bin/bash

# This script will initialize a go project with a package and tests.
# - [ ] go
#   - module name
#   - package name
#   - go tests
# - goreleaser for ci/cd
# - makefile
# - readme
# - license (MIT)
# - gitignore
# It will create the following directory tree:
# .
# ├── .gitignore
# ├── .github
# │   └── workflows
# │       └── goreleaser.yml
# ├── cmd
# │   └── MODULE.go
# ├── init.sh
# ├── LICENSE
# ├── Makefile
# ├── pkg
# │   └── PACKAGE
# │       ├── engine.go
# │       └── engine_test.go
# └── README.md
# 5 directories, 8 files

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

### replace values.
sed -i "s/MODULE/$MODULE/g" ./Makefile
sed -i "s/PACKAGE/$PACKAGE/g" ./pkg/"$PACKAGE"/engine_test.go
sed -i "s/PACKAGE/$PACKAGE/g" ./pkg/"$PACKAGE"/engine.go
sed -i "s/FIRSTNAME/$FIRSTNAME/g" ./LICENSE
sed -i "s/LASTNAME/$LASTNAME/g" ./LICENSE
sed -i "s/MYYEAR/$YEAR/g" ./LICENSE
sed -i "s/GITHUB/$GITHUB/g" ./cmd/"$MODULE".go
sed -i "s/MODULE/$MODULE/g" ./cmd/"$MODULE".go
sed -i "s/PACKAGE/$PACKAGE/g" ./cmd/"$MODULE".go
sed -i "s/MODULE/$MODULE/g" ./README.md

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
