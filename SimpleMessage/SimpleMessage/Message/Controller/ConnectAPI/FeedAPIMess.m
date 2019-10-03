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
    NSArray * arrConversations = NSArray.new;
    User * user = User.new;
    user.userName = @"Hoai Thi";
    user.friendID = 123;
    user.avatarUrl = [NSURL URLWithString:@"https://i.doanhnhansaigon.vn/2018/05/24/stevejobschikhiambao2yeutonaybanmoicothethanhcong1-1527144424_1527144452.jpeg"];
    user.isAvailable = true;
    User *user1 = User.new;
    user1.userName = @"Hoai Thi 2";
    user1.friendID = 65;
    user1.avatarUrl = [NSURL URLWithString:@"https://bstyle.vn/wp-content/uploads/2018/11/bill-gates.jpg"];
    user1.isAvailable = true;
    User *user2 = user1;
    User *user3 = user;
    User *user4 = user1;
    User *user5 = user;
    
    Message * message = Message.new;
    message.contentMessage = @"nothing here nothing here nothing here nothing here nothing here nothing here nothing here nothing here nothing here nothing here";
    message.time = @"12:12";
    
    ConversationModel * conversation = ConversationModel.new;
    conversation.arrUsers  = @[user];
    conversation.message = message;
  
    conversation.isGroupConversation = false;
    conversation.countNewMessage = 10;
    
    ConversationModel * conversation2 = conversation;
    ConversationModel * conversation3 = conversation;
    ConversationModel * conversation4 = conversation;
    
    ConversationModel * conversation5 = ConversationModel.new;
    conversation5.isGroupConversation = true;
    conversation5.message = message;
    conversation5.nameConversation = @"GROUP ZALO";
    conversation5.arrUsers = @[user, user1, user2, user3, user5];
    
    
    ConversationModel * conversation6 = conversation;
    ConversationModel * conversation7 = conversation;
    ConversationModel * conversation8 = conversation;
    ConversationModel * conversation9 = conversation;
    ConversationModel * conversation10 = conversation;
  
    arrConversations = @[conversation, conversation2, conversation3, conversation4, conversation5, conversation6, conversation7, conversation8, conversation9, conversation10];

    return arrConversations;
}
//
//- (NSArray *) setUpdataMessage: (NSInteger) conversationID {
//    NSMutableArray <Message *> * arrMess = NSMutableArray.new;
//    Friend * friend = Friend.new;
//    friend.userName = @"Steve Job";
//    friend.friendID = 11;
//    
//    
//    Message * message = Message.new;
//    message.user = friend;
//    message.contentMessage = @"hello nice to meet you";
//    message.messageId = 1;
//    message.conversationId = 1;
//    message.isSender = false;
//    Message * message5 = Message.new;
//    message5.user = friend;
//    message5.contentMessage = @"hello nice to meet you, can i ask you some question about yourself.x";
//    message5.messageId = 1;
//    message5.conversationId = 1;
//    message5.isSender = false;
//    Message * message1 = message;
//    Message * message2 = message;
//
//    Message * message3 = message;
//    [arrMess addObject:message];
//    [arrMess addObject:message1];
//    [arrMess addObject:message2];
//    [arrMess addObject:message3];
//    [arrMess addObject:message5];
//
//    return  arrMess;
//
//    
//    
//    
//    
//}

@end
