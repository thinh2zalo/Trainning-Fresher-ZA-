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
        self.attributes = (NSInteger)[dict getNSNumber:@"attributes"];
        self.date = (NSInteger)[dict getNSNumber:@"date"];
        NSArray *results = [dict getNSArray:@"images"];
        for(NSDictionary *groupDic in results){
            image * imageTemp = [[image alloc] initWithDict:groupDic];
            if([image isKindOfClass:image.class]){
            [self.images addObject:imageTemp];
            }
        }
        self.descriptionOfProject = [dict getNSString:@"description"];
        self.url = [dict getURL];
        self.title = [dict getTitle];
        self.contentId = (NSInteger)[dict getNSNumber:@"content_id"];
        self.attributes = (NSInteger)[dict getNSNumber:@"attributes"];
        self.avatarHeight = (NSInteger)[dict getNSNumber:@"avatar_height"];
        self.avatarWidth  = (NSInteger)[dict getNSNumber:@"avatar_width"];
        self.categoryId   = (NSInteger)[dict getNSNumber:@"category_id"];
        self.categoryName = [dict getNSString:@"category_name"];
        self.categoryZone = [dict getNSString:@"category_zone"];
        self.publisherZone =[dict getNSString:@"publisher_zone"];
        self.commentCount = (NSInteger)[dict getNSNumber:@"comment_count"];
        self.serverIndex = (NSInteger)[dict getNSNumber:@"server_index"];
        self.publisherIcon = [dict getNSURLWithString:@"publisher_icon"];
        self.originalUrl = [dict getNSURLWithString:@"original_url"];
        self.avatarURL = [dict getNSURLWithString:@"avatar_url"];
        self.publicsherName = [dict getNSString:@"publicsher_name"];
        
       
    }
    return self;
}
@end
