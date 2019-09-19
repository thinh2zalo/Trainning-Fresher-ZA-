//
//  HeaderView.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/13/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//
#import "../define.h"
#import "HeaderView.h"
@interface HeaderView()


@end

@implementation HeaderView
- (void)layoutSubviews {
    self.topHeaderView.frame = CGRectMake(0, 0, SCREEN_MAIN_WIDTH , HEADER_HEIGHT /  2);
    self.botHeaderView.frame = CGRectMake(0, 44, SCREEN_MAIN_WIDTH , HEADER_HEIGHT / 2);
    self.titleBotLab.frame = CGRectMake(10, 0, self.botHeaderView.frame.size.width, self.botHeaderView.frame.size.height);
//    self.backgroundColor = UIColor.redColor;
//    self.clipsToBounds = YES;
//    self.titleTopLab.frame = CGRectMake(0, 0, SCREEN_MAIN_WIDTH, HEADER_HEIGHT / 2);

}
- (void) setHeightForBotHeader:(float) height {
    self.botHeaderView.frame = CGRectMake(0, height, SCREEN_MAIN_WIDTH , HEADER_HEIGHT / 2);
}

- (void) setHeightForTopHeader:(float) height {
    self.titleTopLab.frame = CGRectMake(0, MIN(0, height), SCREEN_MAIN_WIDTH , HEADER_HEIGHT / 2);
}

- (UIView *)botHeaderView {
    
    if (!_botHeaderView) {
        _botHeaderView = UIView.new;
        [self addSubview:_botHeaderView];
    }
    return _botHeaderView;
}

- (UIView *)topHeaderView {
    
    if (!_topHeaderView) {
        _topHeaderView = UIView.new;
        _topHeaderView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_topHeaderView];
    }
    return _topHeaderView;
}


- (UILabel *)titleBotLab {
    if (!_titleBotLab) {
        _titleBotLab = UILabel.new;
        [_titleBotLab setFont:[UIFont boldSystemFontOfSize:44]];
        _titleBotLab.text = @"MESSAGE";
        [self.botHeaderView addSubview:_titleBotLab];
    }
    return  _titleBotLab;
}

- (UILabel *)titleTopLab {
    if (!_titleTopLab) {
        _titleTopLab = UILabel.new;
        [_titleTopLab setFont:[UIFont boldSystemFontOfSize:23]];
        _titleTopLab.textAlignment = NSTextAlignmentCenter;
        
        _titleTopLab.text = @"Message";
        [self.topHeaderView addSubview:_titleTopLab];
    }
    return  _titleTopLab;
}

@end
