//
//  Tool.h
//  RemeberMe
//
//  Created by mxiaochi on 14-8-24.
//  Copyright (c) 2014年 ___NOTHING___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

//字符串转颜色
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

//md5 32位 加密 （小写）
+ (NSString *)md5:(NSString *)str;

//根据key值获取配置文件内容，可修改文件置于沙箱中，isIn为YES
+ (id)getConfigureInfoFrom:(NSString *)fileName andKey:(NSString *)key inUserDomain:(BOOL)isIn;
+(void)setConfigureInfoTo:(NSString *)fileName forKey:(NSString *)key andContent:(NSString *)content;

+(void)getNetInfoWithPath:(NSString *)url andParams:(NSDictionary *)params besidesBlock:(void(^)(id obj))block failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+(void)postNetInfoWithPath:(NSString *)url andParams:(NSDictionary *)params besidesBlock:(void(^)(id obj))block failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

//字符串判空
+ (BOOL) isBlankString:(NSString *)string;

@end
