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
##=========================================================================


# 工程名
APP_NAME="MutableTargetDemo"

CODE_SIGN_DISTRIBUTION="iPhone Distribution: Shenzhen Okdeer Network Technology Co., Ltd."

#打包环境: DEBUG, Dev02, Test04, Release

#清缓存
xcodebuild clean -scheme "${APP_NAME}" -configuration 'Test04'

#archive
xcodebuild archive -scheme "${APP_NAME}" -archivePath "./${APP_NAME}.xcarchive" -configuration 'Test04'

#导出ipa
xcodebuild -exportArchive -archivePath "./${APP_NAME}.xcarchive" -exportPath "./" -exportOptionsPlist "./ExportOptionsPlist.plist"


