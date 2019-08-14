//
//  body.m
//  step4
//
//  Created by CPU11606 on 8/5/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "Body.h"

@implementation Body
-(Body *)initWithDict:(NSDictionary *) dict{
    self = [super init];
    if(self){
        self.type =     [dict getNSString:@"type"];
        self.content =  [dict getNSString:@"content"];
        self.descriptionOfProject = [dict getNSString:@"description"];
    }
    return  self;
}
@end

