//
//  VersionUpdateViewController.m
//  YuHaHa
//
//  Created by Amtion Tang on 2019/4/28.
//  Copyright © 2019 KuPuRuiCompany. All rights reserved.
//

#import "VersionUpdateViewController.h"

@implementation VersionUpdateModel

@end

@interface VersionUpdateViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *closeBGView;
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;

@end

@implementation VersionUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    self.titleLabel.text = [NSString stringWithFormat:@"发现新版本 %@ 可以更新啦！", self.model.versionOfNewStr];
    self.descriptionLabel.text = self.model.update_desc;
    if (self.model.is_must) {
        self.closeBGView.hidden = YES;
    }
}

- (UIModalTransitionStyle)modalTransitionStyle{
    return UIModalTransitionStyleCrossDissolve;
}

- (UIModalPresentationStyle)modalPresentationStyle{
    return UIModalPresentationOverFullScreen;
}

- (BOOL)hidesBottomBarWhenPushed{
    return YES;
}


#pragma mark - Action
- (IBAction)updateAction:(UIButton *)sender {
    [UIApplication.sharedApplication openURL:[NSURL URLWithString:self.model.appurl] options:@{} completionHandler:^(BOOL success) {
        [SVProgressHUD showInfoWithStatus:@"跳转到升级页面失败，请手动到App Store升级。"];
    }];
}

- (IBAction)closeAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
