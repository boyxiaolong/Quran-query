//
//  AppDelegate.m
//  Quran-query
//
//  Created by zhaoAllen on 15/10/14.
//  Copyright © 2015年 zhaoAllen. All rights reserved.
//

#import "AppDelegate.h"
#import "QuranObject.h"
#import "SuraObject.h"
#import "AyaObject.h"

@interface AppDelegate ()

@property (strong, nonatomic) QuranObject *quranData;
@property (strong, nonatomic) SuraObject *tmpSura;
@property (strong, nonatomic) AyaObject *tmpAya;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor purpleColor];
    self.query_vc = [[QuranViewController alloc] init];
    self.window.rootViewController = self.query_vc;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"GuLan" ofType:@"xml"];
    NSFileHandle *file = [NSFileHandle fileHandleForReadingAtPath:path];
    NSData *data = [file readDataToEndOfFile];
    NSLog(@"data len:%d", [data length]);
    
    NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithData:data];
    
    [xmlparser setDelegate:self];
    BOOL res = [xmlparser parse];
    if (res){
        NSLog(@"parse success");
    }
    else {
        NSLog(@"parse failed");
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ( [elementName isEqualToString:@"quran"]) {
        if (!self.quranData)
            self.quranData = [[QuranObject alloc] init];
        NSLog(@"begin quran");
    }
    else if ( [elementName isEqualToString:@"sura"] ) {
        if (!self.tmpSura) {
            self.tmpSura = [[SuraObject alloc] init];
        }
        self.tmpSura.sura_id = [[attributeDict objectForKey:@"id"] integerValue];
        self.tmpSura.sura_name = [attributeDict objectForKey:@"name"];
        NSLog(@"sura id:%d name:%@", self.tmpSura.sura_id, self.tmpSura.sura_name);
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
}


@end
