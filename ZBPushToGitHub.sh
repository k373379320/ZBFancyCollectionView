#! /bin/bash

echo "pod update..."

git add .
git commit  -m "恢复"
git tag "1.1.0"
git push origin master
git push --tags
pod trunk push ZBFancyCollectionView.podspec
