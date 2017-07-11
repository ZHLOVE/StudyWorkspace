workspace 'StudyWorkspace'

#每个工程添加pod步骤1:->添加需要使用的工程和路径
project 'ReactiveObjCDemo/ReactiveObjCDemo.xcodeproj'
project 'PodsDemo/PodsDemo.xcodeproj'
project 'DrawDemo/DrawDemo.xcodeproj'
project 'CommonFrameWork/CommonFrameWork.xcodeproj'
project 'TimeLineDemo/TimeLineDemo.xcodeproj'

#步骤2:->添加工程的target, 和xcodeproj文件所在的项目路径
target :'ReactiveObjCDemo' do
#    use_frameworks!
    platform :ios, '8.0'
#    pod 'ReactiveObjC' //在主库中已经添加了（CommonFrameWork）
    project 'ReactiveObjCDemo/ReactiveObjCDemo.xcodeproj'
end


target :'PodsDemo' do
    platform :ios, '7.0'
    project 'PodsDemo/PodsDemo.xcodeproj'
end


target :'DrawDemo' do
    platform :ios, '7.0'
    pod 'Masonry'
    project 'DrawDemo/DrawDemo.xcodeproj'
end

target :'TimeLineDemo' do
    platform :ios, '8.0'
    project 'TimeLineDemo/TimeLineDemo.xcodeproj'
end


target :'CommonFrameWork' do
    platform :ios, '7.0'
    pod 'AFNetworking'
    pod 'SDWebImage'
    pod 'FMDB'
    pod 'MJRefresh'
    pod 'MJExtension'
    pod 'MBProgressHUD'
    pod 'ReactiveCocoa'
    project 'CommonFrameWork/CommonFrameWork.xcodeproj'
end
