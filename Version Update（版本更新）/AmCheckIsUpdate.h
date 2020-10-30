//
//  AmCheckIsUpdate.h
//  CheckAppIsNeedUpdateForUseAppStore
//
//  Created by amtion on 2020/1/2.
//  Copyright © 2020 amtion. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CheckVersionIsUpdateModel.h"
#import "AmCheckIsUpdate.h"
#import "VersionUpdateViewController.h"
#import "UIView+Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface AmCheckIsUpdate : NSObject

/**
 block回调
 
 @param currentVersion 当前版本号
 @param storeVersion 商店版本号
 @param openUrl 跳转到商店的地址
 @param isUpdate 是否为最新版本
 @param releaseNotes 新版本的新增内容说明
 */
typedef void(^UpdateBlock)(NSString *currentVersion,NSString *storeVersion, NSString *openUrl,BOOL isUpdate, NSString *releaseNotes);

/**
 一行代码实现检测app是否为最新版本。appId，bundelId，随便传一个 或者都传nil 即可实现检测。

 @param appId    项目APPID，10位数字，有值默认为APPID检测，可传nil
 @param bundelId 项目bundelId，有值默认为bundelId检测，可传nil
 @param block    检测结果block回调
 */
+(void)updateWithAPPID:(NSString *)appId withBundleId:(NSString *)bundelId block:(UpdateBlock)block isShowAnmation:(BOOL)isShowAnmation;

/// 检查是否有新版本
/// @param currentVersion 当前版本号
/// @param appStoreVersion 应用商店的版本号
+ (BOOL)isNeedUpdateWithCurrentVersionString:(NSString *)currentVersion appStoreVersion:(NSString *)appStoreVersion;

@end

NS_ASSUME_NONNULL_END
