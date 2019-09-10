//
//  ConversationCell.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "ConversationCell.h"

@interface ConversationCell()




@end

@implementation ConversationCell


- (void)layoutSubviews {
    
}



- (UIView *)timeAndCountNewMes {
    if (!_timeAndCountNewMesView) {
        _timeAndCountNewMesView = UIView.new;
        [self.conversactionStackView addArrangedSubview:_timeAndCountNewMesView];
    }
    return _nameAndContentView;
}


- (UIView *)nameAndContentView {
    if (!_nameAndContentView) {
        _nameAndContentView = UIView.new;
        [self.conversactionStackView addArrangedSubview:_nameAndContentView];
    }
    return _nameAndContentView;
}

- (UILabel *)nameUserLab {
    if (!_nameUserLab) {
        _nameUserLab = UILabel.new;
        [self.nameAndContentView addSubview:_nameUserLab];
    }
    return _nameUserLab;
}


- (UILabel *)lastMessageLab {
    if (_lastMessageLab) {
        _lastMessageLab = UILabel.new;
        
    }
    return _lastMessageLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = UILabel.new;
        [self.timeAndCountNewMesView addSubview:_timeLab];
    }
    return _timeLab;
}

- (UILabel *)countNewMessageLab {
    if (!_countNewMessageLab) {
        _countNewMessageLab = UILabel.new;
        [self.timeAndCountNewMesView addSubview:_countNewMessageLab];
    }
    return _countNewMessageLab;
}



- (UIView *)conversactionStackView {
    if (!_conversactionStackView) {
        _conversactionStackView = UIStackView.new;
        _conversactionStackView.axis = UILayoutConstraintAxisHorizontal;
        _conversactionStackView.spacing = 20;
        [self addSubview:_conversactionStackView];
        
    }
    return _conversactionStackView;
}


@end
