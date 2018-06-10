//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import "AppDelegate.h"
#import "AppDataCache.h"

#import "MenuNavigationViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize navigationController;;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //UINavigationBar *bar = [self.navigationController navigationBar];
    //[bar setTintColor: [UIColor blackColor]];
    
  //  bar.tintColor = uicolorFromHex(0xffffff);
  //  bar.barTintColor = uicolorFromHex(0x034517);
  // [self setAppearance];
    
    navigationController.navigationBar.barTintColor = [UIColor greenColor];
    return YES;
}

#pragma mark - Utility methods

- (void)setAppearance
{
    NSString *blue = @"FFCD05";
    int b =0;
    sscanf([blue UTF8String],"%x",&b);
    UIColor* btnColor = UIColorFromRGB(b);
    
	
   	[navigationController.navigationBar setTintColor:btnColor];
        [navigationController.navigationBar setBarTintColor:btnColor];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

//- (void)applicationDidBecomeActive:(UIApplication *)application
//{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//}

// FB
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"url recieved: %@", url);
    NSLog(@"query string: %@", [url query]);
    NSLog(@"host: %@", [url host]);
    NSLog(@"url path: %@", [url path]);
    NSDictionary *dict = [self parseQueryString:[url query]];
    NSLog(@"query dict: %@", dict);
    return YES;
}

- (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
   // NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
   // NSLog(@"URL scheme:%@", [url scheme]);
   // NSLog(@"URL query: %@", [url query]);
   // NSLog(@"url recieved: %@", url);
    
    // myApp://?mID=12
    // NSDictionary *dict = [self parseQueryString:[url query]];
    
    // NSString  *mID = [dict objectForKey: @"mID"];
    // NSLog(@"mID = %@",mID);
    
    /*
    if(mID) {
        NSInteger intValue=[mID integerValue];
        NSLog(@"intValue =%ld",intValue);
        [AppDataCache shared].linkMarketID = intValue;
        NSInteger linkMarketID = [AppDataCache shared].linkMarketID;
        NSLog(@"linkMarketID =%ld",linkMarketID);
        ViewController *vc = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        
        [self.navigationController pushViewController:vc animated:YES];

    }
     */
    // FB Track App Installs and App Opens
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

@end
