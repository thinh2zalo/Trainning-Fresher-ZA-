//
//  boxes.m
//  step4
//
//  Created by CPU11606 on 8/5/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "Box.h"

@implementation Box
@dynamic  description;

-(Box *)initWithDict:(NSDictionary *) dict{
    self = [super init];
    if(self){
        self.title = [dict getTitle] ;
        self.zone = [dict getNSString:@"zone"] ;
        self.position = (NSInteger)[dict getNSNumber:@"position"] ;
        self.sectionBoxId = (NSInteger)[dict getNSNumber:@"section_box_id"] ;
        self.positions = [dict getNSArray:@"positions"];
        NSArray *results = [dict getNSArray:@"questions"];
        for (NSDictionary *groupDic in results){
            Question * quesTemp = [[Question alloc] initWithDict:groupDic];
            if([quesTemp isKindOfClass:Question.class]){
                [self.questions addObject:quesTemp];
            }
        }
        self.displayType = (NSInteger)[dict getNSNumber:@"display_type"] ;
        self.maxShow =     (NSInteger)[dict getNSNumber:@"max_show"] ;
        self.objectType = (NSInteger)[dict getNSNumber:@"object_type"] ;
        }
    return self;
}
@end
