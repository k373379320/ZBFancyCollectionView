#! /bin/bash

echo "pod update..."

git add .
git commit  -m "fix:header高度问题"
git tag "1.2.3"
git push origin master
git push --tags
pod trunk push ZBFancyCollectionView.podspec
