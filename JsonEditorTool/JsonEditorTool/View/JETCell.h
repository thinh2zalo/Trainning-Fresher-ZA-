//
//  JETCell.h
//  JsonEditorTool
//
//  Created by Steve on 1/13/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Model/JsonModel.h"
#import "../View/AlertView.h"
NS_ASSUME_NONNULL_BEGIN

@interface JETCell : UICollectionViewCell <UIGestureRecognizerDelegate>
typedef NS_ENUM(NSInteger, JETSwipeState) {
    JETSwipeStateCenter = 0,
    JETSwipeStateLeft,
    JETSwipeStateRight,
    JETSwipeStateAnimatingToCenter
};
@property (nonatomic, assign) JETSwipeState state;
- (void)hideSwipeCell;

@end

NS_ASSUME_NONNULL_END
