//
//  QuranObject.m
//  Quran-query
//
//  Created by zhaoAllen on 15/10/15.
//  Copyright © 2015年 zhaoAllen. All rights reserved.
//

#import "QuranObject.h"
#import "SuraObject.h"

@implementation QuranObject

-(id)init{
    self = [super init];
    
    if (self) {
        self.suar_array = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
