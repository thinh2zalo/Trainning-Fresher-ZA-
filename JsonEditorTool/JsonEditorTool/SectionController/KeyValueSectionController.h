//
//  KeyValueSectionController.h
//  JsonEditorTool
//
//  Created by Steve on 12/4/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>
#import "../View/AlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface KeyValueSectionController : IGListSectionController

@property (nonatomic) BOOL isSearching;

@end

NS_ASSUME_NONNULL_END
