//
//  AnimationViewController.m
//  AnimationTest
//
//  Created by iMac on 16/5/13.
//  Copyright © 2016年 Cai. All rights reserved.
//

/*
 UIView动画：实质上是对CoreAnimation的封装，提供简洁的动画接口
    UIView动画可以设置的动画属性：
    1、大小变化（frame）
    2、拉伸变化（bounds）
    3、中心位置（center）
    4、旋转（transform）
    5、透明度（alpha）
    6、背景颜色（backgroundColor）
    7、拉伸内容（contentStretch）
 
 1）动画的开始和结束方法：
    开始标记：
 
 + (void)beginAnimations:(nullable NSString *)animationID context:(nullable void *)context;  // additional context info passed to will start/did stop selectors. begin/commit can be nested
 2）结束动画标记：
 + (void)commitAnimations;                                                 // starts up any animations when the top level animation is commited
 
 // no getters. if called outside animation block, these setters have no effect.
 3）动画代理对象
 + (void)setAnimationDelegate:(nullable id)delegate;                          // default = nil
 4）动画将开始时代理对象执行的SEL
 + (void)setAnimationWillStartSelector:(nullable SEL)selector;                // default = NULL. -animationWillStart:(NSString *)animationID context:(void *)context
 5）动画结束时代理对象执行的SEL
 + (void)setAnimationDidStopSelector:(nullable SEL)selector;                  // default = NULL. -animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
 6）动画持续时间
 + (void)setAnimationDuration:(NSTimeInterval)duration;              // default = 0.2
 7）动画延迟执行的时间
 + (void)setAnimationDelay:(NSTimeInterval)delay;                    // default = 0.0
 + (void)setAnimationStartDate:(NSDate *)startDate;                  // default = now ([NSDate date])
 设置动画的曲线
 + (void)setAnimationCurve:(UIViewAnimationCurve)curve;              // default = UIViewAnimationCurveEaseInOut
 动画重复次数
 + (void)setAnimationRepeatCount:(float)repeatCount;                 // default = 0.0.  May be fractional
 设置动画是否继续执行相反的动画
 + (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses;    // default = NO. used if repeat count is non-zero
 设置是否从当前状态开始播放动画
 假设上一个动画正在播放，且尚未播放完毕，我们将要进行一个新的动画
 当为YES时：动画将从一个动画所在的状态开始播放
 当为NO时：动画将从上一个动画所指定的最终状态开始播放（此时上一个动画马上结束）
 + (void)setAnimationBeginsFromCurrentState:(BOOL)fromCurrentState;  // default = NO. If YES, the current view position is always used for new animations -- allowing animations to "pile up" on each other. Otherwise, the last end state is used for the animation (the default).
 设置视图的过度效果
 第二个参数：需要过渡效果的view
 第三个参数：是否使用视图缓存,YES：视图在开始和结束时渲染一次；NO：视图在每一帧都渲染
 + (void)setAnimationTransition:(UIViewAnimationTransition)transition forView:(UIView *)view cache:(BOOL)cache;  // current limitation - only one per begin/commit block
 是否禁用动画效果（对象属性依然会改变， 只是没有动画效果）
 + (void)setAnimationsEnabled:(BOOL)enabled;                         // ignore any attribute changes while set.
 + (BOOL)areAnimationsEnabled;
 + (void)performWithoutAnimation:(void (^)(void))actionsWithoutAnimation NS_AVAILABLE_IOS(7_0);
 
 + (NSTimeInterval)inheritedAnimationDuration NS_AVAILABLE_IOS(9_0);
 */


#import "AnimationViewController.h"
#import "AnimationTwoViewController.h"

@interface AnimationViewController ()

@property (nonatomic, strong) UIImageView *cartCenter;
@property (nonatomic, strong) UIImageView *centerShow;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"动画效果";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.centerShow = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 300, 200)];
    self.centerShow.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.centerShow];
    
    self.cartCenter = [[UIImageView alloc] initWithFrame:CGRectMake(20, 350, 150, 100)];
    self.cartCenter.userInteractionEnabled = YES;
    self.cartCenter.image = [UIImage imageNamed:@"alipay"];
    [self.view addSubview:self.cartCenter];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeFrame)];
    [self.cartCenter addGestureRecognizer:tap];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor purpleColor];
    btn.frame = CGRectMake(200, 350, 150, 30);
    [btn setTitle:@"点击进入下一视图" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)changeFrame {
    [UIView beginAnimations:@"FrameAni" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(startAni:)];
    [UIView setAnimationDidStopSelector:@selector(stopAni:)];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.cartCenter.frame = self.centerShow.frame;
    [UIView commitAnimations];
}

- (void)startAni:(NSString *)aniID {
    NSLog(@"%@ start",aniID);
}

- (void)stopAni:(NSString *)aniID {
    NSLog(@"%@ stop",aniID);
}

- (void)btnAction
{
    AnimationTwoViewController *two = [[AnimationTwoViewController alloc] init];
    [self.navigationController pushViewController:two animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
