#!/bin/bash

#工程名
App_Name="MutableTargetDemo"

#打包环境有: Dev02, Test04, Release

#打包环境
Config_Name=$1
Dev02="Dev02"
Test04="Test04"
Release="Release"

if [ $Config_Name ] ; then

    if [ $Config_Name = $Dev02 ] || [ $Config_Name = $Test04 ] || [ $Config_Name = $Release ] ; then
        echo "开始打包环境===========${Config_Name}==========="

    else

        #直到输入的环境为正确是,否则一直提示输入环境打包
        while [ $Config_Name ] && [ $Config_Name != $Dev02 ] && [ $Config_Name != $Test04 ] && [ $Config_Name != $Release ]
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

#==============================开始打包==============================
#打包时间
Date="$(date +%Y%m%d)"
#打包时间
Time="$(date +%Y%m%d%H%M%S)"
#工程info.plist路径
Project_Infoplist_Path="./${App_Name}/Info.plist"
#App版本号
AppVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" "${Project_Infoplist_Path}")
#归档路径
Archive_Path="./${App_Name}.xcarchive"
#ipa包路径
#Export_Path="./${Date}_ipa" #打包放在工程目录下
Export_Path="$HOME/Documents/ExportIpa/${App_Name}/${Date}_ipa" #打包放在Documents目录下
#ipa包路径
Temp_Ipa_Path="${Export_Path}/${App_Name}.ipa"
#改变包名称
Ipa_Path="${Export_Path}/${App_Name}_V${AppVersion}_${Config_Name}_${Time}.ipa"
#ExportOptions.Plist文件路径
ExportOptions_Path="./ExportOptions.plist"
#证书名称，提示：因为AdHoc证书也是从Distribution证书中创建的，所以这里不管打什么包的CodeSignIdentity都是一样的
CodeSignIdentity="iPhone Distribution: Shenzhen Okdeer Network Technology Co., Ltd. (W222R58V26)"

#提示：在ExportOptions.Plist文件中method的值，我们打包只设置app-store, ad-hoc这两种

if [ $Config_Name == $Release ] ; then
    #上架证书的UDID: Distribution
    ProvisioningProfileValue="3e37a002-63b3-41ab-bd9d-cfb2fc52c273"
    #设置打包method的值
    ExportOptionsMethodValue="app-store"
else
    #开发和测试的UDID：okdeerMallAdHoc
    ProvisioningProfileValue="8dd0e13e-fab3-4aef-8ba0-bef1eb5db5aa";
    #设置打包method的值
    ExportOptionsMethodValue="ad-hoc"
fi

echo "ProvisioningProfileValue的值:====${ProvisioningProfileValue}====${ExportOptionsMethodValue}"
#修改provisioningProfiles中method的值
/usr/libexec/PlistBuddy -c 'Set :method '$ExportOptionsMethodValue'' $ExportOptions_Path
#修改provisioningProfiles中Identity对应的值
/usr/libexec/PlistBuddy -c 'Set :provisioningProfiles:com.jhsys.cloudmall '$ProvisioningProfileValue'' $ExportOptions_Path


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
CODE_SIGN_IDENTITY="${CodeSignIdentity}" \
PROVISIONING_PROFILE="${ProvisioningProfileValue}"

#导出ipa
xcodebuild -exportArchive \
-archivePath "${Archive_Path}" \
-exportPath "${Export_Path}" \
-exportOptionsPlist "${ExportOptions_Path}"


#按日志格式设置ipa包名称
mv "${Temp_Ipa_Path}" "${Ipa_Path}"
#删除归档文件
rm -r -f "${Archive_Path}"
#清除shell日志
clear

echo
echo "\033[41;36m 恭喜: 🎉 🎉 🎉 ${Config_Name} 环境打包完成, 路径为:${Ipa_Path} \033[0m"
echo



#如果打包环境为Release，则只上传到iTunesConnect，否则就上传fir.im内测平台和企业重签名
#因为Release包为上架包，打出的包是无法安装到手机的，因此不需要上传到fir.im，也无需企业重签名

if [ $Config_Name == $Release ] ; then

    #==============================发布到iTunesConnect分两步 ==============================
    #学习上传命令: http://help.apple.com/itc/apploader/#/apdATD1E53-D1E1A1303-D1E53A1126
    echo "\033[41;36m ================= 正在iTunesConnect中验证ipa。。。 =================\033[0m"

    #altool工具路径 (这个是系统altool路径,是固定的)
    AltoolPath="/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool"
    #需要上传至iTunes Connect的本地ipa包地址, -->上传的是未重签名之前的包
    Upload_IpaPath="${Ipa_Path}"
    #开发者账号（邮箱）
    AppleId="app01@kingser.com"
    #开发者账号的密码
    ApplePassword="okdeerYsc.2312"

    #======1、验证ipa包是否成功======
    "$AltoolPath" --validate-app -f "${Upload_IpaPath}" -u "${AppleId}" -p "${ApplePassword}" --output-format xml

    #弹框通知提示验证ipa包结果状态
    if [ $? == 0 ] ; then
        echo "\033[41;36m ============ 验证ipa包成功, 开始上传至iTunes Connect============ \033[0m"
    else
        say '糟糕, iTunes Connect验证ipa包失败!'
        osascript -e 'display notification "😰😰😰 糟糕, 验证ipa包失败!!!" with title "提示"'
        exit 1
    fi


    ##======2.上传ipa包到iTunes Connect======
    #echo "\033[41;36m ================= 验证成功，正在往iTunesConnect上传。。。 =================\033[0m"
    #"$AltoolPath" --upload-app -f "${Upload_IpaPath}" -u "${AppleId}" -p "${ApplePassword}" --output-format xml
    #
    ##弹框通知提示上传结果状态
    #if [ $? == 0 ] ; then
        #say '恭喜,上传iTunes Connect成功!'
        #osascript -e 'display notification "🎉🎉🎉 恭喜,上传iTunes Connect成功!!!" with title "提示"'
        #echo "==========脚本执行结束啦，正常退出，此次打包环境：${Config_Name}，路径为:${Ipa_Path}=========="
    #else
        #say '糟糕, 上传iTunes Connect失败!'
        #osascript -e 'display notification "😰😰😰 糟糕, 上传iTunes Connect失败!!!" with title "提示"'
    #fi

else

    #============================== 开始重签名为企业包 ==============================
    #企业包重签名参考地址: http://www.jianshu.com/p/f4cfac861aac
    echo "\033[41;36m =========================== 开始重签名为企业包 ========================= \033[0m"

    Entitlements_full_Path="./entitlements_full.plist"
    # mobileprovision生成plist的路径
    Entitlements_Path="./entitlements.plist"
    # 配置文件的路径
    Mobileprovision_Path="./handlink_cer/lukeInHouse.mobileprovision"
    # 企业重签名证书名称
    Re_CODE_SIGN_DISTRIBUTION="iPhone Distribution: Shenzhen Huayitong Network Technology Co., Ltd."
    # 重签名ipa包存放路径
    Re_Ipa_Path="${Export_Path}/${App_Name}_V${AppVersion}_${Config_Name}_${Time}_reSign.ipa"

    # 生成plist文件
    security cms -D -i ${Mobileprovision_Path} > ${Entitlements_full_Path}
    /usr/libexec/PlistBuddy -x -c 'Print:Entitlements' ${Entitlements_full_Path} > ${Entitlements_Path}

    # 解压文件
    unzip "${Ipa_Path}"
    #拷贝配置文件到文件中
    cp "${Mobileprovision_Path}" \
    Payload/MutableTargetDemo.app/embedded.mobileprovision

    # 进行重签名
    codesign -f -s "${Re_CODE_SIGN_DISTRIBUTION}" \
    --entitlements "${Entitlements_Path}" \
    Payload/MutableTargetDemo.app/

    #压缩文件
    zip -r re_sign.ipa Payload
    #按日志格式重命名ipa包
    mv "./re_sign.ipa" "${Re_Ipa_Path}"
    #删除Payload解压文件夹
    rm -r -f ./Payload
    #删除归档BCSymbolMaps文件夹
    rm -r -f "./BCSymbolMaps"
    #打开签名ipa的文件夹
    open $Export_Path


    #============================== 开始上传fir.im内测平台 ==============================
    #fir学习地址：https://github.com/FIRHQ/fir-cli
    echo "\033[41;36m ======================== 重签名结束, 正在上传到fir.im内测平台 ======================== \033[0m"

    #Fir内测平台Token
    Fir_token="0f5fadc120ba74da84724e55434b28fb"
    #版本更新信息 (Upgrade_desc.txt 此文件为版本的更新描述,需要放在项目的.xcodeproj的同一级)
    UpgradeDesc=$(<Upgrade_desc.txt)
    #上传到fir, -->上传的是重签名之后的包
    fir publish "${Re_Ipa_Path}" -T "${Fir_token}" -c "${UpgradeDesc}"

    #弹框通知提示验证ipa包结果状态
    if [ $? == 0 ] ; then
        echo "\033[41;36m 🎉 🎉 🎉 恭喜: 上传fir.im成功！请到App内部点击安装或从Web端(http://fir.im/vlpc)下载最新版App \033[0m "
        #打开web下载页面
        open http://fir.im/vlpc
        echo "==========脚本执行结束，正常退出，此次打包环境：${Config_Name}，路径为:${Export_Path}=========="
    else
        say '糟糕, 上传fir.im失败!!!'
        osascript -e 'display notification "😰😰😰 糟糕, 上传fir.im失败!!!" with title "提示"'
        exit 1
    fi

fi



