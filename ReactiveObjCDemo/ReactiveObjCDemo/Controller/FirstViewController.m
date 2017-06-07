//
//  FirstViewController.m
//  ReactiveObjCDemo
//
//  Created by mao wangxin on 2017/5/19.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ReactiveObjC.h"
#import "OkView.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet OkView *redVied;
@property (weak, nonatomic) IBOutlet UIButton *testBtn;
@property (nonatomic, strong) RACCommand *command;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testSignalForSelector];
//    
//    //监听文本框的文字改变
//    [self testTextField];
//    
//    //代替通知
//    [self testNotification];
}


- (IBAction)btnAction:(UIButton *)sender
{
    //测试事件
    [self testRACMulticastConnection];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark -===========简单实用实例===========


/**
 * 监听文本框的文字改变
 */
- (void)testTextField
{
//    @weakify(self)
//    [_textField.rac_textSignal subscribeNext:^(id x) {
//        @strongify(self)
//        
//        NSLog(@"文字改变了%@",x);
//        self.textLabel.text = x;
//    }];
    
    //    //1. 只用宏监听文本改变:
        RAC(self.textLabel,text) = _textField.rac_textSignal;
    
    
    //2. 信号组合: 设置监听按钮是否可点击
        RAC(self.testBtn,enabled) = [RACSignal combineLatest:@[_textField.rac_textSignal] reduce:^(NSString *inputText1){
               BOOL status = (inputText1.length > 0);
            return @(status);
        }];
}


/**
 * testSignalMap
 */
- (void)testSignalMap
{
    [[_textField.rac_textSignal map:^id(id value) {
        // 当源信号发出，就会调用这个block，修改源信号的内容
        // 返回值：就是处理完源信号的内容。
        return [NSString stringWithFormat:@"输出:%@",value];
    }] subscribeNext:^(id x) {
        
        NSLog(@"subscribeNext====%@",x);
    }];
}



/**
 * 代替代理, 监听是否执行了方法
 */
- (void)replaceDelegate
{
    //返回的参数x, 是方法btn2Action所带参数的元组,RAC会把所有的参数数据包装成一个RACTuple
    [[_redVied rac_signalForSelector:@selector(btn2Action:)] subscribeNext:^(id x) {
        
        // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
        RACTupleUnpack(UIButton *btn) = x;
        NSLog(@"控制器中监听到按钮2被点击===%@===%@",x,btn);
        
    }];
    
        // 3.监听事件
        // 把按钮点击事件转换为信号，点击按钮，就会发送信号
        [[_testBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    
            NSLog(@"按钮2被点击了");
        }];
}


/**
 * 添加点击手势
 */
- (void)addGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        NSLog(@"响应手势===%@",x);
    }];
    [self.view addGestureRecognizer:tap];
}


/**
 * KVO
 */
- (void)testKVO
{
    // 把监听redV的center属性改变转换成信号，只要值改变就会发送信号
    // observer:可以传入nil
    [[_redVied rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:self] subscribeNext:^(id x) {

        NSLog(@"%@",x);
    }];
    
    
//    //kvo使用宏监听某个对象的某个属性,返回的是信号
//    [RACObserve(_redVied, center) subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];

}


/**
 * 代替通知
 */
- (void)testNotification
{
    // 把监听到的通知转换信号
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"键盘弹出===%@",x);
    }];
}


/**
 * 监听代理方法
 */
- (void)testSignalForSelector
{
    [[self.textField rac_signalForSelector:@selector(textFieldDidBeginEditing:)
                              fromProtocol:@protocol(UITextFieldDelegate)]
     subscribeNext:^(RACTuple * tuple) {
         NSLog(@"监听代理方法1===%@",tuple.first);
         NSLog(@"监听代理方法2===%@",tuple.second);
     }];
}

/**
 * RACTuple 元组类,类似NSArray,用来包装值.
 
 RACSequence:RAC中的集合类，用于代替NSArray,NSDictionary,可以使用它来快速遍历数组和字典。
 
 使用场景：1.字典转模型
 */
- (void)testRACTuple
{
        // 1.遍历数组
        NSArray *numbers = @[@1,@2,@3,@4];
    
        // 这里其实是三步
        // 第一步: 把数组转换成集合RACSequence numbers.rac_sequence
        // 第二步: 把集合RACSequence转换RACSignal信号类,numbers.rac_sequence.signal
        // 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来。
        [numbers.rac_sequence.signal subscribeNext:^(id x) {
    
            NSLog(@"%@",x);
        }];
    
    
    //2. 遍历字典,遍历出来的键值对会包装成RACTuple(元组对象)
    NSDictionary *dict = @{@"name":@"okdeer",@"age":@18};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        
        // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
        RACTupleUnpack(NSString *key,NSString *value) = x;
        
        // 相当于以下写法
        // NSString *key = x[0];
        // NSString *value = x[1];
        
        NSLog(@"%@ %@",key,value);
    }];
}

/**
 * RACSignal 信号类
 */
- (void)testRACSignal
{
    // 1.创建信号 -> (冷信号)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // block什么时候调用:当信号被订阅的时候就会调用
        // block作用:在这里面传递数据出去
        // 3.发送数据 -> (触发信号)
        [subscriber sendNext:@1];
        return nil;
    }];
    
    // 2.订阅信号 -> (热信号)
    [signal subscribeNext:^(id x) {
        // block什么时候调用:当信号内部,发送数据的时候,就会调用,并且会把值传递给你
        // block作用:在这个block中处理数据
        NSLog(@"信号传递出来的数据==%@",x);
    }];
    

        // 3.订阅取消信号
    RACDisposable *disposable = [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    // 取消订阅(主动取消)
    [disposable dispose];

}

#pragma mark -===========高级用法===========
/**
 * 处理多个请求，都返回结果的时候，统一做处理.
 */
- (void)testSignalsFromArray
{
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //做事情。。。
        // 发送请求1
        [subscriber sendNext:@"发送请求1"];
        return nil;
    }];
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //做事情。。。
        // 发送请求2
        [subscriber sendNext:@"发送请求2"];
        return nil;
    }];
    
    // 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1,request2]];
}


// 更新UI
- (void)updateUIWithR1:(id)data r2:(id)data1
{
    NSLog(@"更新UI%@  %@",data,data1);
}

/**
 RACSubject:信号提供者，自己可以充当信号，又能发送信号, 自定义信号
 
 使用场景:通常用来代替代理，有了它，就不必要定义代理了
 */
- (void)testRACSubject
{
    SecondViewController *vc = [[SecondViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.subject = [RACSubject subject];
    
    @weakify(self)
    [vc.subject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
        NSLog(@"已通知主页事件1===%@",x);
        self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
}


/**
 RACReplaySubject:重复提供信号类，RACSubject的子类。
 
 使用场景一:如果一个信号每被订阅一次，就需要把之前的值重复发送一遍，使用重复提供信号类。
 */
- (void)testReplaySubject
{
    // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 2.1订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第一个订阅者接收到的数据=%@",x);
    }];
    
    // 2.2订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第二个订阅者接收到的数据=%@",x);
    }];
    
    // 2.3订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第三个订阅者接收到的数据=%@",x);
    }];
    
    // 3.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
}

/**
 * RACMulticastConnection: 
 用于当一个信号，被多次订阅时，为了保证创建信号时，避免多次调用创建信号中的block，造成副作用，可以使用这个类处理
 */
- (void)testRACMulticastConnection
{
    // 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送请求");
        //发送信号
        [subscriber sendNext:@"网络数据"];
        
        return nil;
    }];
    // 2.把信号转换成连接类
    RACMulticastConnection *connect = [signal publish];
    // 3.订阅连接类的信号,注意:一定是订阅连接类的信号,不再是源信号
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"1======%@",x);
    }];
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"2=====%@",x);
    }];
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"3======%@",x);
    }];
    // 4.连接
    [connect connect];
}

/**
 * 信号的组队
 */
- (void)testMergeRACSignal
{
    //创建3个信号来模拟队列
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id subscriber) {
        [subscriber sendNext:@"喜欢一个人"];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *signalC = [RACSignal createSignal:^RACDisposable *(id subscriber) {
        [subscriber sendNext:@"直接去表白"];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *signalD = [RACSignal createSignal:^RACDisposable *(id subscriber) {
        [subscriber sendNext:@"成功在一起"];
        [subscriber sendCompleted];
        return nil;
    }];

    //连接组队列:将几个信号放进一个组里面,按顺序连接每个,每个信号必须执行sendCompleted方法后才能执行下一个信号
    RACSignal *signalGroup = [[signalB concat:signalC] concat:signalD];
    [signalGroup subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
//
//    //信号合并队列:当其中信号方法执行完后便会执行下个信号
//    [[RACSignal merge:@[signalB,signalC,signalD]] subscribeNext:^(id x) {
//        // code...
//    }];
}

/**
 * RACCommand
 */
- (void)testRACCommand
{
    // 一、RACCommand使用步骤:
    // 1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
    // 2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
    // 3.执行命令 - (RACSignal *)execute:(id)input
    
    // 二、RACCommand使用注意:
    // 1.signalBlock必须要返回一个信号，不能传nil.
    // 2.如果不想要传递信号，直接创建空的信号[RACSignal empty];
    // 3.RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted]，这时命令才会执行完毕，否则永远处于执行中。
    // 4.RACCommand需要被强引用，否则接收不到RACCommand中的信号，因此RACCommand中的信号是延迟发送的。
    
    // 三、RACCommand设计思想：内部signalBlock为什么要返回一个信号，这个信号有什么用。
    // 1.在RAC开发中，通常会把网络请求封装到RACCommand，直接执行某个RACCommand就能发送请求。
    // 2.当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候就需要通过signalBlock返回的信号传递了。
    
    // 四、如何拿到RACCommand中返回信号发出的数据。
    // 1.RACCommand有个执行信号源executionSignals，这个是signal of signals(信号的信号),意思是信号发出的数据是信号，不是普通的类型。
    // 2.订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅signalBlock返回的信号，就能获取发出的值。
    
    // 五、监听当前命令是否正在执行executing
    
    // 六、使用场景,监听按钮点击，网络请求
    
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"执行命令");
        
        // 创建空信号
        // return [RACSignal empty];
        
        // 2.创建信号,用来传递数据
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"请求数据"];
            
            // 注意：数据传递完，最好调用sendCompleted，这时命令才执行完毕。
            [subscriber sendCompleted];
            
            return nil;
        }];
        
    }];
    
    _command = command;
    
    
    // 3.执行命令
    [self.command execute:@1];
    
    // 4.订阅RACCommand中的信号
    [command.executionSignals subscribeNext:^(id x) {
        
        [x subscribeNext:^(id x) {
            
            NSLog(@"订阅RACCommand中的信号=====%@",x);
        }];
        
    }];
    
    // RAC高级用法
    // switchToLatest:用于signal of signals，获取signal of signals发出的最新信号,也就是可以直接拿到RACCommand中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        
        NSLog(@"switchToLatest===%@",x);
    }];
    
    // 5.监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。
    [[command.executing skip:1] subscribeNext:^(id x) {
        
        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");
            
        }else{
            // 执行完成
            NSLog(@"执行完成");
        }
        
    }];
}

//API中类的定义
//http://www.cocoachina.com/ios/20160729/17236.html

//http://www.tuicool.com/articles/e2Q7beN
@end
