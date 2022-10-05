#!/bin/bash

# pre-commit
if [ ! -f .git/hooks/pre-commit ]        
then
    echo "make all" > .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit
fi

# pre-push
if [ ! -f .git/hooks/pre-push ]        
then
    echo "make all" > .git/hooks/pre-push && chmod +x .git/hooks/pre-push
fi