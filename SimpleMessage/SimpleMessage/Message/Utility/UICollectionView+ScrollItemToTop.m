//
//  UICollectionView+ScrollItemToTop.m
//  SimpleMessage
//
//  Created by Steve on 10/3/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "UICollectionView+ScrollItemToTop.h"

@interface  UICollectionView () {
}

@end

@implementation UICollectionView (ScrollItemToTop)

- (void) scrollItemToTopWithIndexPath:(NSIndexPath *) indexPath  {
    CGFloat contentOffsetY = -88;
    for ( int i = 0 ; i < indexPath.section ; i ++) {
        NSUInteger numberOfItemsInSection = [self numberOfItemsInSection:i];
            contentOffsetY = contentOffsetY + numberOfItemsInSection * 80 + (numberOfItemsInSection - 1) * 30 + 40 + 30 * 2;
    }
   [self setContentOffset:CGPointMake(0, MIN(self.contentSize.height - self.frame.size.height, contentOffsetY)) animated:YES];
    
    
}


@end
