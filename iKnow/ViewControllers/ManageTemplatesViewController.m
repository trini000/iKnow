//
//  ManageTemplatesViewController.m
//  iKnow
//
//  Created by drm on 13-4-11.
//  Copyright (c) 2013年 Camel. All rights reserved.
//

#import "ManageTemplatesViewController.h"
#import "AppDelegate.h"
#import "Template.h"

@interface ManageTemplatesViewController ()

@end

@implementation ManageTemplatesViewController

@synthesize aTemplateItems;
@synthesize managedObjectContext;
@synthesize AddSelected;
@synthesize delegate;

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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.managedObjectContext == nil)
    {
        self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
    if (!aTemplateItems) {
        aTemplateItems = [[NSMutableArray alloc] init];
    }
    
    [self fetchTemplatesArray];
}

- (void)viewDidUnload
{
    [self setAddSelected:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return aTemplateItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TemplateCell";

    // Dequeue or create a new cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    if (aTemplateItems.count > 0) {
        cell.textLabel.text = [aTemplateItems objectAtIndex:indexPath.row];
    }
    
    return cell;
}

 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }

 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"AddTemplate"]) {
        UINavigationController *nav = [segue destinationViewController];
        AddTemplateViewController *tv = (AddTemplateViewController* )nav.topViewController;
        tv.delegate = self;
    }
}

- (IBAction)AddSelected:(id)sender {
    [self.delegate SelectOnTemplate:[self.aTemplateItems objectAtIndex:self.tableView.indexPathForSelectedRow.row] sender:self];   //todo
}

- (void) AddTemplate: (NSString *)name withTitle:(NSString *)title withDesc:(NSString *)desc sender:(AddTemplateViewController *)sender
{
    NSLog(@"Adding new template: name=%@, title=%@, description=%@", name, title, desc);
    
    if (self.managedObjectContext == nil)
    {
        self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
	// Create and configure a new instance of the Event entity.
	Template *item = (Template *)[NSEntityDescription insertNewObjectForEntityForName:@"Template" inManagedObjectContext:self.managedObjectContext];
    
	[item setName: name];
	[item setItemtitle: title];
	[item setItemdesc: desc];
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
    
    //
    
    if (![self.aTemplateItems containsObject:item.name]) {
        [self.aTemplateItems insertObject:item.name atIndex:0];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.tableView reloadData];
    }
}

#pragma mark - Core Data
- (void) fetchTemplatesArray
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Template" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];

    // sorting
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDesc, nil];
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
    
    for (Template *template in mutableFetchResults) {
        if (![self.aTemplateItems containsObject:template.name]) {
            [self.aTemplateItems addObject:template.name];
        }
    }
}

@end
