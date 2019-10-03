//
//  alphabeticalScrollView.m
//  SimpleMessage
//
//  Created by Steve on 10/1/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "AlphabeticalScrollView.h"

@implementation AlphabeticalScrollView

- (void) setupWithIndexTitles:(NSArray <NSString *> *) indexTitles {
    for (int i = 0 ; i < indexTitles.count ; i ++) {
        [self.arrTitleIndexViews objectAtIndex:i] = UIView.new;
        
    }
}

- (NSMutableArray<UIView *> *)arrTitleIndexViews {
    if (!_arrTitleIndexViews) {
        _arrTitleIndexViews = NSArray.new;
        
    }
    return _arrTitleIndexViews;
}

@end
