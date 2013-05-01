//
//  MasterViewController.h
//  iKnow
//
//  Created by Yuyi Zhang on 3/22/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class DetailViewController;
@class ReminderItem;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    NSMutableArray *aReminderItems;
    NSManagedObjectContext *managedObjectContext;
    NSDate* dateShowing;
}

@property (nonatomic, retain) NSDate* dateShowing;
@property (nonatomic, retain) NSMutableArray *aReminderItems;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
//@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

- (void)addReminderItem:(NSString*)title withDetails:(NSString*)detail onDate:(NSDate*)date;
//@property (strong, nonatomic) DetailViewController *detailViewController;

- (IBAction)done:(UIStoryboardSegue *)segue;
- (IBAction)cancel:(UIStoryboardSegue *)segue;

@end
