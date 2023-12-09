#! /bin/bash

echo "pod update..."

git add .
git commit  -m "fix:兼容改为最低12"
git tag "1.2.4"
git push origin master
git push --tags
pod trunk push ZBFancyCollectionView.podspec
