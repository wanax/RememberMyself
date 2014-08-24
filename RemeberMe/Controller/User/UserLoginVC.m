//
//  UserLoginVC.m
//  RemeberMe
//
//  Created by mxiaochi on 14-8-21.
//  Copyright (c) 2014年 ___NOTHING___. All rights reserved.
//

#import "UserLoginVC.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import "LoginGrade2VC.h"
#import "UserRegisterVC.h"

@interface UserLoginVC() <UIViewControllerTransitioningDelegate>

@property (nonatomic) LoginGrade2VC *login2VC;
@property (nonatomic) UserRegisterVC *registerVC;

@end

@implementation UserLoginVC


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cloudsColor];
    
    self.login2VC = [LoginGrade2VC new];
    self.login2VC.transitioningDelegate = self;
    self.login2VC.modalPresentationStyle = UIModalPresentationCustom;
    self.login2VC.parentVC = self;
    
    self.registerVC = [UserRegisterVC new];
    self.registerVC.transitioningDelegate = self;
    self.registerVC.modalPresentationStyle = UIModalPresentationCustom;
    
    
    [self addLogo];
    [self addLoginButton];
    [self addRegsiterButton];
    [self addLabel];
    
}

- (void)addLoginButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Login" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor customBlueColor]];
    [button setTitleColor:[UIColor customBlueColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttongTouched:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(20, 400, 280, 40);
    button.layer.cornerRadius = 2;
    [self.view addSubview:button];
    
}

- (void)addRegsiterButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Register Now" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor concreteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(buttongTouched:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(20, 450, 280, 40);
    button.layer.cornerRadius = 2;
    [self.view addSubview:button];
    
}

- (void)buttongTouched:(UIButton *)button {
    
    NSString *title = button.titleLabel.text;
    if ([title isEqualToString:@"Login"]) {
        
        [self presentViewController:self.login2VC animated:YES completion:nil];
    } else if ([title isEqualToString:@"Register Now"]) {
        
        [self presentViewController:self.registerVC animated:YES completion:nil];
    }
}

- (void)addLabel {
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"Avenir-Light" size:20];
    label.textColor = [UIColor blackColor];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = @"RememberMyself";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:label
                              attribute:NSLayoutAttributeCenterX
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeCenterX
                              multiplier:1
                              constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:label
                              attribute:NSLayoutAttributeCenterY
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeCenterY
                              multiplier:0.9
                              constant:0]];
    
}

- (void) addLogo {
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo2"]];
    imgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imgView];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:imgView
                              attribute:NSLayoutAttributeCenterX
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeCenterX
                              multiplier:1
                              constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:imgView
                              attribute:NSLayoutAttributeCenterY
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeCenterY
                              multiplier:0.5
                              constant:0]];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissingAnimator new];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
