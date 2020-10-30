//
//  AmCheckIsUpdate.m
//  CheckAppIsNeedUpdateForUseAppStore
//
//  Created by amtion on 2020/1/2.
//  Copyright © 2020 amtion. All rights reserved.
//

#import "AmCheckIsUpdate.h"

@implementation AmCheckIsUpdate

+(void)updateWithAPPID:(NSString *)appId withBundleId:(NSString *)bundelId block:(UpdateBlock)block isShowAnmation:(BOOL)isShowAnmation{
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    __block NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    NSMutableURLRequest *request;
    if (appId.length>0) {
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@",appId]]];
    }else if (bundelId.length>0){
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/lookup?bundleId=%@&country=cn",bundelId]]];
    }else{
        NSString *currentBundelId=infoDic[@"CFBundleIdentifier"];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/lookup?bundleId=%@&country=cn",currentBundelId]]];
    }
    request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    if (isShowAnmation) {
        [SVProgressHUD showWithStatus:@"正在检查应用商店，是否有新版本"];
    }
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        if (error) {
            NSLog(@"【3】检测失败，原因：\n%@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                block(currentVersion,@"",@"",NO,@"");
            });
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([appInfoDic[@"resultCount"] integerValue] == 0) {
                NSLog(@"检测出未上架的APP或者查询不到");
                block(currentVersion,@"",@"",NO,@"");
                return;
            }
            NSString *appStoreVersion = [NSString stringWithFormat:@"%@", appInfoDic[@"results"][0][@"version"]];
            
            BOOL needUpdate = [AmCheckIsUpdate isNeedUpdateWithCurrentVersionString:currentVersion appStoreVersion:appStoreVersion];
            NSString *trackViewUrl = [NSString stringWithFormat:@"%@", appInfoDic[@"results"][0][@"trackViewUrl"]];
            NSString *releaseNotes = [NSString stringWithFormat:@"%@", appInfoDic[@"results"][0][@"releaseNotes"]];
            block(currentVersion,appStoreVersion,trackViewUrl, needUpdate, releaseNotes);
            
        });
    }];
    [task resume];
}

+ (BOOL)isNeedUpdateWithCurrentVersionString:(NSString *)currentVersion appStoreVersion:(NSString *)appStoreVersion{
    
    NSArray *versionArray = [appStoreVersion componentsSeparatedByString:@"."];
    NSArray *nowVersionArray = [currentVersion componentsSeparatedByString:@"."];
    BOOL needUpdate = NO;
    for (int i = 0; i<versionArray.count; i++) {
        NSString *iVersion = [NSString stringWithFormat:@"%@", versionArray[i]];
        NSString *iNowVersion = [NSString stringWithFormat:@"%@", nowVersionArray[i]];
        NSInteger iVersionInt = iVersion.integerValue;
        NSUInteger iNowVersionInt = iNowVersion.integerValue;
        if (iVersionInt > iNowVersionInt) {
            needUpdate = YES;
            break;
        } else if (iVersionInt<iNowVersionInt) {
            break;
        }
    }
    return needUpdate;
    
}

@end
