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
#import "DownPicker.h"

@interface QuranViewController ()
@property (nonatomic, retain) IBOutlet UITextField *queryStr;
@property (nonatomic, retain) IBOutlet UIButton *queryBtn;
@property (nonatomic, retain) IBOutlet UIView *queryView;
@property (nonatomic, retain) IBOutlet UITextField *suarIdText;
@property (nonatomic, retain) IBOutlet UITextField *ayaIdText;
@property (nonatomic, retain) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) DownPicker *suraPicker;
@property (nonatomic, strong) DownPicker *ayaPicker;
@property (nonatomic, strong) NSString* resString;
@property (nonatomic, weak) SuraObject* tmpSura;
@property BOOL isAyaSelected;
@property int suraidSelected;

@end

@implementation QuranViewController

-(id)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}
-(bool)loadData{
    if (!self.resString) {
        self.resString = [NSString alloc];
    }
    
    if (!self.quranText.text) {
        self.quranText.text = [NSString alloc];
    }
    
    if (self.quranData) {
        NSMutableArray* suarArray = [[NSMutableArray alloc] init];
        [suarArray addObject:@"全部"];
        
        for (int i = 1; i <= self.quranData.maxSuraNum; ++i) {
            NSString* suraKey = [NSString stringWithFormat:@"%d", i];
            
            [suarArray addObject:suraKey];
            
            SuraObject* suraData = [self.quranData.suarDict objectForKey:suraKey];
            if (!suraData) {
                continue;
            }
            NSString* oriStr = self.quranText.text;
            
            for (int j = 1; j <= suraData.ayaDict.count; ++j) {
                NSString* ayaStr = [NSString stringWithFormat:@"%d", j];
                AyaObject* ayaData = [suraData.ayaDict objectForKey:ayaStr];
                
                NSString* beginStr = [NSString stringWithFormat:@"[%@:%d] %@", suraData.sura_id,j, ayaData.aya_text];
                
                oriStr = [oriStr stringByAppendingString:beginStr];
            }
            self.quranText.text = oriStr;
        }
        
        if (!self.suraPicker) {
            self.suraPicker = [[DownPicker alloc] initWithTextField:self.suarIdText withData:suarArray];
            [self.suraPicker addTarget:self action:@selector(suraSelected:) forControlEvents:UIControlEventValueChanged];
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

-(IBAction)queryData:(id)sender
{
    self.quranText.text = @"";
    
    NSString* oriStr = self.quranText.text;
        
    if (self.queryStr.text.length != 0) {
        for (int i = 1; i <= self.quranData.maxSuraNum; ++i) {
            NSString* suraKey = [NSString stringWithFormat:@"%d", i];
            
            SuraObject* suraData = [self.quranData.suarDict objectForKey:suraKey];
            for (int j = 1; j < suraData.ayaDict.count; ++j) {
                NSString* ayaStr = [NSString stringWithFormat:@"%d", j];
                AyaObject* ayaData = [suraData.ayaDict objectForKey:ayaStr];
                if ([ayaData.aya_text containsString:self.queryStr.text]) {
                    NSString* newStr = [NSString stringWithFormat:@"[%@:%@] %@", suraData.sura_id, ayaData.aya_id, ayaData.aya_text];
                    oriStr = [oriStr stringByAppendingString:newStr];
                    newStr = nil;
                }
                
            }
        }
    }
    
    self.quranText.text = oriStr;
    [self.view endEditing:YES];
    self.queryView.hidden = TRUE;
    self.queryStr.text = @"";
}


-(IBAction)searchData:(id)sender{
    if (self.suraidSelected == 0) {
        self.quranText.text = @"";
        NSLog(@"load all data");
        [self loadData];
    }
    else if (!self.isAyaSelected) {
        self.resString = @"";
        for (int i = 1; i <= self.tmpSura.maxAyaNum; ++i) {
            NSString* ayastr = [NSString stringWithFormat:@"%d", i];
            AyaObject* ayaRes = [self.tmpSura.ayaDict objectForKey:ayastr];
            NSString* tmpRes = [NSString stringWithFormat:@"[%@:%d] %@", self.tmpSura.sura_id ,i, ayaRes.aya_text];
            self.resString = [self.resString stringByAppendingString:tmpRes];
        }
        self.quranText.text = self.resString;
    }
    else if (self.resString) {
        if (!self.quranText.text) {
            self.quranText.text = [NSString alloc];
        }
        NSLog(@"search res %@", self.resString);
        self.quranText.text = self.resString;
    }
    
    self.queryView.hidden = TRUE;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *myTouch = [touches anyObject];
    
    CGPoint point = [myTouch locationInView:self.view];
    if (point.x < 160) {
        if (self.queryView.hidden) {
            self.queryView.hidden = false;
        }
    }
}

-(void)ayaSelected:(id)ayaId{
    if (self.suraidSelected == 0) {
        return;
    }
    
    NSString *tempAyaId = [self.ayaPicker text];
    
    if (self.tmpSura) {
        self.resString = @"";
        
        if ([tempAyaId isEqualToString:@"全部"]) {
            for (int i = 1; i <= self.tmpSura.maxAyaNum; ++i) {
                NSString* ayastr = [NSString stringWithFormat:@"%d", i];
                AyaObject* ayaRes = [self.tmpSura.ayaDict objectForKey:ayastr];
                NSString* tmpRes = [NSString stringWithFormat:@"[%@:%d] %@", self.tmpSura.sura_id ,i, ayaRes.aya_text];
                self.resString = [self.resString stringByAppendingString:tmpRes];
            }
        }
        else {
            AyaObject* ayaRes = [self.tmpSura.ayaDict objectForKey:tempAyaId];
            if (!ayaRes) {
                return;
            }
            
            self.resString = [NSString stringWithFormat:@"[%@:%@] %@", self.tmpSura.sura_id ,tempAyaId, ayaRes.aya_text];
        }
    }
    
    NSLog(@"ayaid:%@ res:%@", tempAyaId, self.resString);
    self.isAyaSelected = true;
}

-(void)suraSelected:(id)suraId{
    NSString *tempSuraId = [self.suraPicker text];
    
    NSMutableArray * ayaArray = [[NSMutableArray alloc] init];
    if (self.ayaPicker) {
        self.ayaPicker = nil;
    }
    
    NSLog(@"suraid %@", tempSuraId);
    
    if ([tempSuraId isEqualToString:@"全部"]) {
        self.suraidSelected = 0;
    }
    else {
        self.suraidSelected = [tempSuraId intValue];
        
        self.tmpSura = [self.quranData.suarDict objectForKey:tempSuraId];
        if (self.tmpSura) {
            [ayaArray addObject:@"全部"];
            for (int i = 1; i <= self.tmpSura.ayaDict.count; ++i)
            {
                NSString* tmp = [NSString stringWithFormat:@"%d", i];
                [ayaArray addObject:tmp];
            }
        }
    }
    self.ayaPicker = [[DownPicker alloc] initWithTextField:self.ayaIdText withData:ayaArray];
    [self.ayaPicker addTarget:self action:@selector(ayaSelected:) forControlEvents:UIControlEventValueChanged];
    [self.ayaPicker setValueAtIndex:0];
    self.isAyaSelected = false;
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
