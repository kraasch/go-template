

# go-template

## Features

This script will initialize a small Go project with one package and tests.

This includes setup for the following things:

 - [X] Makefile,
 - [X] README,
 - [X] License (MIT),
 - [X] GITIGNORE,
 - [X] GoReleaser for CI/CD,
 - [X] Go module name,
 - [X] Go package name,
 - [X] Go tests,

It contains a shell script which asks for how to initialize the project.

The script asks for

  - your first name,
  - your last name,
  - your Github username,
  - your email adddress,
  - the project's new module name,
  - the project's underlying package name.

## Instructions

In order to setup a new project run the following commands

```bash
git clone https://github.com/kraasch/go-template
cd ./go-template
make
```

Or fork the project and update my default data with yours in [initialization script](./init.sh).

## Overview

The script will create the following directory tree:

```text
# .
# ├── .gitignore
# ├── .github
# │   └── workflows
# │       └── goreleaser.yml
# ├── cmd
# │   └── MODULE.go
# ├── LICENSE
# ├── Makefile
# ├── resources
# │   ├── demo.gif
# │   └── example.png
# ├── pkg
# │   └── PACKAGE
# │       ├── main.go
# │       └── main.go
# └── README.md
# 5 directories, 8 files
```

## Tasks

Ideas:

  - [ ] use Go's [cobra package](https://github.com/spf13/cobra) as default argument parser instead of the [flag package](https://pkg.go.dev/flag).

Done:

  - [X] delete this readme and copy in another default readme.
    - [X] `rm README.md`
    - [X] `mv README_template.md README.md`
  - [X] make default readme contain default sections of a good readme:
    - [X] usage.
    - [X] installation.
    - [X] ... etc (TODO: find more)

