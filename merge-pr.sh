#!/bin/bash

PR_NUMBER=$1

# Checkout the branch locally
git fetch origin pull/$PR_NUMBER/head:pr-$PR_NUMBER
git checkout pr-$PR_NUMBER

# Merge into main branch
git fetch origin main
git merge origin/main --no-ff --no-edit

# Push changes back to GitHub
git push origin main

# Delete the merged branch
git push origin --delete pr-$PR_NUMBER
