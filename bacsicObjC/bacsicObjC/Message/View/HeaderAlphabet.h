//
//  HeaderAlphabet.h
//  bacsicObjC
//
//  Created by Steve on 9/26/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderAlphabet : UICollectionReusableView
@property (nonatomic, strong) UILabel * alphabetLabel;
- (void) setAlphabet:(NSString *) alphabet;
@end

NS_ASSUME_NONNULL_END
