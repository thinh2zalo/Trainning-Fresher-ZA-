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
    NSMutableArray * arr = NSMutableArray.new;
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

    [arr addObject:user1];
    [arr addObject:user2];
    [arr addObject:user3];
    [arr addObject:user4];
    [arr addObject:user5];
    [arr addObject:user6];
    [arr addObject:user7];
    [arr addObject:user8];
    [arr addObject:user9];
    [arr addObject:user10];

    return arr;
}


@end
