//
//  AyaObject.m
//  Quran-query
//
//  Created by zhaoAllen on 15/10/15.
//  Copyright © 2015年 zhaoAllen. All rights reserved.
//

#import "AyaObject.h"

@implementation AyaObject
-(id)init {
    self = [super init];
    if (self) {
        self.aya_id = [NSString alloc];
        self.aya_text = [NSString alloc];
    }
    
    return self;
}
@end
