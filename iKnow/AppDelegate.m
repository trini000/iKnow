//
//  AppDelegate.m
//  iKnow
//
//  Created by Yuyi Zhang on 3/22/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"

@implementation AppDelegate

//- (void)dealloc
//{
//    [_window release];
//    [_managedObjectContext release];
//    [_managedObjectModel release];
//    [_persistentStoreCoordinator release];
//    [super dealloc];
//}
@synthesize navigationController;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	MasterViewController *rootViewController = [[MasterViewController alloc]
                                                initWithStyle:UITableViewStylePlain];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    if (!context) {
        // Handle the error.
    }
    // Pass the managed object context to the view controller.
    rootViewController.managedObjectContext = context;
    
    UINavigationController *aNavigationController = [[UINavigationController alloc]
                                                     initWithRootViewController:rootViewController];
    self.navigationController = aNavigationController;
    
    [self.window addSubview:[navigationController view]];
    //[self.window makeKeyAndVisible];
    
    //    [rootViewController release];
    //    [aNavigationController release];
    // Override point for customization after application launch.
    /*
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
     UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
     UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
     splitViewController.delegate = (id)navigationController.topViewController;
     }
     */
    //    UILocalNotification *localNotif =
    //        [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    //    if (localNotif) {
    //        NSString *itemName = [localNotif.userInfo objectForKey:ToDoItemKey];
    //        [viewController displayItem:itemName];  // custom method
    //        application.applicationIconBadgeNumber = localNotif.applicationIconBadgeNumber-1;
    //    }
    //    [window addSubview:viewController.view];
    //    [window makeKeyAndVisible];
    return YES;
    
    /*
     NSString *myIDToCancel = @"some_id_to_cancel";
     UILocalNotification *notificationToCancel=nil;
     for(UILocalNotification *aNotif in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
     if([aNotif.userInfo objectForKey:@"ID"] isEqualToString:myIDToCancel]) {
     notificationToCancel=aNotif;
     break;
     }
     }
     [[UIApplication sharedApplication] cancelLocalNotification:notificationToCancel];
     */
    
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
    
    [self saveContext];
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
    [self saveContext];
}
//
//- (void)scheduleNotificationWithItem:(ToDoItem *)item interval:(int)minutesBefore
//{
//    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
//    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
//    [dateComps setDay:item.day];
//    [dateComps setMonth:item.month];
//    [dateComps setYear:item.year];
//    [dateComps setHour:item.hour];
//    [dateComps setMinute:item.minute];
//    NSDate *itemDate = [calendar dateFromComponents:dateComps];
//    [dateComps release];
//
//    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
//    if (localNotif == nil)
//        return;
//    localNotif.fireDate = [itemDate addTimeInterval:-(minutesBefore*60)];
//    localNotif.timeZone = [NSTimeZone defaultTimeZone];
//
//    localNotif.alertBody = [NSString stringWithFormat:NSLocalizedString(@"%@ in %i minutes.", nil),
//         item.eventName, minutesBefore];
//    localNotif.alertAction = NSLocalizedString(@"View Details", nil);
//
//    localNotif.soundName = UILocalNotificationDefaultSoundName;
//    localNotif.applicationIconBadgeNumber = 1;
//
//    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:item.eventName forKey:ToDoItemKey];
//    localNotif.userInfo = infoDict;
//
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
//    [localNotif release];
//
//	/*
//	can be cancelled using cancelLocalNotification: or cancelAllLocalNotifications
//	*/
//}
//
//- (void)didReceiveLocalNotification:
//{
//	/*
//		get the value of the applicationState property and evaluate it.
//		If the value is UIApplicationStateInactive, the user tapped the action button;
//		if the value is UIApplicationStateActive, the application was frontmost when it received the notification.
//	*/
//
//    NSString *itemName = [notif.userInfo objectForKey:ToDoItemKey]
//    [viewController displayItem:itemName];  // custom method
//    application.applicationIconBadgeNumber = notification.applicationIconBadgeNumber-1;
//
//}

/*	Presenting a local notification immediately while running in the background
 - (void)applicationDidEnterBackground:(UIApplication *)application {
 NSLog(@"Application entered background state.");
 // bgTask is instance variable
 NSAssert(self->bgTask == UIInvalidBackgroundTask, nil);
 
 bgTask = [application beginBackgroundTaskWithExpirationHandler: ^{
 dispatch_async(dispatch_get_main_queue(), ^{
 [application endBackgroundTask:self->bgTask];
 self->bgTask = UIInvalidBackgroundTask;
 });
 }];
 
 dispatch_async(dispatch_get_main_queue(), ^{
 while ([application backgroundTimeRemaining] > 1.0) {
 NSString *friend = [self checkForIncomingChat];
 if (friend) {
 UILocalNotification *localNotif = [[UILocalNotification alloc] init];
 if (localNotif) {
 localNotif.alertBody = [NSString stringWithFormat:
 NSLocalizedString(@"%@ has a message for you.", nil), friend];
 localNotif.alertAction = NSLocalizedString(@"Read Message", nil);
 localNotif.soundName = @"alarmsound.caf";
 localNotif.applicationIconBadgeNumber = 1;
 [application presentLocalNotificationNow:localNotif];
 [localNotif release];
 friend = nil;
 break;
 }
 }
 }
 [application endBackgroundTask:self->bgTask];
 self->bgTask = UIInvalidBackgroundTask;
 });
 
 }
 */

#pragma mark - NSManagedObject methods
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ReminderItem" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ReminderItem.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

@end
