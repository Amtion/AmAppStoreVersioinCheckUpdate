//
//  CheckVersionIsUpdateModel.h
//  XunJianSystem
//
//  Created by Amtion Tang on 2019/12/6.
//  Copyright © 2019 KuPuRuiCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataCheckVersionIsUpdateModel :NSObject

@property (nonatomic , copy) NSString              * version;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * is_force;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * url;

@end

@interface CheckVersionIsUpdateModel : NSObject

@property (nonatomic , assign) NSInteger              code;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) DataCheckVersionIsUpdateModel              * data;

@end

NS_ASSUME_NONNULL_END
