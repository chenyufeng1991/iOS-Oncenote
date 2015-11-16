
## ShareSDK文件包含：

**1、libraries（ShareSDK类库），其中包含：**

     1. extends：第三方平台SDK。（不需要的平台的SDK可直接移除）
     2. MOBFoundation.framework：基础功能框架。（必要）
     3. ShareSDK.bundle：ShareSDK资源文件。（必要）
     4. ShareSDK.framework：核心静态库。（必要）
     5. ShareSDKConnector.framework：用于ShareSDK框架与外部框架连接的代理框架插件。使用第三方SDK时必要。
     
     6. ShareSDKExtension.framework：对ShareSDK功能的扩展框架插件。目前主要提供第三方平台登录、一键分享、截屏分享、摇一摇分享等相关功能。需要使用以上功能时必要。
     7.ShareSDKInterfaceAdapter.framework：ShareSDK v2.x对简洁版的接口兼容包。(建议直接使用简洁版接口，尽量不使用这个兼容包)
     8. ShareSDKUI.bundle：分享菜单栏和分享编辑页面资源包。（如果自定义这些UI可直接移除）
     9. ShareSDKUI.framework：分享菜单栏和分享编辑页面。（如果自定义这些UI可直接移除）

**2、Demo（包含Objective-C、swift版示例Demo）**
 
**3、doc（包含Objective-C、swift版集成文档和新功能介绍）**

官方下载地址和文档：http://www.mob.com/#/downloadDetail/ShareSDK/ios
