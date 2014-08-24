//
//  LoginGrade2VC.m
//  RemeberMe
//
//  Created by mxiaochi on 14-8-21.
//  Copyright (c) 2014年 ___NOTHING___. All rights reserved.
//

#import "LoginGrade2VC.h"
#import "UserLoginVC.h"

@interface LoginGrade2VC() <UITextFieldDelegate>

@property (nonatomic) UITextField *nameTextField;
@property (nonatomic) UITextField *pwdTextField;

@end

@implementation LoginGrade2VC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 8.f;
    self.view.backgroundColor = [UIColor concreteColor];
    [self addDismissButton];
    self.nameTextField = [self addTextField:@"Username" returnType:UIReturnKeyNext frame:CGRectMake(20, 40, 175, 30) sec:NO tag:0];
    self.pwdTextField = [self addTextField:@"Password"  returnType:UIReturnKeyDone frame:CGRectMake(20, 90, 175, 30) sec:YES tag:1];
    [self.nameTextField becomeFirstResponder];
}

- (UITextField *)addTextField:(NSString *)title returnType:(UIReturnKeyType)type frame:(CGRect)frame sec:(BOOL)is_sec tag:(int)tag{

    UITextField  *field = [UITextField new];
    field.autocapitalizationType = UITextAutocapitalizationTypeNone;
    field.autocorrectionType = UITextAutocorrectionTypeNo;
    field.backgroundColor = [UIColor whiteColor];
    field.textAlignment = NSTextAlignmentCenter;
    field.secureTextEntry = is_sec;
    field.layer.cornerRadius = 2.f;
    field.returnKeyType = type;
    field.placeholder = title;
    field.delegate = self;
    field.frame = frame;
    field.tag = tag;
    [self.view addSubview:field];
    return field;

}

#pragma mark - TextField Delete Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (!textField.tag) {
        [self.nameTextField resignFirstResponder];
        [self.pwdTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Private Instance methods

- (void)addDismissButton
{
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    dismissButton.tintColor = [UIColor whiteColor];
    dismissButton.titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:20];
    [dismissButton setTitle:@"Login" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dismissButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[dismissButton]-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(dismissButton)]];
}

- (void)dismiss:(id)sender
{
    
    NSDictionary *params = @{
                             @"name": self.nameTextField.text,
                             @"pwd": self.pwdTextField.text
                             };
    
    NSString *url = [NSString stringWithFormat:@"%@%@",GetConfigure(@"request_url",@"BaseURL",NO),
                     GetConfigure(@"request_url",@"UserLogin",NO)];
    [Tool postNetInfoWithPath:url andParams:params besidesBlock:^(id obj) {
        if ([obj[@"state"] isEqual:@"success"]) {
            [self dismissViewControllerAnimated:YES completion:^{
                [self.parentVC dismissViewControllerAnimated:YES completion:nil];
            }];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Login Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    } failure:nil];
}

@end
