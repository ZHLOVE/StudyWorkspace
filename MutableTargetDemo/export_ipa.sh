
#1.工程名
App_Name="MutableTargetDemo"

#2.打包环境
Config_Name=$1
Dev02="Dev02"
Test04="Test04"
Release="Release"

if [ $Config_Name ] ; then

    if [ $Config_Name = $Dev02 || $Config_Name = $Test04 || $Config_Name = $Release] ; then
        echo "开始打包环境===========${Config_Name}==========="

    else
        echo "错误======"
    fi

else
    echo "没有指定打包环境, 即将开始打包: \033[41;36m Release \033[0m 环境, 确定吗? y/n --> "
    read -s -n 1 sure

    echo "\033[41;36m $sure \033[0m"

    if [ $sure = y ] ; then
        Config_Name="Release"
        echo "开始打包环境======${Config_Name}======"

    elif [ $sure = n ] ; then
        echo "您已取消打包..."
        exit 1

    else
        echo "输入错误, 打包已终止..."
        exit 1
    fi
fi


CODE_SIGN_DISTRIBUTION="iPhone Distribution: Shenzhen Okdeer Network Technology Co., Ltd."

#打包环境: Dev02, Test04, Release

#清缓存
xcodebuild clean -scheme "${App_Name}" -configuration "${Config_Name}"

#archive
xcodebuild archive -scheme "${App_Name}" -archivePath "./${App_Name}.xcarchive" -configuration "${Config_Name}"

#导出ipa
xcodebuild -exportArchive -archivePath "./${App_Name}.xcarchive" -exportPath "./" -exportOptionsPlist "./ExportOptionsPlist.plist"


echo "打包环境===========${Config_Name}===========完成"

##=========================================================================


## 工程名
#APP_NAME="MutableTargetDemo"
#
## 证书
##生产证书
#CODE_SIGN_DISTRIBUTION="iPhone Distribution: Shenzhen Okdeer Network Technology Co., Ltd."
## 开发证书
##CODE_SIGN_DISTRIBUTION="iPhone Developer: Ruquan Liang"
## info.plist路径
#project_infoplist_path="./${APP_NAME}/Info.plist"
#
##取版本号
#bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" "${project_infoplist_path}")
#
##取build值
#bundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" "${project_infoplist_path}")
##展示的版本号
#showVersion=$(/usr/libexec/PlistBuddy -c "print ShowVersion" "${project_infoplist_path}")
#echo ${showVersion}
#
##升级的code
#versionCode=$(/usr/libexec/PlistBuddy -c "print VersionCode" ${project_infoplist_path})
#echo ${versionCode}
#
#DATE="$(date +%Y%m%d)"
##IPA 文件名
#IPANAME="${APP_NAME}_${showVersion}_${versionCode}.ipa"
#
#mkdir -p -m 777 ~/Documents/saveOkdeerAppIpa/${APP_NAME}/${bundleShortVersion}/${DATE}
#
##保存ipa文件路径
#IPA_PATH="$HOME/Documents/saveOkdeerAppIpa/${APP_NAME}/${bundleShortVersion}/${DATE}/"
#chmod -R 777 ~/Documents/saveOkdeerAppIpa/
##导出ipa临时路径
#Temp_IAP_PATH="./"
##IPA_PATH="./${IPANAME}"
#echo ${IPA_PATH}
#
#archive_Path="./${APP_NAME}.xcarchive"
#ExportOptionsPlist_Path="./ExportOptionsPlist.plist"
#
#
##是集成有Cocopods的用法
#echo "=================clean================="
#xcodebuild clean -scheme "${APP_NAME}" -configuration Test04
#echo "=================archive================="
##archive
#xcodebuild archive -scheme "${APP_NAME}" -archivePath "${archive_Path}"
#echo "=================exportArchive================="
# #导出ipa
#xcodebuild -exportArchive -configuration Test04 -archivePath "${archive_Path}" -exportPath "${Temp_IAP_PATH}" -exportOptionsPlist "${ExportOptionsPlist_Path}"
#
#echo ${IPA_PATH}