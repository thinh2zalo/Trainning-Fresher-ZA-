//
//  data.m
//  step4
//
//  Created by CPU11606 on 8/4/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "Data.h"
#import "NSDictionary+ParseJson.h"
@implementation Data


/**
 function to init object Data with param is a dictionary
 
 @param dict dictionary
 @return object data
 */
-(Data*)initWithDict:(NSDictionary *) dict{
    self = [super init];
    if (self){
        NSArray *arrResults = [dict getNSArray:@"contents"];
          for (NSDictionary *groupDic in arrResults) {
                Content * contentTemp = [[Content alloc] initWithDict:groupDic];
                if ([contentTemp isKindOfClass:Content.class]) {
                    [self.contents addObject:contentTemp];
                }
        }
        NSArray *arrResultsBoxes = [dict getNSArray:@"boxes"];
        for (NSDictionary *groupDic in arrResultsBoxes) {
            Box * boxesTemp = [[Box alloc] initWithDict:groupDic];
            if ([boxesTemp isKindOfClass:Box.class]) {
                [self.boxes addObject:boxesTemp];
            }
        }
    }
    self.tittle = [dict getTitle];
    return self;
    
}
@end
