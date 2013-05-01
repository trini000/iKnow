//
//  MasterViewController.m
//  iKnow
//
//  Created by Yuyi Zhang on 3/22/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import "MasterViewController.h"
#import "AddReminderViewController.h"
#import "ReminderItem.h"
#import "AppDelegate.h"
#import "DetailCell.h"
#import "DatePickerViewController.h"

@interface MasterViewController ()

@property (nonatomic, retain) UIPopoverController *datePickerPopover;

@end

@implementation MasterViewController

@synthesize dateShowing;
@synthesize aReminderItems;
@synthesize managedObjectContext;
@synthesize datePickerPopover;

- (void)awakeFromNib
{
    /*
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
     self.clearsSelectionOnViewWillAppear = NO;
     self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
     }
     */
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if (self.managedObjectContext == nil)
    {
        self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
    if (nil == self.dateShowing) {
        [self setDateShowing:[NSDate date]];
    }
    
    [self showItemsOnDate:self.dateShowing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!aReminderItems) {
        aReminderItems = [[NSMutableArray alloc] init];
    }
    [aReminderItems insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)addReminderItem:(NSString*)title withDetails:(NSString*)detail onDate:(NSDate*)date
{
    NSLog(@"Adding new item: title=%@, description=%@, date=%@", title, detail, date);
    
    if (self.managedObjectContext == nil)
    {
        self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
	// Create and configure a new instance of the Event entity.
	ReminderItem *item = (ReminderItem *)[NSEntityDescription insertNewObjectForEntityForName:@"ReminderItem" inManagedObjectContext:self.managedObjectContext];
    
	[item setTitle: title];
	[item setDetails: detail];
	[item setDate: date];
    [item setChecked:[NSNumber numberWithBool:NO]];
	NSError *error = nil;
	if (![self.managedObjectContext save:&error]) {
    	// Handle the error.
		UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Saving item failed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
        
		[alert show];
	}
    
    // Only add item to current view if it's for the showing date
    {
        //add predicates
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:self.dateShowing];
        
        [components setHour:-[components hour]];
        [components setMinute:-[components minute]];
        [components setSecond:-[components second]];
        NSDate *startOfDay = [cal dateByAddingComponents:components toDate:self.dateShowing options:0]; //This variable should now be pointing at a date object that is the start of today (midnight);
        
        [components setHour:+24];
        [components setMinute:0];
        [components setSecond:0];
        NSDate *endOfDay = [cal dateByAddingComponents:components toDate: startOfDay options:0];
        
        if ([date earlierDate:endOfDay] == [startOfDay laterDate:date] /* == date */)
        {
            [aReminderItems insertObject:item atIndex:0];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return aReminderItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DetailCell";
    // Dequeue or create a new cell.
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    ReminderItem *item = (ReminderItem *)[aReminderItems objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [item title];
    cell.descLabel.text = [item details];
	if ([[item checked] boolValue]) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [aReminderItems removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReminderItem *item = [self.aReminderItems objectAtIndex:indexPath.row];
    item.checked = [NSNumber numberWithBool: ![[item checked] boolValue]];
    [self.aReminderItems replaceObjectAtIndex:indexPath.row withObject:item];
    [self.tableView reloadData];

    /*
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
     NSDate *object = _objects[indexPath.row];
     self.detailViewController.detailItem = object;
     }
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowDetails"]) {
        
    }
    else if ([[segue identifier] isEqualToString:@"AddItem"]) {
        //        UINavigationController *nav = [segue destinationViewController];
        //        AddReminderViewController *addv = (AddReminderViewController* )nav.topViewController;
        //        [addv updateManagedObjectContext:self.managedObjectContext];
    }
    else if ([[segue identifier] isEqualToString:@"PopDatePicker"]) {
        datePickerPopover = [(UIStoryboardPopoverSegue *)segue popoverController];
        [(DatePickerViewController *)datePickerPopover.contentViewController setInitDate:self.dateShowing];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                selector:@selector(syncDate)
                                                name:@"SyncDate"
                                                object:nil];
    }
}

- (void)syncDate
{
    NSError *error = nil;
	if (![self.managedObjectContext save:&error]) {
    	// Handle the error.
		UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Saving item failed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
        
		[alert show];
	}
    
    DatePickerViewController *picker = (DatePickerViewController *)self.datePickerPopover.contentViewController;
    [self setDateShowing: picker.datePicker.date];
    [self showItemsOnDate: self.dateShowing];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"SyncDate"
                                                  object:nil];
    [datePickerPopover dismissPopoverAnimated:YES];
    [self.tableView reloadData];
}

- (void) showItemsOnDate:(NSDate *) date
{
    // Set the title with a date formatter for the time stamp.
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    }
    self.title = [dateFormatter stringFromDate: self.dateShowing];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ReminderItem" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    //add predicates
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];
    
    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    NSDate *startOfDay = [cal dateByAddingComponents:components toDate:date options:0]; //This variable should now be pointing at a date object that is the start of today (midnight);
    
    [components setHour:+24];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *endOfDay = [cal dateByAddingComponents:components toDate:startOfDay options:0];
    
    /*
     components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[[NSDate alloc] init]];
     
     [components setDay:([components day] - ([components weekday] - 1))];
     NSDate *thisWeek  = [cal dateFromComponents:components];
     
     [components setDay:([components day] - 7)];
     NSDate *lastWeek  = [cal dateFromComponents:components];
     
     [components setDay:([components day] - ([components day] -1))];
     NSDate *thisMonth = [cal dateFromComponents:components];
     
     [components setMonth:([components month] - 1)];
     NSDate *lastMonth = [cal dateFromComponents:components];
     */
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date >= %@ and date < %@", startOfDay, endOfDay];
    [request setPredicate:predicate];
    
    // sorting
    NSSortDescriptor *sortDesc1 = [[NSSortDescriptor alloc] initWithKey:@"checked" ascending:YES];
    NSSortDescriptor *sortDesc2 = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDesc1, sortDesc2, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Fetching item failed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Sigh..."
                                              otherButtonTitles:nil];
        
		[alert show];
    }
    
    [self setAReminderItems:mutableFetchResults];
}

- (IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        AddReminderViewController *addController = [segue sourceViewController];
            if ([addController.titleIn.text length] || [addController.descIn.text length]) {
                [self addReminderItem:addController.titleIn.text withDetails:addController.descIn.text onDate:addController.dateIn.date];
            }
        [[self tableView] reloadData];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"CancelInput"]) {
        [self.tableView reloadData];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}


- (void) AddRepeatingItems:(ReminderItem *)item repeatingMode:(NSInteger)mode
{
    NSMutableArray *mutableFetchResults;
    NSDate *endDate;
    NSCalendar *cal = [NSCalendar currentCalendar];
    // Get items in a month
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ReminderItem" inManagedObjectContext:self.managedObjectContext];
        [request setEntity:entity];
        
        //add predicates
        NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:item.date];
        
        [components setHour:-[components hour]];
        [components setMinute:-[components minute]];
        [components setSecond:-[components second]];
        NSDate *startDate = [cal dateByAddingComponents:components toDate:item.date options:0]; //This variable should now be pointing at a date object that is the start of today (midnight);
        
        [components setMonth:+1];
        [components setHour:0];
        [components setMinute:0];
        [components setSecond:0];
        endDate = [cal dateByAddingComponents:components toDate:startDate options:0];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date >= %@ and date < %@", startDate, endDate];
        [request setPredicate:predicate];
        
        // sorting
        NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDesc, nil];
        [request setSortDescriptors:sortDescriptors];
        
        NSError *error = nil;
        mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
        if (mutableFetchResults == nil) {
            // Handle the error.
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                            message:@"Fetching item failed."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Sigh..."
                                                  otherButtonTitles:nil];
            
            [alert show];
        }
    }
    
    // Iterate through, add missing items
    {
        NSDate* itrDate = item.date;
        NSUInteger i = 0;
        while (endDate == [itrDate laterDate:endDate]) {
            if (i < mutableFetchResults.count) {
                ReminderItem *temp = (ReminderItem *)[mutableFetchResults objectAtIndex:i];
                if (itrDate == temp.date) {
                    //itrDate++
                    NSDateComponents *comp = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:itrDate];
                    [comp setDay: +1];
                    itrDate = [cal dateByAddingComponents:comp toDate:itrDate options:0];
                    i++;
                    continue;
                }
                else if (itrDate == [itrDate laterDate:temp.date]) {
                    i++;
                    continue;
                }
            }
            
            ReminderItem *newItem = (ReminderItem *)[NSEntityDescription insertNewObjectForEntityForName:@"ReminderItem" inManagedObjectContext:self.managedObjectContext];
            [newItem setTitle: item.title];
            [newItem setDetails: item.details];
            [newItem setDate: itrDate];
            [newItem setChecked:[NSNumber numberWithBool:NO]];
            
            // itrDate++
            NSDateComponents *comp = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:itrDate];
            [comp setDay: +1];
            itrDate = [cal dateByAddingComponents:comp toDate:itrDate options:0];
        }
    }
    
    // Save Data
    {
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            // Handle the error.
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                            message:@"Saving item failed."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:nil];
            
            [alert show];
        }
	}
}

@end
