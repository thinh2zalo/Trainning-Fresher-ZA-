//
//  NavBarView.m
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "NavBarView.h"
#import "../Define.h"
#import "../Categories/UILabel+Caculation.h"

@implementation NavBarView


- (void)layoutSubviews {
    self.backBtn.frame = CGRectMake(MARGIN , self.frame.size.height - 20 - 13 , 20, 20);
   
    [self.navTitleLable setCenter:CGPointMake(self.center.x, self.frame.size.height - MARGIN - [UILabel heightOf1LineWithFrontSize:self.navTitleLable] / 2)];
    self.navTitleLable.bounds = CGRectMake(0, 0, (self.frame.size.width / 3 ) * 2  , [UILabel heightOf1LineWithFrontSize:self.navTitleLable]);
    [self createShadow];

}

- (void)createShadow{
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowOpacity = 0.9f;
    self.layer.shadowRadius  = 1.5f;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -0.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(self.bounds, shadowInsets)];
    self.layer.shadowPath    = shadowPath.CGPath;
}

- (UILabel *)navTitleLable {
    if (!_navTitleLable) {
        _navTitleLable = UILabel.new;
        _navTitleLable.textColor = [UIColor whiteColor];
        _navTitleLable.textAlignment  = NSTextAlignmentCenter;
        
        [_navTitleLable setFont:[UIFont boldSystemFontOfSize:18]];
        [self addSubview:_navTitleLable];
    }
    return _navTitleLable;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = UIButton.new;
        UIImage *btnImage = [UIImage imageNamed:@"back"];
        [_backBtn setImage:btnImage forState:UIControlStateNormal];
        [self addSubview:_backBtn];
    }
    return _backBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
