#参考
#http://www.360du.net.cn/kuaizhao.asp?m=9f65cb4a8c8507ed4fece763105392230e54f73e628c8c4823838448e435061e5a71e2cf65351172d0ce767344f2090ae5ab6b33200250bd8cc8f90d8be0c43f2ef83042720bf03605a313b8ba40&p=8b2a9700c79111a058ee9368490da5&newp=8b2a9715d9c342a84bb1c52a4752cd231610db2151d6d701298ffe0cc4241a1a1a3aecbf26221300d4cf7b6601ac4e58ecf23378350834f1f689df08d2ecce7e&user=baidu&fm=sc&query=ios8+udid%D0%DE%B8%C4&qid=8023a8c30000dc4f&p1=11
#http://www.jianshu.com/p/f4cfac861aac
#代码签名探析
#https://objccn.io/issue-17-2/

#//如果提示找不到,则需要另外创建一份entitlements.plist路径
#//创建方法：
#$security cms -D -i 你要签名的mobileprovision路径 > t_entitlements_full.plist
#$/usr/libexec/PlistBuddy -x -c 'Print:Entitlements' t_entitlements_full.plist > t_entitlements.plist


unzip XXX.ipa
cp XXXX.mobileprovision  Payload/XXX.app/embedded.mobileprovision

codesign -f -s "iPhone Distribution: XXXX"  --entitlements entitlements.plist  Payload/XXX.app/ 
zip -r New.ipa Payload
#注 XXXX.mobileprovision iPhone Distribution: XXXX entitlements.plist 是要保持一致的
#  XXXX.mobileprovision  app的配置文件
#  iPhone Distribution: XXXX 发布证书
#  entitlements.plist 根据XXXX.mobileprovision生成的plist
