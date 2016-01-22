# iOS-Oncenote
&emsp;&emsp;&nbsp;这是一款类似于印象笔记Evernote的生活类iOS应用——朝夕笔记 Oncenote。我希望能为更多的iOS开发者提供帮助与服务。当然App中还有不少bug和可扩展的功能模块，也希望各位开发者为该项目贡献自己的code力量。大家可以通过点击右上角的fork到自己的Github仓库，也可以点击star实时关注项目进度。
##1.项目简介
&emsp;&emsp;&nbsp;该应用基本实现了一款笔记类应用的所有基本功能，如使用手机号进行注册登录以及短信验证；密码昵称以及个人资料的修改；笔记的增删改查等功能和笔记分享功能。其中最重要的是使用了[Bmob移动后端云](http://www.bmob.cn/)作为应用的服务器。对于开发者来说，Bmob可以快速架构应用的服务器后台和数据库，几乎能免去所有服务器端编码工作量。让你的所有个人资料和笔记资料保存在云端，能够随时的对数据进行访问。这可以让你在不同的iOS设备上对自己的笔记进行管理与同步，实现了一款真正可使用的App。</br>
&emsp;&emsp;&nbsp;注意下：该项目我使用Cocoapods进行第三方包管理的，并且在Xcode7下进行开发。运行程序前需要先安装好Cocoapods，并在在项目根目录下执行pod install,pod update命令，来加载更新第三方包。由于Xcode不同版本原因，也建议升级到Xcode7下调试程序。有多人反映说项目编译不成功或者运行时报错，经本人多次测试，代码是没有问题的。原因可能是Xcode版本不同问题或者Cocoapods更新问题。想要了解如何安装Cocoapods，请参考[《iOS包管理工具Cocoapods的安装与使用》](http://blog.csdn.net/chenyufeng1991/article/details/47432299)这篇博客。如果有任何问题，请及时与我联系。还不能进行发布。</br>
&emsp;&emsp;&nbsp;其中我还留出多个接口可供大家开发其他模块：照片功能、提醒功能和群聊功能等等。之后我还会适配到Apple Watch上。如果你有好的idea，也可以在App里面实现。希望在更多开发者的共同努力下，把这个应用开发成一个优秀的产品。让我们一起来超越印象笔记吧！。系统主界面如下：</br> 
![Alt text](https://github.com/chenyufeng1991/iOS-Oncenote/raw/master/Screenshots/1.png)
##2.开发指南
###(1)Bmob后端云简介
&emsp;&emsp;&nbsp;Bmob后端云官网：[http://www.bmob.cn/](http://www.bmob.cn/).大家可以去注册一个账号，然后进入我的控制台，然后就可以创建应用进行开发了。Bmob非常方便的集成了数据库，你可以可视化的对数据库进行操作和管理。我将在Bmob存储用户信息和笔记资料，并对用户和笔记进行增删改查操作。为了便于开发，大家也可以去学习使用一下Bmob。</br>
![Alt text](https://github.com/chenyufeng1991/iOS-Oncenote/raw/master/Screenshots/2.png)
###(2)数据库设计
&emsp;&emsp;&nbsp;目前我的数据库中有2张表。分别是_User表和Note表。这是最简单的数据库设计，大家也可以根据自己的需求设计。数据库设计如下：
######1）_User表
objectId:String</br>
username:String</br>
password:String</br>
mobilePhoneNumberVerified:Boolean</br>
mobilePhoneNumber:String</br>
nickname:String</br>
Password:String</br>
emailVerified:Boolean</br>
email:String</br>
authData:authData</br>
createdAt:Date</br>
updatedAt:Date</br>
ACL:ACL
######1）Note表
objectId:String</br>
userId:String</br>
noteText:String</br>
noteTitle:String</br>
username:String</br>
createdAt:Date
###(3)短信验证
&emsp;&emsp;&nbsp;为了防止用户的恶意注册和无效账户，该应用使用手机号进行验证并登陆。一个手机号对应一个账户，不能进行重复注册。其中短信验证接口我使用了mob移动开发者服务平台：[http://www.mob.com/#/index](http://www.mob.com/#/index)中的短信验证码SDK。里面包含了不错的SDK和demo，大家可以研究和试玩一下。但是要注意，进行短信验证时，一个手机号码12小时内只能发送5条验证短信，24小时内只能发送10条验证短信，规定时间内超过该额度就不能收到验证短信了。同时在进行验证的时候，无论你验证输入正确与否，你只能在服务器端验证一次。第二次即使你验证码输入正确，也不能验证成功。这就是短信验证的机制。</br>
![Alt text](https://github.com/chenyufeng1991/iOS-Oncenote/raw/master/Screenshots/3.png)
###(4)分享功能
&emsp;&emsp;&nbsp;在该应用中，你可以把笔记分享到QQ好友、QQ空间、微信好友、微信朋友圈、微信收藏、新浪微博、邮件、短信等等。同样的，分享接口我也使用了mob移动开发者服务平台：[http://www.mob.com/#/index](http://www.mob.com/#/index)中的ShareSDK社会化分享。ShareSDK可以分享到国内外主流的几十个社交平台。配置和开发也非常的方便，几十行代码即可。里面也包含了不错的SDK和demo，大家可以研究和试玩一下。</br>
![Alt text](https://github.com/chenyufeng1991/iOS-Oncenote/raw/master/Screenshots/4.png)
###(5)笔记功能
&emsp;&emsp;&nbsp;笔记功能当然是该应用的核心功能了。一条笔记包括了标题、正文和创建时间。当你打开App的时候，自动会从服务器同步下你的所有笔记。你可以随时增加一条笔记、删除一条笔记、修改笔记等操作，在服务器端也能进行实时的备份与更新。默认在主界面会显示3条笔记，在全部界面显示所有笔记，在全部界面可以删除笔记。
###(6)其他业务逻辑
&emsp;&emsp;&nbsp;在App中还包括了其他比较繁琐的业务逻辑，比如：
######1）引导页
&emsp;&emsp;&nbsp;第一次在手机上安装App时会出现引导页，这和其他App是一样的。之后就再也不会出现引导页了，除非你重新安装。
######2）登录
&emsp;&emsp;&nbsp;用户成功登录一次后，以后每次都可以直接登录自己App账户，而不会再出现登录界面。除非用户在App中点击了退出登录按钮。
######3）忘记密码
&emsp;&emsp;&nbsp;忘记密码功能使用了同样的短信验证机制，如果用户还未注册，需要先注册，然后才能重置密码。
##3.开发建议
&emsp;&emsp;&nbsp;通过查看主界面可以知道，照片功能、提醒功能、群聊功能还没有实现，大家如果有其他比较好的实现方式，也可以进行体现。如果找到了bug，欢迎fix it。希望这个开源项目可以在大家的努力下越来越好,期待你的code。
##4.运行效果
###(1)引导页
![Alt text](https://github.com/chenyufeng1991/iOS-Oncenote/raw/master/Screenshots/5.png)</br></br>
![Alt text](https://github.com/chenyufeng1991/iOS-Oncenote/raw/master/Screenshots/6.png)
###(2)登录界面
![Alt text](https://github.com/chenyufeng1991/iOS-Oncenote/raw/master/Screenshots/7.png)
###(3)注册界面
![Alt text](https://github.com/chenyufeng1991/iOS-Oncenote/raw/master/Screenshots/8.png)
###(4)主界面
![Alt text](https://github.com/chenyufeng1991/iOS-Oncenote/raw/master/Screenshots/9.png)
###(5)所有笔记界面
![Alt text](https://github.com/chenyufeng1991/iOS-Oncenote/raw/master/Screenshots/10.png)
###(6)笔记详情界面
![Alt text](https://github.com/chenyufeng1991/iOS-Oncenote/raw/master/Screenshots/11.png)
###(7)设置界面
![Alt text](https://github.com/chenyufeng1991/iOS-Oncenote/raw/master/Screenshots/12.png)
##5.技术博客
我的个人技术博客：[http://blog.csdn.net/chenyufeng1991](http://blog.csdn.net/chenyufeng1991) 。欢迎大家访问！
