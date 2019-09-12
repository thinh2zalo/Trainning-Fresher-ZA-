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
    [super layoutSubviews];
    [self.conversationStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20].active = YES;
    [self.conversationStackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-20].active = YES;
    [self.conversationStackView.topAnchor constraintEqualToAnchor:self.topAnchor constant:20].active = YES;
    [self.conversationStackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant: -20].active = YES;
    
   [self.usersView.widthAnchor constraintEqualToConstant:70].active = YES;
   [self.timeAndCountNewMesView.widthAnchor constraintEqualToConstant:70].active = YES;
    
    [self.conversationStackView addArrangedSubview:self.usersView];
    [self.conversationStackView addArrangedSubview:self.nameAndContentView];
    [self.conversationStackView addArrangedSubview:self.timeAndCountNewMesView];
   

    [self layoutIfNeeded];

    self.nameUserLab.frame = CGRectMake(0, 0, self.nameAndContentView.frame.size.width, 20);
    self.lastMessageLab.frame = CGRectMake(self.nameUserLab.frame.origin.y  , self.nameAndContentView.frame.size.height / 2, self.nameAndContentView.frame.size.width, self.nameAndContentView.frame.size.height / 2);
    [self.lastMessageLab sizeToFit];
    
    self.timeLab.frame = CGRectMake(0, 0, self.timeAndCountNewMesView.frame.size.width, self.timeAndCountNewMesView.frame.size.height);
    [self.timeLab sizeToFit];
    
    self.countNewMessageBtn.frame = CGRectMake(0, 40, 40, 0);
 

}

- (void)updateContentInsideCell:(ConversationModel *)conversationModel {
    self.nameUserLab.text = conversationModel.nameUser;
    self.lastMessageLab.text = conversationModel.lastMessage;
    self.timeLab.text = conversationModel.time;
    [self.countNewMessageBtn setTitle:[NSString stringWithFormat:@"%tu", conversationModel.countNewMessage] forState:UIControlStateNormal];
}

- (UIImageView *)avatarUserImg {
    if (!_avatarUserImg) {
        _avatarUserImg = UIImageView.new;
    }
    return _avatarUserImg;
}

- (UIView *)usersView {
    if (!_usersView) {
        _usersView = UIView.new;
        _nameAndContentView.translatesAutoresizingMaskIntoConstraints = false;
        
        _usersView.backgroundColor = [UIColor blackColor];
    }
    return  _usersView;
}

- (UIView *)nameAndContentView {
    if (!_nameAndContentView) {
        _nameAndContentView = UIView.new;
        _nameAndContentView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _nameAndContentView;
}

- (UIView *)timeAndCountNewMesView {
    if (!_timeAndCountNewMesView) {
        _timeAndCountNewMesView = UIView.new;
        _timeAndCountNewMesView.backgroundColor = [UIColor redColor];

        _timeAndCountNewMesView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _timeAndCountNewMesView;
}


- (UILabel *)nameUserLab {
    if (!_nameUserLab) {
       
        _nameUserLab = UILabel.new;
        _nameUserLab.textColor = [UIColor blackColor];
        [_nameUserLab setFont:[UIFont boldSystemFontOfSize:20]];
        [self.nameAndContentView addSubview:_nameUserLab];
    }
    return _nameUserLab;
}


- (UILabel *)lastMessageLab{
    if (!_lastMessageLab) {
        _lastMessageLab = UILabel.new;
        _lastMessageLab.textColor = [UIColor darkGrayColor];
        [_lastMessageLab setNumberOfLines:2];
        [_lastMessageLab setFont:[UIFont systemFontOfSize:13]];
        [self.nameAndContentView addSubview:_lastMessageLab];
    }
    return _lastMessageLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = UILabel.new;
        _timeLab.textColor = [UIColor darkGrayColor];
        [_timeLab setFont:[UIFont systemFontOfSize:13]];
        [self.timeAndCountNewMesView addSubview:_timeLab];
    }
    return _timeLab;
}

- (UIButton *)countNewMessageBtn {
    if (!_countNewMessageBtn) {
        _countNewMessageBtn = UIButton.new;
        [_countNewMessageBtn setSelected:YES];
        [_countNewMessageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_countNewMessageBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.timeAndCountNewMesView addSubview:_countNewMessageBtn];

    }
    return _countNewMessageBtn;
}



- (UIView *)conversationStackView {
    if (!_conversationStackView) {
        
        _conversationStackView = UIStackView.new;
        _conversationStackView.translatesAutoresizingMaskIntoConstraints = false;
        _conversationStackView.axis = UILayoutConstraintAxisHorizontal;
        [_conversationStackView setDistribution:UIStackViewDistributionFill];
        _conversationStackView.spacing = 10;
        [self addSubview:_conversationStackView];
        
    }
    return _conversationStackView;
}


@end
