#! /bin/bash

echo "pod update..."

git add .
git commit  -m "回退源码"
git tag "1.0.1"
git push origin master
git push --tags
pod trunk push ZBFancyCollectionView.podspec
