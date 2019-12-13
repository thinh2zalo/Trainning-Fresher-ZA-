//
//  HomeView.h
//  JsonEditorTool
//
//  Created by Steve on 11/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextField.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HomeViewDelegate <NSObject>

- (void)loadData;

@end

@interface HomeView : UIView
@property (nonatomic, strong) UITextField * oSVField;
@property (nonatomic, strong) TextField * verField;
@property (nonatomic, strong) UIButton *  commitBtn;
@property (nonatomic, strong) id <HomeViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
