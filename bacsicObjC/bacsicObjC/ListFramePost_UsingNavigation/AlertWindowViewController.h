//
//  AlertWindow.h
//  bacsicObjC
//
//  Created by CPU11606 on 9/6/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertView.h"
#import "Define.h"
#import "MainCollectionViewController.h"
#import "AlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlertWindowViewController : UIViewController
@property (nonatomic, strong) UIWindow * windowToAlert;
@property (nonatomic, strong) AlertView * alertView;
+ (void)showAlert:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
