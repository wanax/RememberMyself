//
//  IndexVC.m
//  RemeberMe
//
//  Created by mxiaochi on 14-8-24.
//  Copyright (c) 2014年 ___NOTHING___. All rights reserved.
//

#import "IndexVC.h"
#import "UserLoginVC.h"

@interface IndexVC()
@property(nonatomic) UIView *redView;
@property(nonatomic) UIView *greenView;
@property(nonatomic) UIView *blueView;
@end


@implementation IndexVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Remember Myself";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(user_logout)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"Flash" style:UIBarButtonItemStylePlain target:self action:@selector(checkIsLogin)];
    self.navigationItem.leftBarButtonItem = item2;
    self.navigationItem.rightBarButtonItem = item;
    
    [self checkIsLogin];
    [self addViews];
    [self updateConstraints:nil];
}

- (void)user_logout {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:@"http://localhost:8000/users/user_logout/" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"state"] isEqual:@"success"]) {
            UserLoginVC *loginVC = [[UserLoginVC alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)checkIsLogin {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:@"http://localhost:8000/users/is_login/" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", [responseObject JSONString]);
        if ([responseObject[@"state"] isEqual:@"no"]) {
            UserLoginVC *loginVC = [[UserLoginVC alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)addViews
{
    self.redView = [UIView new];
    self.redView.backgroundColor = [UIColor customBlueColor];
    self.redView.translatesAutoresizingMaskIntoConstraints = NO;
    self.redView.layer.cornerRadius = 4.f;
    self.greenView = [UIView new];
    self.greenView.backgroundColor = [UIColor customGreenColor];
    self.greenView.translatesAutoresizingMaskIntoConstraints = NO;
    self.greenView.layer.cornerRadius = 4.f;
    self.blueView = [UIView new];
    self.blueView.backgroundColor = [UIColor customYellowColor];
    self.blueView.translatesAutoresizingMaskIntoConstraints = NO;
    self.blueView.layer.cornerRadius = 4.f;
    
    [self.view addSubview:self.redView];
    [self.view addSubview:self.greenView];
    [self.view addSubview:self.blueView];
}

- (void)updateConstraints:(id)sender
{
    [self.view layoutIfNeeded];
    [self.view removeConstraints:self.view.constraints];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_redView, _greenView, _blueView);
    NSArray *viewNames = [self shuffledArrayFromArray:views.allKeys];
    
    NSString *firstViewKey= viewNames[0];
    NSString *secondViewKey = viewNames[1];
    NSString *thirdViewKey = viewNames[2];
    
    NSString *horizontalFormat = [NSString stringWithFormat:@"H:|-[%@]-|", firstViewKey];
    NSString *additionalHorizontalFormat = [NSString stringWithFormat:@"H:|-[%1$@]-[%2$@(==%1$@)]-|", secondViewKey, thirdViewKey];
    NSString *verticalFormat = [NSString stringWithFormat:@"V:|-(88)-[%1$@]-[%2$@(==%1$@)]-|", firstViewKey, secondViewKey];
    NSString *additionalVerticalFormat = [NSString stringWithFormat:@"V:|-(88)-[%1$@]-[%2$@(==%1$@)]-|", firstViewKey, thirdViewKey];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:horizontalFormat
                               options:0
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:additionalHorizontalFormat
                               options:NSLayoutFormatAlignAllTop
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:verticalFormat
                               options:0
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:additionalVerticalFormat
                               options:0
                               metrics:nil
                               views:views]];
    
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.7
                        options:0
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:NULL];
}

- (NSArray *)shuffledArrayFromArray:(NSArray *)array
{
    NSMutableArray *shuffleArray = [array mutableCopy];
    NSUInteger count = [shuffleArray count];
    
    for (NSUInteger i = 0; i < count; ++i) {
        NSUInteger nElements = count - i;
        NSUInteger n = arc4random_uniform((uint32_t)nElements) + i;
        [shuffleArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    return [shuffleArray copy];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
