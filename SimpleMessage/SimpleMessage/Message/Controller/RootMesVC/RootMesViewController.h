//
//  RootMesViewController.h
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "../../ModelMessage/ConversationModel.h"
#import "../../View/SingleConversationCell.h"
#import "../../View/GroupConversationCell.h"
#import "../../View/HeaderView.h"
#import "ConversationViewController.h"
#import "../MessageVC/MessageViewController.h"
#import "../../define.h"
#import "ContactViewController.h"
#import "FeedAPMess.h"
#import "../../Utility/UIView+ZBMAutoLayout.h"
#define KEY_WINDOW_SAFE_AREA_INSETS [UIApplication sharedApplication].keyWindow.safeAreaInsets
#define SingleConversationCellIdent @"SingleConversationCell"
#define GroupConversationCellIdent @"GroupConversationCell"
NS_ASSUME_NONNULL_BEGIN

@interface RootMesViewController : UINavigationController
@property (nonatomic, strong) UITabBar * tabBar;
@end

NS_ASSUME_NONNULL_END
