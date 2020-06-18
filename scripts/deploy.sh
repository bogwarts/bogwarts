#!/bin/bash

jekyll build
cd _site
git add .
git commit -m "latest"
git push origin master
cd ..
