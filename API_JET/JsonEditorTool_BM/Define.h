//
//  Define.h
//  JsonEditorTool
//
//  Created by Steve on 11/30/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define SAFE_TYPE(pointer, type) [pointer isKindOfClass:type.class]
#define SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAIN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define URL @"https://data.baomoi.com/app.aspx?method=settings&os=ios&ver=99.99.99"
#endif /* Define_h */
#define FOR_IN(type, var, collection) \
  for (type var in collection)\
  {
#define END_FOR_IN(collection) }
//#else
void objc_enumerationMutation(id);
#define FOR_IN(type, var, c) \
do\
{\
  type var;\
  NSFastEnumerationState gs_##c##_enumState = { 0 };\
  id gs_##c##_items[16];\
  unsigned long gs_##c##_limit = \
    [c countByEnumeratingWithState: &gs_##c##_enumState \
                           objects: gs_##c##_items \
                             count: 16];\
  if (gs_##c##_limit)\
  {\
    unsigned long gs_startMutations = *gs_##c##_enumState.mutationsPtr;\
    do {\
      unsigned long gs_##c##counter = 0;\
      do {\
        if (gs_startMutations != *gs_##c##_enumState.mutationsPtr)\
        {\
          objc_enumerationMutation(c);\
        }\
        var = gs_##c##_enumState.itemsPtr[gs_##c##counter++];\

#define END_FOR_IN(c) \
      } while (gs_##c##counter < gs_##c##_limit);\
    } while ((gs_##c##_limit \
      = [c countByEnumeratingWithState: &gs_##c##_enumState\
                   objects: gs_##c##_items\
                 count: 16]));\
  }\
} while(0);
