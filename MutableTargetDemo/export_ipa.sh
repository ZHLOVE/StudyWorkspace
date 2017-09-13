
#1.工程名
App_Name="MutableTargetDemo"

# 打包的文件名
IPAAPP_NAME="MutableTargetDemo"

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
Export_Path="./${Date}_ipa"

#Plist文件路径
Plist_Path="./ExportOptionsPlist.plist"

#签名证书
CODE_SIGN_DISTRIBUTION="iPhone Distribution: Shenzhen Okdeer Network Technology Co., Ltd."

#清缓存
xcodebuild clean -scheme "${App_Name}" -configuration "${Config_Name}"

#archive
xcodebuild archive -scheme "${App_Name}" -archivePath "${Archive_Path}" -configuration "${Config_Name}"

#导出ipa
xcodebuild -exportArchive -archivePath "${Archive_Path}" -exportPath "${Export_Path}" -exportOptionsPlist "${Plist_Path}"

Rename_Path="${Export_Path}/${Config_Name}_${Time}.ipa"

#按日志格式重命名ipa包
mv "${Export_Path}/${App_Name}.ipa" $Rename_Path

#删除归档文件
rm -r -f $Archive_Path

#清除日志
clear

#打开文件夹
open $Export_Path

echo
echo "恭喜: 🎉 🎉 🎉   \033[41;36m ${Config_Name} \033[0m 环境, 打包完成, 路径为: ${Rename_Path}"
echo
echo "\033[41;36m ===========================打包结束, 开始重签名 start========================= \033[0m"


#重签名参考地址: http://www.jianshu.com/p/f4cfac861aac


entitlements_full_Path="./entitlements_full.plist"
# mobileprovision生成plist的路径
entitlements_Path="./entitlements.plist"
# 配置文件的路径
mobileprovision_Path="./handlink_cer/lukeInHouse.mobileprovision"
# 重签名证书名称
re_CODE_SIGN_DISTRIBUTION="iPhone Distribution: Shenzhen Huayitong Network Technology Co., Ltd."
# 重签名ipa文件名
re_IPANAME="re_${IPAAPP_NAME}_${Time}.ipa"
# 重签名ipa文件存放路径
re_IPA_PATH="$HOME/Documents/saveOkdeerAppIpa/${IPAAPP_NAME}/${bundleShortVersion}/${DATE}/${re_IPANAME}"

# 生成plist文件
security cms -D -i ${mobileprovision_Path} > ${entitlements_full_Path}
/usr/libexec/PlistBuddy -x -c 'Print:Entitlements' ${entitlements_full_Path} > ${entitlements_Path}

# 进行重签名
# 解压文件
unzip $Rename_Path
#拷贝配置文件到文件中
cp  ${mobileprovision_Path}  Payload/MutableTargetDemo.app/embedded.mobileprovision
# 进行签名
codesign -f -s "${re_CODE_SIGN_DISTRIBUTION}"  --entitlements ${entitlements_Path}  Payload/MutableTargetDemo.app/
#压缩文件
zip -r new.ipa Payload

echo "\033[41;36m ========================重签名结束, 开始上传fir.im内测平台======================== \033[0m"
#Fir内测平台Token
Fir_API_Token="0f5fadc120ba74da84724e55434b28fb"

#登录Fir内测平台
fir login -T $Fir_API_Token

#上传ipa测试包到Fir内测平台
#fir publish $Rename_Path
fir publish "./new.ipa"

echo "\033[41;36m 恭喜！！！🎉 🎉 🎉  上传fir.im成功！, 请到App内部点击安装最新版App. \033[0m "

#ipa包下载地址: http://fir.im/vlpc
echo "ipa下载地址: \033[31m http://fir.im/vlpc \033[0m"

open http://fir.im/vlpc




#echo "-------------- 重签名 end --------------"
## 更改文件名  和移动文件
#mv ./"new.ipa"  ./"${re_IPANAME}"
#mv  ./"${APP_NAME}.ipa"  ./"${IPANAME}"
#mv  ./"${IPANAME}"    "${IPA_PATH}"
#mv  ./"${re_IPANAME}"  "${re_IPA_PATH}"
#echo "-------------- rmove start ------------------"
#rm -r -f ./Release-iphoneos
## 下面两个只有不是用Cocopods方法才会产生的文件夹的
#rm -r -f ./Build
#rm -r -f ./Payload
#rm -r -f ./Symbols
#rm -f -f  "${entitlements_full_Path}"
#rm -r -f "${entitlements_Path}"
#rm -r -f ./"${APP_NAME}.build"
#rm -r -f ./"${archive_Path}"
#echo "------------- rmove success -----------------"
#
#echo ${IPA_PATH}


