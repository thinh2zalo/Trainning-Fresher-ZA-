//
//  ConversationCell.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "ConversationCell.h"
#import "../Utility/UIView+ZBMAutoLayout.h"

@interface ConversationCell()

@end

@implementation ConversationCell



- (void)layoutSubviews {
    [super layoutSubviews];
    self.timeAndCountNewMesView;
    self.conversationStackView;
    self.usersView;
    
    [self.timeAndCountNewMesView.widthAnchor constraintEqualToConstant:[MessageCell widthOfLabel:self.timeLab.text]].active = YES;
    
    [self layoutIfNeeded];
    self.timeLab.frame = CGRectMake(0, 0, self.timeAndCountNewMesView.frame.size.width, self.timeAndCountNewMesView.frame.size.height);
    [self.timeLab sizeToFit];
    self.nameUserLab.frame = CGRectMake(0, 0, self.nameAndContentView.frame.size.width, 20);
    self.lastMessageLab.frame = CGRectMake(self.nameUserLab.frame.origin.y  , self.nameAndContentView.frame.size.height / 2, self.nameAndContentView.frame.size.width, self.nameAndContentView.frame.size.height / 2);
    [self.lastMessageLab sizeToFit];
    
    self.countNewMessageLab.frame = CGRectMake(0, (self.timeAndCountNewMesView.frame.size.height/ 5) * 2, self.timeAndCountNewMesView.frame.size.width, (self.timeAndCountNewMesView.frame.size.height/5) * 3);
    
}

- (void)updateContentInsideCell:(ConversationModel *)conversationModel {
    self.lastMessageLab.text = conversationModel.message.contentMessage;
    self.timeLab.text = conversationModel.message.time;
    
    if ( conversationModel.countNewMessage > 0) {
        if (  conversationModel.countNewMessage > 5 ) {
            self.countNewMessageLab.text = @"5+";
        } else {
            self.countNewMessageLab.text = [NSString stringWithFormat:@"%tu", conversationModel.countNewMessage];

        }
    } else [self.countNewMessageLab setHidden:YES];

}


- (UIView *)usersView {
    if (!_usersView) {
       
        _usersView = UIView.new;
        _usersView.translatesAutoresizingMaskIntoConstraints = false;
        [_usersView.widthAnchor constraintEqualToConstant:60].active = YES;
        
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
        _countNewMessageLab.textColor = [UIColor whiteColor];
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
        [_conversationStackView alignTop:@"20" leading:@"20" bottom:@"-20" trailing:@"-20" toView:self];
        [_conversationStackView addArrangedSubview:self.usersView];
        [_conversationStackView addArrangedSubview:self.nameAndContentView];
        [_conversationStackView addArrangedSubview:self.timeAndCountNewMesView];
        
    }
    return _conversationStackView;
}



@end
