workspace 'StudyWorkspace'

#每个工程添加pod步骤1:->添加需要使用的工程和路径
project 'PodsDemo/PodsDemo.xcodeproj'
project 'CommonFrameWork/CommonFrameWork.xcodeproj'

#步骤2:->添加工程的target, 和xcodeproj文件所在的项目路径
target :'PodsDemo' do
    platform :ios, '7.0'
    pod 'AFNetworking'
    pod 'SDWebImage'
    pod 'FMDB', '~> 2.6.2'
    pod 'MJRefresh'
    project 'PodsDemo/PodsDemo.xcodeproj'
end


target :'DrawDemo' do
    platform :ios, '7.0'
    pod 'Masonry'
    project 'DrawDemo/DrawDemo.xcodeproj'
end


target :'CommonFrameWork' do
    platform :ios, '7.0'
    pod 'AFNetworking'
    pod 'SDWebImage'
    pod 'FMDB', '~> 2.6.2'
    pod 'MJRefresh'
    pod 'MBProgressHUD', '~> 1.0.0'
    project 'CommonFrameWork/CommonFrameWork.xcodeproj'
end
