

#import "../define.h"
#import "HeaderView.h"
@interface HeaderView()

@end

@implementation HeaderView
- (void)layoutSubviews {
    self.topHeaderView.frame = CGRectMake(0, 0, self.frame.size.width , HEADER_HEIGHT -  KEY_WINDOW_SAFE_AREA_INSETS.top );
    self.botHeaderView.frame = CGRectMake(0, 88, self.frame.size.width , 44);
    self.titleBotLab.frame = CGRectMake(10, 0, self.botHeaderView.frame.size.width, self.botHeaderView.frame.size.height);
    self.hideTitleTopView.frame = CGRectMake (0, 0 , self.frame.size.width, 44);
    
    self.topHeaderView.layer.shadowRadius  = 1.5f;
    self.topHeaderView.layer.shadowColor   = [UIColor colorWithRed:176.f/255.f green:199.f/255.f blue:226.f/255.f alpha:1.f].CGColor;
    
    self.topHeaderView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    self.topHeaderView.layer.shadowOpacity = 0.9f;
    self.topHeaderView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(self.topHeaderView.bounds, shadowInsets)];
    self.topHeaderView.layer.shadowPath    = shadowPath.CGPath;


}
- (void) setHeightForBotHeader:(float) scrollDiff {
    self.botHeaderView.frame = CGRectMake(0, HEADER_HEIGHT - KEY_WINDOW_SAFE_AREA_INSETS.top - scrollDiff, SCREEN_MAIN_WIDTH , 44);
}

- (void) setHeightForTopHeader:(float) scrollDiff {
    self.titleTopLab.frame = CGRectMake(0, MIN(44, scrollDiff),  self.frame.size.width , 44);
}

- (UIView *)botHeaderView {
    
    if (!_botHeaderView) {

        _botHeaderView = UIView.new;
        _botHeaderView.backgroundColor = [UIColor whiteColor];
        [self insertSubview:_botHeaderView belowSubview:self.topHeaderView];
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


- (UIView *)hideTitleTopView  {
    if (!_hideTitleTopView) {
        _hideTitleTopView = UIView.new;
        
        _hideTitleTopView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_hideTitleTopView];
        
    }
    return _hideTitleTopView;
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
        
        [self.topHeaderView addSubview:_titleTopLab];
    }
    return  _titleTopLab;
}

@end
