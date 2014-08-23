//
//  ViewController.m
//  RemeberMe
//
//  Created by mxiaochi on 14-8-19.
//  Copyright (c) 2014年 ___NOTHING___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) FlatButton *sendButton;
@property (nonatomic) UILabel *infoLabel;
@property (nonatomic) UITextField *textField;

- (void)addButton;
- (void)addLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 50, 320, 50);
    label.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:label];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, 130, 30)];
    self.textField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    self.textField.backgroundColor = [UIColor customGrayColor];
    [self.view addSubview:self.textField];
    
    [self addButton];
}

- (void)touchUpInside:(FlatButton *)button {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"name": @"mxiaochi",@"pwd":@"abc"};
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:@"http://localhost:8000/users/add_user/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)addButton {
    
    self.sendButton = [FlatButton button];
    self.sendButton.backgroundColor = [UIColor customBlueColor];
    [self.sendButton setTitle:@"Send" forState:UIControlStateNormal];
    self.sendButton.frame = CGRectMake(100, 150, 120, 40);
    [self.sendButton addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendButton];
    
}

- (void)addLabel {
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


















@end
