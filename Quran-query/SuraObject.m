//
//  SuraObject.m
//  Quran-query
//
//  Created by zhaoAllen on 15/10/15.
//  Copyright © 2015年 zhaoAllen. All rights reserved.
//

#import "SuraObject.h"

@implementation SuraObject
-(id)init{
    self = [super init];
    if (self) {
        self.aya_array = [[NSMutableArray alloc] init];
        self.sura_name = [[NSString alloc] init];
        self.sura_id = 0;
    }
    
    return self;
}
@end
