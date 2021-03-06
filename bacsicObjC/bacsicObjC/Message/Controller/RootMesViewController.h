//
//  RootMesViewController.h
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "../ModelMessage/ConversationModel.h"
#import "../View/SingleConversationCell.h"
#import "../View/GroupConversationCell.h"
#import "../View/HeaderView.h"
#import "ConversationViewController.h" 
#import "MessageViewController.h"
#import "../define.h"
#import "ContactViewController.h"
#import "PeopleViewController.h"
#import "FeedAPMess.h"
#define KEY_WINDOW_SAFE_AREA_INSETS [UIApplication sharedApplication].keyWindow.safeAreaInsets
#define SingleConversationCellIdent @"SingleConversationCell"
#define GroupConversationCellIdent @"GroupConversationCell"
NS_ASSUME_NONNULL_BEGIN

@interface RootMesViewController : UINavigationController

@end

NS_ASSUME_NONNULL_END
