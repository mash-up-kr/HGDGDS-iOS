#!/bin/bash

NAME=$1
AUTHOR=$(git config user.name)

tuist scaffold feature --name $NAME --author "$AUTHOR"
