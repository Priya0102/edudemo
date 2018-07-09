
//https://www.appcoda.com/firebase-push-notifications/

#import "AppDelegate.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Firebase.h"
#import <unistd.h>
#import "Base.h"
#import "Constant.h"
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@import UserNotifications;
#endif
@import Firebase;
@import FirebaseMessaging;

@interface AppDelegate ()<UNUserNotificationCenterDelegate>
#define IDIOM UI_USER_INTERFACE_IDIOM()
#define IPAD UIUserInterfaceIdiomPad
{
    NSString *fcmTokenStr;
    NSString *deviceTokenStr;
}
@end

@implementation AppDelegate
NSString *const kGCMMessageIDKey = @"gcm.message_id";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     [GMSServices provideAPIKey:@"AIzaSyDbek3lpitxvxzDLwO31rlpPwsUfgRbrEA"];
     [FIRApp configure];
     [FIRMessaging messaging].delegate=self;
      application.applicationIconBadgeNumber = 0;
   
  
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSArray arrayWithObjects:@"en", nil] forKey:@"AppleLanguages"];
    [defaults synchronize];
    
   
    UIStoryboard *storyboard = [self grabStoryboard];
    
    // display storyboard
    self.window.rootViewController = [storyboard instantiateInitialViewController];
    [self.window makeKeyAndVisible];
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    
    
    if(savedValue!=NULL)
    {
        int screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        
        switch (screenHeight) {
                // iPhone 4s
            case 480:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
                //iPhone 5 & iPhone SE
            case 548:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
                // iPhone 5s
            case 568:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
                // iPhone 6 & 6s & iPhone 7
            case 647:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
            case 812:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main3" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"Main3" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
            default:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"Main2" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
                
        }
    }
   
    if ([UNUserNotificationCenter class] != nil) {
        // iOS 10 or later
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
        UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter]
         requestAuthorizationWithOptions:authOptions
         completionHandler:^(BOOL granted, NSError * _Nullable error) {
             // ...
         }];
    } else {
        // iOS 10 notifications aren't available; fall back to iOS 8-9 notifications.
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    [application registerForRemoteNotifications];
   
    
    return YES;
}

- (UIStoryboard *)grabStoryboard {
    
    // determine screen size
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    NSLog(@"screenheight==== %d",screenHeight);
    UIStoryboard *storyboard;
    
    switch (screenHeight) {
            // iPhone 4s
        case 480:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            //iPhone 5 & iPhone SE
        case 548:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            // iPhone 5s
        case 568:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            // iPhone 6 & 6s & iPhone 7
        case 647:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            
        default:
            
        storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
        break;

    }
    
    return storyboard;
}
- (void)renumberBadgesOfPendingNotifications
{
    // clear the badge on the icon
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    // first get a copy of all pending notifications (unfortunately you cannot 'modify' a pending notification)
    NSArray *pendingNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    // if there are any pending notifications -> adjust their badge number
    if (pendingNotifications.count != 0)
    {
        // clear all pending notifications
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        // the for loop will 'restore' the pending notifications, but with corrected badge numbers
        // note : a more advanced method could 'sort' the notifications first !!!
        NSUInteger badgeNbr = 1;
        
        for (UILocalNotification *notification in pendingNotifications)
        {
            // modify the badgeNumber
            notification.applicationIconBadgeNumber = badgeNbr++;
            
            // schedule 'again'
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
    
}

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// Handle incoming notification messages while app is in the foreground.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[Messaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionNone);
}
// Receive displayed notifications for iOS 10 devices.
// Handle incoming notification messages while app is in the foreground

// Handle notification messages after display notification is tapped by the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler();
}

- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    NSLog(@"recieve new FCM registration token: %@", fcmToken);
    
    [[NSUserDefaults standardUserDefaults] setObject:fcmToken forKey:@"fcmToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    fcmTokenStr=[NSString stringWithFormat:@"token=%@",fcmToken];
//    NSLog(@"FCM DEVICE TOKEN.....:%@",fcmTokenStr);

}

#endif
- (void)messaging:(nonnull FIRMessaging *)messaging didRefreshRegistrationToken:(nonnull NSString *)fcmToken {
   
    NSLog(@"****FCM registration token: %@", fcmToken);
    // TODO: If necessary send token to application server.
//
//    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
//   fcmTokenStr=[NSString stringWithFormat:@"token=%@",fcmToken];
//   NSLog(@"DEVICE TOKEN.....:%@",fcmTokenStr);
    
  
    
}

- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {
    NSLog(@"Received data message: %@", remoteMessage.appData);
}

// [END ios_10_data_message]

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Unable to register for remote notifications: %@", error);
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"APNs device token retrieved: %@", deviceToken);
    NSString *deviceTokenString=[deviceToken description];
    deviceTokenString=[deviceTokenString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
   
    NSString *str=[deviceTokenString stringByReplacingOccurrencesOfString:@"\\s" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0,[deviceTokenString length])];
     NSLog(@"str==%@",str);
    
    [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
     NSLog(@"***deviceid***** = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]);

    // With swizzling disabled you must set the APNs device token here.
    // [Messaging messaging].APNSToken = deviceToken;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
