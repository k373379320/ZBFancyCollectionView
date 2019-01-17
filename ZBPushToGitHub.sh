#! /bin/bash

echo "pod update..."

git add .
git commit  -m "使用fk"
git tag "0.3.4"
git push origin master
git push --tags
pod trunk push ZBFancyCollectionView.podspec
