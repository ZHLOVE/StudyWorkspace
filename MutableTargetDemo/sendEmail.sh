
#首先需要安装sendemail，使用命令：brew install sendemail

#命令主程序
#/usr/local/bin/sendEmail

#发件人邮箱的用户名,(不知道这里为什么用户名一定要写邮箱地址，否则发送失败)
SendUserName="18676730583@163.com"
#发件人邮箱
SendAddress="18676730583@163.com"
#发件人邮箱密码
SendAddressPwd="******"
#发件人邮箱的smtp服务器:email.okdeer.com （smtp.163.com）
EmailServer="smtp.163.com"
#收件箱
ReceiveAddress="502643810@qq.com"
#邮件内容格式
EmailType="message-content-type=html"
#邮件内容编码
EmailCharset="message-charset=utf-8"
#邮件的标题
EmailTitle="iOS端发新测试包啦_Beta1.0"

#SendEmail标题中文乱码问题  http://blog.chinaunix.net/uid-29787409-id-5607573.html
Email_Title_gb2312=`iconv -t GB2312 -f UTF-8 << EOF
$EmailTitle`
[ $? -eq 0 ] && Email_Title="$Email_Title_gb2312"

#邮件的具体内容
EmailContent="我是邮件的具体内容"

#脚本参数传入附件地址
Ipa_path=$1
if [ $Ipa_path ] ; then
    Attachment_path=$Ipa_path
else
    Attachment_path="./Upgrade_desc.txt"
fi


/usr/local/bin/sendEmail \
-xu "${SendUserName}" \
-f "${SendAddress}" \
-xp "${SendAddressPwd}" \
-s "${EmailServer}" \
-t "${ReceiveAddress}" \
-o "${EmailType}" \
-m "${EmailContent}" \
-o "${EmailCharset}" \
-u "${Email_Title}" \
-a "${Attachment_path}"


if [ $? == 0 ] ; then
    echo "==========发送邮成功！！=========="
else
    echo "==========发送邮失败！！=========="
fi
