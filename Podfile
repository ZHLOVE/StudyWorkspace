workspace 'StudyWorkspace'

#每个工程添加pod步骤1:->添加需要使用的工程和路径
xcodeproj 'PodsDemo/PodsDemo.xcodeproj'

#步骤2:->添加工程的target, 和xcodeproj文件所在的项目路径
target :'PodsDemo' do
platform :ios, '7.0'
pod 'AFNetworking'
pod 'SDWebImage'
pod 'FMDB', '~> 2.6.2'
pod 'MJRefresh', '~> 3.1.12'
xcodeproj 'PodsDemo/PodsDemo.xcodeproj'
end


target :'CommonFrameWork' do
    platform :ios, '7.0'
    pod 'AFNetworking'
    pod 'SDWebImage'
    pod 'FMDB', '~> 2.6.2'
    pod 'MJRefresh', '~> 3.1.12'
    xcodeproj 'CommonFrameWork/CommonFrameWork.xcodeproj'
end
