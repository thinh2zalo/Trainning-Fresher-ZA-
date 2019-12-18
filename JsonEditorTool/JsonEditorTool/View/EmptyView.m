//
//  EmptyView.m
//  JsonEditorTool
//
//  Created by Steve on 12/15/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "EmptyView.h"

@interface EmptyView ()
@property (nonatomic, strong) UILabel * emptyLabel;

@end
@implementation EmptyView
- (void)layoutSubviews {
    
    self.emptyLabel.frame = CGRectMake(0, 0, 80, 50);
    self.emptyLabel.center = CGPointMake(self.frame.size.width/2, 200);
}
- (UILabel *)emptyLabel {
    if (!_emptyLabel) {
        _emptyLabel = UILabel.new;
        _emptyLabel.text = @"no more data";
        [self addSubview:_emptyLabel];
    }
    return _emptyLabel;
}

@end
