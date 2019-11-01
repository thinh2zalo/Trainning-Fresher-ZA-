//
//  Define.h
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#ifndef Define_h
#define Define_h
#define MARGIN 12
#define KEY_WINDOW_SAFE_AREA_INSETS [UIApplication sharedApplication].keyWindow.safeAreaInsets
#define SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAIN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SAFE_TYPE(pointer, type) [pointer isKindOfClass:type.class]

#define RGB(r, g, b) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0]


#endif /* Define_h */
