#! /bin/bash

echo "pod update..."

git add .
git commit  -m "添加willDisplayCellHandler 和 didEndDisplayingCellHandler 回调"
git tag "0.3.2"
git push origin master
git push --tags
pod trunk push ZBFancyCollectionView.podspec
