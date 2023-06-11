//
//  ZBFancyCollectionViewPrefixHeader.h
//  ZBKit
//
//  Created by xzb on 2018/6/3.
//

#ifndef ZBFancyCollectionViewPrefixHeader_h
#define ZBFancyCollectionViewPrefixHeader_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSArray+ZBBlockKit.h"

#ifndef ZBLazyProperty
#define ZBLazyProperty(cls, var) \
    -(cls *) var                 \
    {                            \
        if (_##var == nil) {     \
            _##var = [cls new];  \
        }                        \
        return _##var;           \
    }
#endif

#ifndef ZBLazyPropertyWithInit
#define ZBLazyPropertyWithInit(cls, var, code) \
    -(cls *) var                               \
    {                                          \
        if (_##var == nil) {                   \
            _##var = [cls new];                \
            {                                  \
                code                           \
            }                                  \
        }                                      \
        return _##var;                         \
    }
#endif

#ifdef DEBUG
    #define NSLog(...) NSLog(__VA_ARGS__)
#else
    #define NSLog(...)
#endif

#endif /* ZBFancyCollectionViewPrefixHeader_h */
