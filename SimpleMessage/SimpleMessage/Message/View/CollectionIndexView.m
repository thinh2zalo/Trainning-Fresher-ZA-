//
//  CollectionIndexView.m
//  SimpleMessage
//
//  Created by Steve on 10/1/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "CollectionIndexView.h"



@interface CollectionIndexView()
@property (assign) float totalLabelSize;
@property (assign) NSInteger numberOfTitle;

@end

@implementation CollectionIndexView

- (void)layoutSubviews {
    [super layoutSubviews];
    for (int i = 0 ; i < _numberOfTitle ; i++) {
        self.arrAlphabeticalScroll[i].frame = CGRectMake(0, ((self.frame.size.height - _totalLabelSize) / 2 ) + 40 * i ,self.frame.size.width, self.frame.size.width);
    }
}
- (instancetype)init {
    self = [super init];
    UIPanGestureRecognizer  *panGesture = UIPanGestureRecognizer.new;
    UITapGestureRecognizer  *tapGesture = UITapGestureRecognizer.new;
    [panGesture addTarget:self action:@selector(checkLocationWith:)];
    [self addGestureRecognizer:panGesture];
    [tapGesture addTarget:self action:@selector(checkLocationWith:)];
    [self addGestureRecognizer:tapGesture];
    return self;
}

- (void)setupWithIndexTitles:(NSArray <NSString *> *)indexTitles {
    if ([indexTitles isKindOfClass:NSArray.class]) {
        _totalLabelSize  = 40 * indexTitles.count;
        _numberOfTitle = indexTitles.count;
        for (int i = 0 ; i < _numberOfTitle ; i++) {
            self.arrAlphabeticalScroll[i] = UILabel.new;
            self.arrAlphabeticalScroll[i].textAlignment = NSTextAlignmentCenter;
            self.arrAlphabeticalScroll[i].textColor = [UIColor blueColor];
            self.arrAlphabeticalScroll[i].text = indexTitles[i];
            [self addSubview:self.arrAlphabeticalScroll[i]];
        }
    }
}

- (void)checkLocationWith:(UIGestureRecognizer *) gesture {
    
    for (int i = 0 ; i < self.arrAlphabeticalScroll.count ; i ++) {
        if (CGRectContainsPoint(self.arrAlphabeticalScroll[i].frame, [gesture locationInView:self])) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
            self.arrAlphabeticalScroll[i].backgroundColor = [UIColor grayColor];
            self.arrAlphabeticalScroll[i].layer.cornerRadius = self.arrAlphabeticalScroll[i].frame.size.width / 2;
            self.arrAlphabeticalScroll[i].layer.masksToBounds = true;
            if (_delegate && [_delegate respondsToSelector:@selector(moveContentToIndexPath:)]) {
                [_delegate moveContentToIndexPath:indexPath];
            }
        }
        else {
            self.arrAlphabeticalScroll[i].backgroundColor = [UIColor clearColor];
        }
    }
   
}

- (NSMutableArray<UILabel *> *)arrAlphabeticalScroll {
    if (!_arrAlphabeticalScroll) {
        _arrAlphabeticalScroll = NSMutableArray.new;
    }
    return _arrAlphabeticalScroll;
}


@end
