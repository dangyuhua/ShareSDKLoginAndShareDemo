//
//  ShareManage.h
//  ShareSDKLoginAndShareDemo
//
//  Created by 党玉华 on 2018/11/27.
//  Copyright © 2018年 dangyuhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>

typedef void(^loginBlock) (SSDKResponseState state, SSDKUser *user, NSError *error);

typedef void(^shareBlock) (SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error);

@interface ShareManage : NSObject
//登录
+(void)login:(SSDKPlatformType)platformType success:(loginBlock)block;
//分享
+(void)share:(SSDKPlatformType)platformType parameters:(NSMutableDictionary *)parameters share:(shareBlock)block;

@end
