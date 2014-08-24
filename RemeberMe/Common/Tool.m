//
//  Tool.m
//  RemeberMe
//
//  Created by mxiaochi on 14-8-24.
//  Copyright (c) 2014年 ___NOTHING___. All rights reserved.
//

#import "Tool.h"

@implementation Tool

#define DEFAULT_VOID_COLOR [UIColor whiteColor]
#define DEFAULTPCT_VOID_COLOR [CPTColor whiteColor]

//字符串转颜色
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//md5 32位 加密 （小写）
+ (NSString *)md5:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result );
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15],
            result[16], result[17],result[18], result[19],
            result[20], result[21],result[22], result[23],
            result[24], result[25],result[26], result[27],
            result[28], result[29],result[30], result[31]];
}

+ (id)getConfigureInfoFrom:(NSString *)fileName andKey:(NSString *)key inUserDomain:(BOOL)isIn{
    
    NSDictionary *dictionary=nil;
    if(isIn){
        NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory , NSUserDomainMask , YES );
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* filePath = [NSString stringWithFormat:@"%@/%@.plist",documentsDirectory,fileName];
        dictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    }else{
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    }
    
    if(key!=nil){
        return dictionary[key];
    }else{
        return dictionary;
    }
    
    
}
+ (void)setConfigureInfoTo:(NSString *)fileName forKey:(NSString *)key andContent:(NSString *)content{
    
    NSMutableDictionary *dTmp;
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory , NSUserDomainMask , YES );
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.plist",documentsDirectory,fileName];
    dTmp=[[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    if(dTmp==nil){
        dTmp=[[NSMutableDictionary alloc] init];
    }
    [dTmp setValue:content forKey:key];
    [dTmp writeToFile:filePath atomically: YES];
    
}

+ (void)getNetInfoWithPath:(NSString *)url andParams:(NSDictionary *)params besidesBlock:(void (^)(id))block failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

+ (void)postNetInfoWithPath:(NSString *)url andParams:(NSDictionary *)params besidesBlock:(void (^)(id))block failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

+ (BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if([string isKindOfClass:[NSString class]]){
        if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
            return YES;
        }
    }
    if ([string isKindOfClass:[NSNumber class]]) {
        return NO;
    }
    if([string isEqualToString:@"<null>"]||[string isEqualToString:@"<NUll>"]){
        return YES;
    }
    
    return NO;
}


@end
