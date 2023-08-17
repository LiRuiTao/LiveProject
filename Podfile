install! 'cocoapods', :disable_input_output_paths => true
# Pod公共源
  source 'https://github.com/CocoaPods/Specs.git'

#需要iOS10.0及以上才能支持
platform :ios, '10.0'

target 'GXInteractionLive' do
    # 根据自己的业务场景，集成合适的音视频终端SDK
    # 如果您的App中还需要频短视频编辑功能，可以使用音视频终端全功能SDK（AliVCSDK_Premium），可以把本文件中的所有AliVCSDK_PremiumLive替换为AliVCSDK_Premium
    pod 'AliVCSDK_PremiumLive', '~> 6.2.0'

    # 互动SDK
    pod 'AlivcInteraction', '~> 1.1.0'

    # 基础UI组件
    pod 'AUIFoundation/All', '~> 1.8.0'

    #
    pod 'Masonry', '~> 1.1.0'
    pod 'MJRefresh', '~> 3.7.5'
    pod 'SDWebImage', '~> 5.16.0'
    
    # 美颜UI组件，如果终端SDK使用的是AliVCSDK_Premium，需要AliVCSDK_PremiumLive替换为AliVCSDK_Premium
    pod 'AUIQueenCom/AliVCSDK_PremiumLive', '~> 1.8.0'

end









