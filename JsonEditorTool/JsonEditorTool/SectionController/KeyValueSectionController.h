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
@protocol KeyValueSectionControllerDelegate <NSObject>

- (void)performUpdate:(nullable JsonModel *)oldObject andNewObject:(nullable JsonModel * )newObject;

@end
@interface KeyValueSectionController : IGListSectionController 
@property (nonatomic, weak) id <KeyValueSectionControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
