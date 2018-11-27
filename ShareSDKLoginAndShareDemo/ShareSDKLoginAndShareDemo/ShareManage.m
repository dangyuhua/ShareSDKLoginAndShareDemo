//
//  ShareManage.m
//  ShareSDKLoginAndShareDemo
//
//  Created by 党玉华 on 2018/11/27.
//  Copyright © 2018年 dangyuhua. All rights reserved.
//

#import "ShareManage.h"

@implementation ShareManage
//登录
+(void)login:(SSDKPlatformType)platformType success:(loginBlock)block{
    [ShareSDK getUserInfo:platformType
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error){
               block(state,user,error);
    }];
}
//分享
+(void)share:(SSDKPlatformType)platformType parameters:(NSMutableDictionary *)parameters share:(shareBlock)block{
    [ShareSDK share:platformType parameters:parameters onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        block(state,userData,contentEntity,error);
    }];
}

@end
