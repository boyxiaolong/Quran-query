//
//  SuraObject.h
//  Quran-query
//
//  Created by zhaoAllen on 15/10/15.
//  Copyright © 2015年 zhaoAllen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuraObject : NSObject
@property NSString* sura_id;
@property NSString *sura_name;
@property NSMutableDictionary* ayaDict;
@property int maxAyaNum;
@end
