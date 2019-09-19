//
//  FeedAPI.m
//  bacsicObjC
//
//  Created by Steve on 9/17/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "FeedAPMess.h"

@implementation FeedAPIMess
- (NSArray <ConversationModel *> *)setupData {
    NSMutableArray * arrConversations = NSMutableArray.new;
    Friend * friend = Friend.new;
    friend.userName = @"Hoai Thi";
    friend.friendID = 123;
    ConversationModel * conversation = ConversationModel.new;
    conversation.user = friend;
    conversation.lastMessage = @"nothinghere nothinghere nothinghere nothinghere nothinghere nothinghere";
    conversation.time = @"12:12";
    conversation.isGroupConversation = false;
    conversation.countNewMessage = 10;
    
    
    ConversationModel * conversation2 = conversation;
    ConversationModel * conversation3 = conversation;
    ConversationModel * conversation4 = conversation;
    ConversationModel * conversation5 = conversation;
    ConversationModel * conversation6 = conversation;
    ConversationModel * conversation7 = conversation;
    ConversationModel * conversation8 = conversation;
    ConversationModel * conversation9 = conversation;
    ConversationModel * conversation10 = conversation;
    
    [arrConversations  addObject:conversation];
    [arrConversations  addObject:conversation2];
    [arrConversations  addObject:conversation3];
    [arrConversations  addObject:conversation4];
    [arrConversations  addObject:conversation5];
    [arrConversations  addObject:conversation6];
    [arrConversations  addObject:conversation7];
    [arrConversations  addObject:conversation8];
    [arrConversations  addObject:conversation9];
    [arrConversations  addObject:conversation10];
    return arrConversations;
}

- (NSArray *) setUpdataMessage: (NSInteger) conversationID {
    NSMutableArray <Message *> * arrMess = NSMutableArray.new;
    Friend * friend = Friend.new;
    friend.userName = @"Steve Job";
    friend.friendID = 11;
    
    
    Message * message = Message.new;
    message.user = friend;
    message.contentMessage = @"hello nice to meet you";
    message.messageId = 1;
    message.conversationId = 1;
    message.isSender = false;
    Message * message5 = Message.new;
    message5.user = friend;
    message5.contentMessage = @"hello nice to meet you, can i ask you some question about yourself.x";
    message5.messageId = 1;
    message5.conversationId = 1;
    message5.isSender = false;
    Message * message1 = message;
    Message * message2 = message;

    Message * message3 = message;
    [arrMess addObject:message];
    [arrMess addObject:message1];
    [arrMess addObject:message2];
    [arrMess addObject:message3];
    [arrMess addObject:message5];

    return  arrMess;

    
    
    
    
}

@end
