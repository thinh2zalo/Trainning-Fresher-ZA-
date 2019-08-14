//
//  contents.m
//  step4
//
//  Created by CPU11606 on 8/4/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "Content.h"

@implementation Content
-(Content *)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self){
        self.attributes = [dict getNSNumber:@"attributes"].integerValue;
        self.date = [dict getNSNumber:@"date"].integerValue;
        NSArray *results = [dict getNSArray:@"images"];
        self.images = NSMutableArray.new;
        for(NSDictionary *groupDic in results){
            Image * imageTemp = [[Image alloc] initWithDict:groupDic];
            if(SAFE_TYPE(imageTemp, Image)){
                [self.images addObject:imageTemp];
            }
        }
        self.descriptionOfProject = [dict getNSString:@"description"];
        self.url = [dict getURL];
        self.title = [dict getTitle];
        self.contentId = [dict getNSNumber:@"content_id"].integerValue;
        self.attributes = [dict getNSNumber:@"attributes"].integerValue;
        self.avatarHeight = [dict getNSNumber:@"avatar_height"].integerValue;
        self.avatarWidth  = [dict getNSNumber:@"avatar_width"].integerValue;
        self.categoryId   = [dict getNSNumber:@"category_id"].integerValue;
        self.categoryName = [dict getNSString:@"category_name"];
        self.categoryZone = [dict getNSString:@"category_zone"];
        self.publisherZone =[dict getNSString:@"publisher_zone"];
        self.commentCount = [dict getNSNumber:@"comment_count"].integerValue;
        self.serverIndex =  [dict getNSNumber:@"server_index"].integerValue;
        self.publisherIcon = [dict getNSURLWithString:@"publisher_icon"];
        self.originalUrl = [dict getNSURLWithString:@"original_url"];
        self.avatarURL = [dict getNSURLWithString:@"avatar_url"];
        self.publicsherName = [dict getNSString:@"publisher_name"];
    }
    return self;
}
@end
