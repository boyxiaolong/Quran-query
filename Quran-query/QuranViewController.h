//
//  QuranViewController.h
//  Quran-query
//
//  Created by zhaoAllen on 15/10/15.
//  Copyright © 2015年 zhaoAllen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuranObject.h"

@interface QuranViewController : UIViewController
-(bool)loadData;
@property (nonatomic, retain) IBOutlet UITextView *quranText;
@property (strong, nonatomic) QuranObject *quranData;

@end
