//
//  Header.h
//  CalculatorBM
//
//  Created by vincent on 3/4/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import <UIKit/UIKit.h>
#import "BMDate.h"
#import "define2.h"
NS_ASSUME_NONNULL_BEGIN
@interface BMButtonLabel : UIView
- (void)setLabelText:(NSString *)text;
- (void)loadDateWithInput:(BMDate *)date;

@end
NS_ASSUME_NONNULL_END

#endif /* Header_h */
