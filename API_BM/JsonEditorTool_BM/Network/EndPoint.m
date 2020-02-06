//
//  EndPoint.m
//  JsonEditorTool
//
//  Created by Steve on 11/30/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "EndPoint.h"

@implementation EndPoint

- (instancetype)initWithOs:(NSString *)os andVer:(NSString *)ver
{
    self = [super init];
    if (self) {
        _osStr = os;
        _verStr = ver;
    }
    return self;
}

- (NSString *)urlRequest {
    if (!_urlRequest) {
        _urlRequest = [NSString stringWithFormat:@"https://data.baomoi.com/app.aspx?method=settings&os=%@&ver=%@",_osStr, _verStr];
    }
    return _urlRequest;
}

@end
