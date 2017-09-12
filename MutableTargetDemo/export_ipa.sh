
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

##==============================打包结束 End==============================

echo "\033[41;36m ========================正在上传fir.im内测平台======================== \033[0m"

Fir_API_Token="0f5fadc120ba74da84724e55434b28fb"

#登录Fir内测平台
fir login -T $Fir_API_Token

#上传ipa测试包到Fir内测平台
fir publish $Rename_Path

echo "\033[41;36m 恭喜！！！🎉 🎉 🎉  上传fir.im成功！, 请到App内部点击安装最新版App. \033[0m "


