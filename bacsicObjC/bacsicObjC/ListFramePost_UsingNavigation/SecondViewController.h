//
//  secondViewController.h
//  bacsicObjC
//
//  Created by CPU11606 on 8/16/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//
#define HEIGHT_TEXTVIEW 100.0
#define WIDTH_TEXTVIEW 400.0

#define HEIGHT_BTN 30
#define WIDTH_BTN 90

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Container.h"
NS_ASSUME_NONNULL_BEGIN
@class SecondViewController;
@protocol PassDataBack <NSObject>

@required
- (void)getDataBack:(SecondViewController *)dataInsideSecond;

@end
@interface SecondViewController : UIViewController
@property (nonatomic, assign) NSInteger indexOfSubview;
@property (nonatomic, strong) NSString *data;
@property (nonatomic, weak) id<PassDataBack> delegate;

@end

NS_ASSUME_NONNULL_END
