//
//  MessageViewController.h
//  bacsicObjC
//
//  Created by Steve on 9/19/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../ModelMessage/ConversationModel.h"
#import "../View/SingleConversationCell.h"
#import "../View/GroupConversationCell.h"
#import "../View/HeaderView.h"
#import "ConversationViewController.h"

#import "ContactViewController.h"
#import "PeopleViewController.h"
#import "FeedAPMess.h"

#define SingleConversationCellIdent @"SingleConversationCell"
#define GroupConversationCellIdent @"GroupConversationCell"
NS_ASSUME_NONNULL_BEGIN

@interface MessageViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
