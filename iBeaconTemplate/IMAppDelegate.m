//
//  IMAppDelegate.m
//  iBeaconTemplate
//
//  Created by James Nick Sears on 5/29/14.
//  Copyright (c) 2014 iBeaconModules.us. All rights reserved.
//

#import "IMAppDelegate.h"
#import "IMViewController.h"
#import <CoreLocation/CoreLocation.h>

@implementation IMAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Just for showing launch image longer
    [NSThread sleepForTimeInterval:2]; //add 2 seconds longer.
    
    // Override point for customization after application launch.
    NSUUID *beaconUUID = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
    NSString *regionIdentifier = @"gogo.iBeacon";
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:beaconUUID identifier:regionIdentifier];

    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"Authorized Always");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"Authorized when in use");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"Denied");
            break;
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"Not determined");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
            
        default:
            break;
    }
    
    self.locationManager = [[CLLocationManager alloc] init];
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.delegate = self;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    [self.locationManager startMonitoringForRegion:beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
    [self.locationManager startUpdatingLocation];
    
    return YES;
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    [manager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
    [self.locationManager startUpdatingLocation];
    
    NSLog(@"偵測範圍內有寶物");
    [self sendLocalNotificationWithMessage:@"偵測範圍內有寶物"];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    [manager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
    [self.locationManager stopUpdatingLocation];
    
    NSLog(@"失去寶物的訊號");
    [self sendLocalNotificationWithMessage:@"失去寶物的訊號"];
}

-(void)sendLocalNotificationWithMessage:(NSString*)message {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = message;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    NSString *message = @"";
    
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    
    if (![nav.topViewController isKindOfClass:[IMViewController class]])
        return;
    IMViewController *viewController = (IMViewController*)nav.topViewController;
    viewController.beacons = beacons;
    [viewController.tableView reloadData];
    
    if(beacons.count > 0) {
        CLBeacon *nearestBeacon = beacons.firstObject;
        if(nearestBeacon.proximity == self.lastProximity ||
           nearestBeacon.proximity == CLProximityUnknown) {
            return;
        }
        self.lastProximity = nearestBeacon.proximity;
        
        switch(nearestBeacon.proximity) {
            case CLProximityFar:
                message = @"你和寶物離很遠";
                break;
            case CLProximityNear:
                message = @"你附近有寶物";
                break;
            case CLProximityImmediate:
                message = @"你差不多就在寶物旁邊";
                break;
            case CLProximityUnknown:
                return;
        }
    } else {
        //message = @"偵測不到 iBeacon.";
    }
    
    NSLog(@"%@", message);
    [self sendLocalNotificationWithMessage:message];
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

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
