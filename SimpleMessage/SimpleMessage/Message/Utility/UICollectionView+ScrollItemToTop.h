//
//  UICollectionView+ScrollItemToTop.h
//  SimpleMessage
//
//  Created by Steve on 10/3/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (ScrollItemToTop)
- (void) scrollItemToTopWithIndexPath:(NSIndexPath *) indexPath;

@end

NS_ASSUME_NONNULL_END
