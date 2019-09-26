//
//  SingleConversationCellTableViewCell.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "SingleConversationCell.h"

@implementation SingleConversationCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.singleAvatar.frame = CGRectMake(0, 0, self.usersView.frame.size.width, self.usersView.frame.size.height);
    
   
}

- (void)updateContentInsideCell:(ConversationModel *)conversationModel {
    [super updateContentInsideCell:conversationModel];
    if ([conversationModel.arrUsers[0] isKindOfClass:User.class]) {
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            
            NSURL *url = conversationModel.arrUsers[0].avatarUrl;
            NSData * data = [[NSData alloc] initWithContentsOfURL:url];
            if (data == nil){
                NSLog(@"data is null");
            } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                    self.singleAvatar.avatarUserImg.image = [UIImage imageWithData: data];
                });
            }});
        self.nameUserLab.text = conversationModel.arrUsers[0].userName;
    }
    
}

- (SingleAvatar *)singleAvatar {
    if (!_singleAvatar) {
        _singleAvatar = SingleAvatar.new;
        [self.usersView addSubview:_singleAvatar];
    }
    return _singleAvatar;
}

@end
