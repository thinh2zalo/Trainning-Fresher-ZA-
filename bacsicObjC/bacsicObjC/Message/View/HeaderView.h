//
//  HeaderView.h
//  bacsicObjC
//
//  Created by CPU11606 on 9/13/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderView : UIView
@property (nonatomic, strong) UIView * botHeaderView;
@property (nonatomic, strong) UIView * topHeaderView;
@property (nonatomic, strong) UILabel * titleBotLab;
@property (nonatomic, strong) UILabel * titleTopLab;
- (void) setHeightForBotHeader:(float) height ;
- (void) setHeightForTopHeader:(float) height ;
@end

NS_ASSUME_NONNULL_END
