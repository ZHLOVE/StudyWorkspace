#!/bin/sh
# 查找没有使用到的图片的脚本
PROJ=`find . -name '*.xib' -o -name '*.[mh]'`  
  
for png in `find . -name '*.png'`  
do  
    name=`basename $png`  
    if ! grep -qhs "$name" "$PROJ"; then  
        echo "$png is not referenced"  
    fi  
done  
