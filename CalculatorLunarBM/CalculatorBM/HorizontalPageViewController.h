//
//  HorizontalPgaeViewController.h
//  CalculatorBM
//
//  Created by vincent on 3/4/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "BMPageViewController.h"
#import "DateModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol  HorizontalPageViewControllerDelegate<NSObject>

- (void)triggerUpdate:(BMDate *)date;

@end
@interface HorizontalPageViewController : BMPageViewController
@property (nonatomic, assign, ) DateModel * dateModel;
@property (nonatomic, assign) id <HorizontalPageViewControllerDelegate> HorizontalPageViewControllerDelegate;

- (DateModel *)getDateModel;
- (void)setDateModel:(DateModel *)dataModel;

@end

NS_ASSUME_NONNULL_END
