//
//  Question.m
//  categoryExample
//
//  Created by CPU11606 on 8/7/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "QuestionModel.h"
#import <objc/runtime.h>


@implementation Question
-(Question *)initWithDict:(NSDictionary *) dict{
    if (!SAFE_TYPE(dict, NSDictionary)) {
        return nil;
    }
    self = [super init];
    if(self){
        self.title = [dict getTitle] ;
        self.date = [dict getNSNumber:@"date"].integerValue ;
        self.attributes = [dict getNSNumber:@"attributes"].integerValue;
        self.publisherId = [dict getNSNumber:@"publisher_id"].integerValue ;
        self.categoryId = [dict getNSNumber:@"category_id"].integerValue ;
        self.answerCount = [dict getNSNumber:@"answer_count"].integerValue ;
        self.serverIndex = [dict getNSNumber:@"server_index"].integerValue ;
        self.url = [dict getURL] ;
        self.publisherIcon = [dict getNSString:@"publisher_icon"];
        self.publisherName = [dict getNSString:@"publisher_name"] ;
        self.publisherZone = [dict getNSString:@"publisher_zone"];
        self.categoryZone = [dict getNSString:@"category_zone"] ;
        self.categoryName = [dict getNSString:@"category_name"];
        
        self.bodies = [dict getNSArray:@"body"];
        NSArray *results = [dict getNSArray:@"images"];
        self.bodies = NSMutableArray.new;
        for(NSDictionary *groupDic in results){
            Image * imageTemp = [[Image alloc] initWithDict:groupDic];
            if(SAFE_TYPE(imageTemp, Image)){
                [self.images addObject:imageTemp];
            }
        }
    }
    return self;
}
@end

