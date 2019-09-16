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

#import "GroupViewController.h"
#import "PeopleViewController.h"

#define SingleConversationCellIdent @"SingleConversationCell"
#define GroupConversationCellIdent @"GroupConversationCell"
NS_ASSUME_NONNULL_BEGIN

@interface RootMesViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
