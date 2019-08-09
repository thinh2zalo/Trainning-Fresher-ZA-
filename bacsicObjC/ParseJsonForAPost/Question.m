//
//  Question.m
//  categoryExample
//
//  Created by CPU11606 on 8/7/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "Question.h"

@implementation Question
-(Question *)initWithDict:(NSDictionary *) dict{
    self = [super init];
    if(self){
        self.title = [dict getTitle] ;
        self.date = (NSInteger)[dict getNSNumber:@"date"] ;
        self.attributes = (NSInteger)[dict getNSNumber:@"attributes"] ;
        self.publisherId = (NSInteger)[dict getNSNumber:@"publisher_id"] ;
        self.categoryId = (NSInteger)[dict getNSNumber:@"category_id"] ;
        self.answerCount = (NSInteger)[dict getNSNumber:@"answer_count"] ;
        self.serverIndex = (NSInteger)[dict getNSNumber:@"server_index"] ;
        self.url = [dict getURL] ;
        self.publisherIcon = [dict getNSString:@"publisher_icon"];
        self.publisherName = [dict getNSString:@"publisher_name"] ;
        self.publisherZone = [dict getNSString:@"publisher_zone"];
        self.categoryZone = [dict getNSString:@"category_zone"] ;
        self.categoryName = [dict getNSString:@"category_name"];
        NSArray  * temp = [dict getNSArray:@"body"];
        self.bodies = [temp copy];
        NSArray *results = [dict getNSArray:@"images"];
        for(NSDictionary *groupDic in results){
            image * imageTemp = [[image alloc] initWithDict:groupDic];
            if([imageTemp isKindOfClass:image.class]){
                [self.images addObject:imageTemp];
            }
        }
    }
    return self;
}
@end
