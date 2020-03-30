//
//  Quotations.m
//  CalculatorBM
//
//  Created by vincent on 3/2/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "SingletonAPI.h"
#import "define.h"
@interface SingletonAPI()
@property (nonatomic, strong)NSArray *quotationArr;
@property (nonatomic, strong)NSArray *imageArr;

@end
@implementation SingletonAPI
+ (SingletonAPI *)sharedInstance {
    static SingletonAPI *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)getQuote:(NSInteger)jdn {
    NSInteger r = arc4random_uniform((uint32_t)self.getQuotationArr.count);
    return self.getQuotationArr[r];
}

-(NSURL *)getURLImage:(NSInteger)jdn {
    if (self.getImageArr.count == 0) {
        return nil;
    }
    NSInteger index = jdn % self.getImageArr.count;
    NSString * strURL = self.getImageArr[index];
    return [NSURL URLWithString:strURL];
}

- (void)setQuotationArr:(NSArray *)quotationArr {
    if (![quotationArr isKindOfClass:NSArray.class]) {
        return;
    }
    _quotationArr = [NSArray arrayWithArray:quotationArr];
}

- (void)setImageArr:(NSArray *)imageArr {
    if (![imageArr isKindOfClass:NSArray.class]) {
        return;
    }
   _imageArr = [NSArray arrayWithArray:imageArr];
}

- (NSArray *)getQuotationArr {
    if (!_quotationArr) {
        _quotationArr = NSArray.new;
    }
    return [_quotationArr copy];
}

- (NSArray *)getImageArr {
    if (!_imageArr) {
        _imageArr = NSArray.new;
        }
    return _imageArr;
}

@end
