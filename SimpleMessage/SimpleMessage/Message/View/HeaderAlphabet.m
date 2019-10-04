//
//  HeaderAlphabet.m
//  bacsicObjC
//
//  Created by Steve on 9/26/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "HeaderAlphabet.h"

@implementation HeaderAlphabet

- (void)layoutSubviews {
    self.backgroundColor = [UIColor grayColor];
    self.alphabetLabel.frame = CGRectMake(20, 0, self.frame.size.width, self.frame.size.height);
}
- (void)setAlphabet:(NSString *) alphabet {
    self.alphabetLabel.text = alphabet;
}
- (UILabel *)alphabetLabel {
    if (!_alphabetLabel) {
        _alphabetLabel = UILabel.new;
        [self addSubview:_alphabetLabel];
    }
    return _alphabetLabel;
}

@end
