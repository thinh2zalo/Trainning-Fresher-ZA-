//
//  FeedAPIContact.m
//  bacsicObjC
//
//  Created by Steve on 9/26/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "FeedAPIContact.h"


@implementation FeedAPIContact

+ (NSArray <User *> *) queryContact {
    NSArray * arr = NSArray.new;
    User * user1 = User.new;
    user1.userName = @"Nguyen Thi";

    User * user2 = User.new;
    user2.userName = @"steve";
    User * user3 = User.new;
    user3.userName = @"mark thih";
    User * user4 = User.new;
    user4.userName = @"alibaba ba";
    User * user5 = User.new;
    user5.userName = @"jack matydt";
    
    User * user6 = User.new;
    user6.userName = @"banama";
    User * user7 = User.new;
    user7.userName = @"vanci";
    User * user8 = User.new;
    user8.userName = @"vigo";
    User * user9 = User.new;
    user9.userName = @"pitago";
    User * user10 = User.new;
    user10.userName = @"Nguyen tung";

    arr = @[user1,user2,user3,user4, user5, user6, user7, user8, user9, user10];

    return arr;
}


@end
