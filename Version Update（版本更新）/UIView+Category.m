//
//  UIView+Category.m
//  XunJianSystem
//
//  Created by Amtion_Tang on 2019/1/19.
//  Copyright © 2019 KuPuRuiCompany. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

+ (UIViewController *)findSuperViewController{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIViewController *topViewController = [window rootViewController];
    
    while (true) {
        
        if (topViewController.presentedViewController) {
            
            topViewController = topViewController.presentedViewController;
            
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
            
            topViewController = [(UINavigationController *)topViewController topViewController];
            
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
            
        } else {
            break;
        }
    }
    return topViewController;
}

@end
