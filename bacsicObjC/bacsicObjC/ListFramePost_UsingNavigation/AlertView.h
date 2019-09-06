//
//  AlertView.h
//  bacsicObjC
//
//  Created by CPU11606 on 9/6/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertView : UIView
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UILabel *titleLab;
@end

NS_ASSUME_NONNULL_END
