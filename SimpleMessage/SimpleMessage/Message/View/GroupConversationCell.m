//
//  GroupConversationCell.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "GroupConversationCell.h"
@implementation GroupConversationCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.groupAvatarView.frame = CGRectMake(0, 0, self.usersView.frame.size.width, self.usersView.frame.size.height);
}

- (void)updateContentInsideCell:(ConversationModel *)conversationModel {
    [super updateContentInsideCell:conversationModel];
    self.nameUserLab.text = conversationModel.nameConversation;
    
    
    
    if ([conversationModel.arrUsers count] <= 4) {
        int index = 0;
        
        for (User * user in conversationModel.arrUsers) {
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                
                NSURL *url = user.avatarUrl;
                NSData * data = [[NSData alloc] initWithContentsOfURL:url];
                if (data == nil){
                    NSLog(@"data is null");
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.groupAvatarView.arrAvatarView[index].image = [UIImage imageWithData: data];
                    });
                }});
            index = index + 1;
            
        }
    } else {
        for (int i = 0; i < 3 ; i ++) {
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                
                NSURL *url = conversationModel.arrUsers[i].avatarUrl;
                NSData * data = [[NSData alloc] initWithContentsOfURL:url];
                if (data == nil){
                    NSLog(@"data is null");
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.groupAvatarView.arrAvatarView[i].image = [UIImage imageWithData: data];
                    });
                }});
        }
        self.groupAvatarView.remainingAmountLabel.text = [NSString stringWithFormat:@"%tu", [conversationModel.arrUsers count] - 3 ];
    }
    
    
    //    if ([conversationModel.arrUsers count] > 4) {
    //        int index = 0;
    //        for (int i = 0 ; i < 3 ; i ++) {
    //            dispatch_async(dispatch_get_global_queue(0,0), ^{
    //
    //                NSURL *url = conversationModel.arrUsers[i].avatarUrl;
    //                NSData * data = [[NSData alloc] initWithContentsOfURL:url];
    //                if (data == nil){
    //                    NSLog(@"data is null");
    //                } else {
    //                    dispatch_async(dispatch_get_main_queue(), ^{
    //                        self.groupAvatarView.arrAvatarView[i].image = [UIImage imageWithData: data];
    //                    });
    //                }});
    //        }
    //
    //
    //
    //    }
}

- (GroupAvatarView *)groupAvatarView {
    if (!_groupAvatarView) {
        
        _groupAvatarView = GroupAvatarView.new;
        [self.usersView addSubview:_groupAvatarView];
        
    }
    return _groupAvatarView;
}

@end
