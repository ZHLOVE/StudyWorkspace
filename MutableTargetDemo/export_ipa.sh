#!/bin/bash

#1.工程名
App_Name="MutableTargetDemo"

#打包环境有: Dev02, Test04, Release

#2.打包环境
Config_Name=$1
Dev02="Dev02"
Test04="Test04"
Release="Release"

if [ $Config_Name ] ; then

    if [ $Config_Name = $Dev02 ] || [ $Config_Name = $Test04 ] || [ $Config_Name = $Release ] ; then
        echo "开始打包环境===========${Config_Name}==========="

    else

        #直到输入的环境为正确是,否则一直提示输入环境打包
        while [ $Config_Name != $Dev02 ] && [ $Config_Name != $Test04 ] && [ $Config_Name != $Release ]
        do
            read -p "参数错误, 当前环境有: Dev02, Test04, Release, 请输入其中任一一个打包 --> " inputType
            echo
            Config_Name=$inputType
        done

        echo "开始打包环境===========${Config_Name}==========="
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

#==============================开始打包 Start==============================
#打包时间
Date="$(date +%Y%m%d)"
#打包时间
Time="$(date +%Y%m%d%H%M%S)"
#归档路径
Archive_Path="./${App_Name}.xcarchive"
#ipa包路径
Export_Path="./${Date}_ipa/"
#ipa包路径
Temp_Ipa_Path="./${Date}_ipa/${App_Name}.ipa"
#改变包名称
Ipa_Path="./${Date}_ipa/${Config_Name}_${Time}.ipa"
#Plist文件路径
Plist_Path="./ExportOptionsPlist.plist"

if [ $Config_Name == $Release ] ; then
#签名证书
CodeSignIdentity="iPhone Distribution: Shenzhen Okdeer Network Technology Co., Ltd. (W222R58V26)"
#UDID: okdeerMallAdHoc
AppStoreProvisioningProfile="3e37a002-63b3-41ab-bd9d-cfb2fc52c273"
else
#签名证书
CodeSignIdentity="iPhone Developer: Ruquan Liang (MZQG6ZJU88)"
#UDID: okdeerMallDevelopment:
AppStoreProvisioningProfile="2b34bd26-178b-4996-8176-aa03a0e15412";
fi


#清缓存
xcodebuild clean \
-scheme "${App_Name}" \
-configuration "${Config_Name}" \
-alltargets

#归档archive
xcodebuild archive \
-scheme "${App_Name}" \
-configuration "${Config_Name}" \
-archivePath "${Archive_Path}" \
CODE_SIGN_IDENTITY="$CodeSignIdentity" \
PROVISIONING_PROFILE="$AppStoreProvisioningProfile"

#导出ipa
xcodebuild -exportArchive \
-archivePath "${Archive_Path}" \
-exportPath "${Export_Path}" \
-exportOptionsPlist "${Plist_Path}"


#按日志格式重命名ipa包
mv "${Temp_Ipa_Path}" "${Ipa_Path}"
#删除归档文件
rm -r -f "${Archive_Path}"
#清除shell日志
clear
#打开文件夹
open $Export_Path

echo
echo "\033[41;36m 恭喜: 🎉 🎉 🎉${Config_Name}环境打包完成, 路径为:${Ipa_Path} \033[0m"
echo



#==============================开始重签名为企业包 Start==============================



#企业包重签名参考地址: http://www.jianshu.com/p/f4cfac861aac
echo "\033[41;36m ===========================打包结束, 开始重签名为企业包 Start========================= \033[0m"

entitlements_full_Path="./entitlements_full.plist"
# mobileprovision生成plist的路径
entitlements_Path="./entitlements.plist"
# 配置文件的路径
mobileprovision_Path="./handlink_cer/lukeInHouse.mobileprovision"
# 重签名证书名称
Re_CODE_SIGN_DISTRIBUTION="iPhone Distribution: Shenzhen Huayitong Network Technology Co., Ltd."
# 重签名ipa包路径
Re_Ipa_Path="./${Date}_ipa/${Config_Name}_${Time}_reSign.ipa"
#ipa包路径
Export_Path="./${Date}_ipa/"
# 重签名ipa文件存放路径
Re_IPA_PATH="$HOME/Documents/saveOkdeerAppIpa/${App_Name}/${bundleShortVersion}/${DATE}/${Re_Ipa_Path}"

# 生成plist文件
security cms -D -i ${mobileprovision_Path} > ${entitlements_full_Path}
/usr/libexec/PlistBuddy -x -c 'Print:Entitlements' ${entitlements_full_Path} > ${entitlements_Path}

# 解压文件
unzip "${Ipa_Path}"
#拷贝配置文件到文件中
cp "${mobileprovision_Path}" \
Payload/MutableTargetDemo.app/embedded.mobileprovision

# 进行重签名
codesign -f -s "${Re_CODE_SIGN_DISTRIBUTION}" \
--entitlements "${entitlements_Path}" \
Payload/MutableTargetDemo.app/

#压缩文件
zip -r re_sign.ipa Payload
#按日志格式重命名ipa包
mv "./re_sign.ipa" "${Re_Ipa_Path}"
#删除Payload解压文件夹
rm -r -f ./Payload


#==============================开始上传fir.im内测平台 Start==============================

echo "\033[41;36m ========================重签名结束, 开始上传fir.im内测平台======================== \033[0m"

#Fir内测平台Token
fir_token="0f5fadc120ba74da84724e55434b28fb"
#版本更新信息 (Upgrade_describe.txt 此文件为版本更新的描述,需要放在项目的.xcodeproj的同一级)
UpgradeDesc=$(<Upgrade_describe.txt)
#上传到fir
fir publish "${Ipa_Path}" -T "${fir_token}" -c "${UpgradeDesc}"

#弹框通知提示验证ipa包结果状态
if [ $? == 0 ] ; then
#ipa包下载地址: http://fir.im/vlpc
echo "\033[41;36m 🎉 🎉 🎉 恭喜: 上传fir.im成功！请到App内部点击安装或从Web端(http://fir.im/vlpc)下载最新版App \033[0m "
#打开web下载页面
open http://fir.im/vlpc
else
echo "\033[41;36m ========================😰😰😰 糟糕, 上传fir.im失败!!!======================== \033[0m"
exit 1
fi


#==============================开始发布到iTunesConnect ==============================

echo
#学习上传命令: http://help.apple.com/itc/apploader/#/apdATD1E53-D1E1A1303-D1E53A1126
echo "\033[41;36m =================上传fir.im内测平台完成, 开始发布到iTunesConnect =================\033[0m"

#altool工具路径 (这个是系统altool路径,是固定的)
altoolPath="/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool"
#需要上传至iTunes Connect的本地ipa包地址
upload_IpaPath="${Ipa_Path}"
#开发者账号（邮箱）
appleid="app01@kingser.com"
#开发者账号的密码
applepassword="okdeerYsc.2312"

#======1.验证ipa包是否成功======
"$altoolPath" --validate-app -f "${upload_IpaPath}" -u "$appleid" -p "$applepassword"

#弹框通知提示验证ipa包结果状态
if [ $? == 0 ] ; then
echo "\033[41;36m ============ 验证ipa包成功, 开始上传至iTunes Connect============ \033[0m"
else
osascript -e 'display notification "😰😰😰 糟糕, 验证ipa包失败!!!" with title "提示"'
exit 1
fi

##======2.上传ipa包到iTunes Connect======
#"$altoolPath" --upload-app -f "${upload_IpaPath}" -u "$appleid" -p "$applepassword"
#
##弹框通知提示上传结果状态
#if [ $? == 0 ] ; then
#say '恭喜,上传iTunes Connect成功!'
#osascript -e 'display notification "🎉🎉🎉 恭喜,上传iTunes Connect成功!!!" with title "提示"'
#else
#say '糟糕, 上传iTunes Connect失败!'
#osascript -e 'display notification "😰😰😰 糟糕, 上传iTunes Connect失败!!!" with title "提示"'
#fi

