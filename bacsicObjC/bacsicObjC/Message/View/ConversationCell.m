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
    [self.usersView.widthAnchor constraintEqualToConstant:self.frame.size.height - 2 * 20].active = YES;
    
    [self.timeAndCountNewMesView.widthAnchor constraintEqualToConstant:[MessageCell widthOfLabel:self.timeLab.text]].active = YES;
    [self layoutIfNeeded];
    
    [self.conversationStackView addArrangedSubview:self.usersView];
    [self.conversationStackView addArrangedSubview:self.nameAndContentView];
    [self.conversationStackView addArrangedSubview:self.timeAndCountNewMesView];
    
    self.nameUserLab.frame = CGRectMake(0, 0, self.nameAndContentView.frame.size.width, 20);
    self.lastMessageLab.frame = CGRectMake(self.nameUserLab.frame.origin.y  , self.nameAndContentView.frame.size.height / 2, self.nameAndContentView.frame.size.width, self.nameAndContentView.frame.size.height / 2);
    [self.lastMessageLab sizeToFit];
    
    self.avatarUserImg.frame = CGRectMake(0, 0, self.usersView.frame.size.width,self.usersView.frame.size.height);
    self.avatarUserImg.layer.cornerRadius = self.usersView.frame.size.width / 2.0f;
    self.avatarUserImg.clipsToBounds = YES;
    
    self.timeLab.frame = CGRectMake(0, 0, self.timeAndCountNewMesView.frame.size.width, 14);
    self.availableView.frame = CGRectMake(0, 0, 15  , 15);
    self.availableView.layer.cornerRadius = self.availableView.frame.size.width / 2.0f;
    
    self.availableView.center = CGPointMake(0, self.usersView.center.y);
    self.countNewMessageLab.frame = CGRectMake(0, (self.timeAndCountNewMesView.frame.size.height/ 5) * 2, self.timeAndCountNewMesView.frame.size.width, (self.timeAndCountNewMesView.frame.size.height/5) * 3);
    
}

- (void)updateContentInsideCell:(ConversationModel *)conversationModel {
    self.nameUserLab.text = conversationModel.user.userName;
    self.lastMessageLab.text = conversationModel.lastMessage;
    self.timeLab.text = conversationModel.time;
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSURL *url = conversationModel.user.avatarUrl;
        NSData * data = [[NSData alloc] initWithContentsOfURL:url];
        if (data == nil){
            NSLog(@"data is null");
        } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                self.avatarUserImg.image = [UIImage imageWithData: data];
            });
        }});
    self.countNewMessageLab.text = [NSString stringWithFormat:@"%tu", conversationModel.countNewMessage];
    if (!conversationModel.user.isAvailable) {
        [self.availableView  setHidden:YES];
    }
}

- (UIImageView *)avatarUserImg {
    if (!_avatarUserImg) {
        _avatarUserImg = UIImageView.new;
        [self.usersView addSubview:_avatarUserImg];
    }
    return _avatarUserImg;
}

- (UIView *)usersView {
    if (!_usersView) {
        _usersView = UIView.new;
        
    }
    return  _usersView;
}

- (UIView *)nameAndContentView {
    if (!_nameAndContentView) {
        _nameAndContentView = UIView.new;
    }
    return _nameAndContentView;
}

- (UIView *)timeAndCountNewMesView {
    if (!_timeAndCountNewMesView) {
        _timeAndCountNewMesView = UIView.new;
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


- (UIView *)availableView {
    if (!_availableView) {
        _availableView = UIView.new;
        _availableView.layer.borderWidth = 3.0f;
        
        _availableView.layer.borderColor = [UIColor whiteColor].CGColor;
        _availableView.backgroundColor = [UIColor greenColor];
        [self.usersView insertSubview:_availableView aboveSubview:self.avatarUserImg];
    }
    return _availableView;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = UILabel.new;
        
        _timeLab.textColor = [UIColor darkGrayColor];
        [_timeLab setFont:[UIFont systemFontOfSize:13]];
        _timeLab.textAlignment = NSTextAlignmentCenter;
        
        [self.timeAndCountNewMesView addSubview:_timeLab];
    }
    return _timeLab;
}

- (UILabel *)countNewMessageLab {
    if (!_countNewMessageLab) {
        _countNewMessageLab = UILabel.new;
        _countNewMessageLab.textColor = [UIColor darkGrayColor];
        _countNewMessageLab.backgroundColor = [UIColor redColor];
        _countNewMessageLab.layer.cornerRadius = 13;
        _countNewMessageLab.layer.masksToBounds = true;
        
        _countNewMessageLab.textAlignment = NSTextAlignmentCenter;
        [self.timeAndCountNewMesView addSubview:_countNewMessageLab];
        
    }
    return _countNewMessageLab;
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
