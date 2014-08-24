//
//  UserRegisterVC.m
//  RemeberMe
//
//  Created by mxiaochi on 14-8-21.
//  Copyright (c) 2014年 ___NOTHING___. All rights reserved.
//

#import "UserRegisterVC.h"

@interface UserRegisterVC() <UITextFieldDelegate>

@property (nonatomic) UITextField *nameTextField;
@property (nonatomic) UITextField *pwdTextField;
@property (nonatomic) UITextField *emailTextField;

@end

@implementation UserRegisterVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 8.f;
    self.view.backgroundColor = [UIColor concreteColor];
    [self addDismissButton];
    self.nameTextField = [self addTextField:@"Username" returnType:UIReturnKeyNext frame:CGRectMake(20, 30, 175, 30) sec:NO tag:10];
    self.pwdTextField = [self addTextField:@"Password"  returnType:UIReturnKeyNext frame:CGRectMake(20, 80, 175, 30) sec:YES tag:11];
    self.emailTextField = [self addTextField:@"Email"  returnType:UIReturnKeyDone frame:CGRectMake(20, 130, 175, 30) sec:NO tag:12];
    [self.nameTextField becomeFirstResponder];
}

- (UITextField *)addTextField:(NSString *)title returnType:(UIReturnKeyType)type frame:(CGRect)frame sec:(BOOL)is_sec tag:(int)tag{
    
    UITextField  *field = [UITextField new];
    field.autocapitalizationType = UITextAutocapitalizationTypeNone;
    field.autocorrectionType = UITextAutocorrectionTypeNo;
    field.backgroundColor = [UIColor whiteColor];
    field.textAlignment = NSTextAlignmentCenter;
    field.secureTextEntry = is_sec;
    field.layer.cornerRadius = 2.5f;
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
    if (textField.tag != 12) {
        [textField resignFirstResponder];
        UITextField *view = (UITextField *)[self.view viewWithTag:textField.tag + 1];
        [view becomeFirstResponder];
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
    [dismissButton setTitle:@"Register" forState:UIControlStateNormal];
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
                             @"pwd": self.pwdTextField.text,
                             @"email": self.emailTextField.text
                             };
    
    NSString *url = [NSString stringWithFormat:@"%@%@",GetConfigure(@"request_url",@"BaseURL",NO),
                     GetConfigure(@"request_url",@"AddUser",NO)];
    [Tool postNetInfoWithPath:url andParams:params besidesBlock:^(id obj) {
        if ([obj[@"state"] isEqual:@"success"]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Register Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    } failure:nil];

}

@end

