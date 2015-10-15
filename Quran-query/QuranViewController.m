//
//  QuranViewController.m
//  Quran-query
//
//  Created by zhaoAllen on 15/10/15.
//  Copyright © 2015年 zhaoAllen. All rights reserved.
//

#import "QuranViewController.h"
#import "AppDelegate.h"
#import "SuraObject.h"
#import "AyaObject.h"

@interface QuranViewController ()

@property (nonatomic, retain) IBOutlet UITextView *quranText;

@end

@implementation QuranViewController

-(id)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}
-(bool)loadData: (QuranObject*) data {
    if (data) {
        for (int i = 0; i < data.suar_array.count; ++i) {
            SuraObject* suraData = data.suar_array[i];
            NSString* oriStr = self.quranText.text;
            oriStr = [oriStr stringByAppendingString:suraData.sura_name];
            self.quranText.text = oriStr;
        }
    }
    
    return true;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loadDatas:(id)sender
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
