#!bin/bash

## Update the git repo with new results
git add --all
git commit -m "Updated website"
git pull -Xours
git push origin master

## Deploy the website to gh-pages
cp -rf docs/. ../docs
git checkout --orphan gh-pages
rm -f -r *
cp -r ../docs/. .
rm .gitignore
rm -r .github
rm .Rbuildignore
touch .gitignore
echo ".Rproj.user" > .gitignore 
git add --all
git commit -m "deploy site"
git push -f origin gh-pages:gh-pages
git checkout master
cp -r ../docs/. docs
git branch -D gh-pages
rm -rf ../docs
