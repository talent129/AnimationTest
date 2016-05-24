//
//  AnimationTwoViewController.m
//  AnimationTest
//
//  Created by iMac on 16/5/13.
//  Copyright © 2016年 Cai. All rights reserved.
//

#import "AnimationTwoViewController.h"

@interface AnimationTwoViewController ()

@property (nonatomic, strong) UIView *flipView;

@end

@implementation AnimationTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"转场效果动画";
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.flipView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 300, 200)];
    _flipView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.flipView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipAni)];
    [self.flipView addGestureRecognizer:tap];
    
}

- (void)flipAni
{
    [UIView beginAnimations:@"FlipAni" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(startAni:)];
    [UIView setAnimationDidStopSelector:@selector(stopAni:)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.flipView cache:YES];
    self.flipView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"weixin"]];
    [UIView commitAnimations];
}

- (void)startAni:(NSString *)aniID
{
    NSLog(@"%@ start", aniID);
}

- (void)stopAni:(NSString *)aniID
{
    NSLog(@"%@ stop", aniID);
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
