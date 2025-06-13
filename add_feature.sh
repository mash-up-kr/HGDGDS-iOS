#!/bin/bash

NAME=$1
AUTHOR=$(git config user.name)

tuist scaffold Feature --name $NAME --author "$AUTHOR"
