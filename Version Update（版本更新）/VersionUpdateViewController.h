//
//  VersionUpdateViewController.h
//  YuHaHa
//
//  Created by Amtion Tang on 2019/4/28.
//  Copyright © 2019 KuPuRuiCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VersionUpdateModel : NSObject

@property (nonatomic, copy) NSString *versionOfNewStr;
@property (nonatomic, copy) NSString *update_desc;
@property (nonatomic, copy) NSString *appurl;
@property (nonatomic, assign) BOOL is_must;

@end

@interface VersionUpdateViewController : UIViewController

@property (nonatomic, strong) VersionUpdateModel *model;

@end

NS_ASSUME_NONNULL_END
