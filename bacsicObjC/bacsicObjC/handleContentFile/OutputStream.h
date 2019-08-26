//
//  OutputStream.h
//  bacsicObjC
//
//  Created by CPU11606 on 8/11/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stream.h"
NS_ASSUME_NONNULL_BEGIN

@interface OutputStream : Stream

-(OutputStream *)initWithPath:(NSString *)urlInput;
typedef void(^Block)(OutputStream * outputStream);
- (void)use :(Block )block;
-(void)writeData:(NSData *)data;
@end          

NS_ASSUME_NONNULL_END
