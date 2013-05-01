//
//  AddReminderViewController.m
//  iKnow
//
//  Created by Yuyi Zhang on 4/1/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import "AddReminderViewController.h"
#import "ReminderItem.h"
#import "MasterViewController.h"
#import "ManageTemplatesViewController.h"

@interface AddReminderViewController ()

@property (nonatomic, retain) UIPopoverController* manageTemplatePopover;
@property (strong, nonatomic) NSArray *options;

@end

@implementation AddReminderViewController

@synthesize item;
//@synthesize repeatPicker;
@synthesize btnManageTemplates;
@synthesize manageTemplatePopover;
@synthesize options;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.options = [[NSArray alloc] initWithObjects: @"None", @"Daily", @"Weekdays", @"Weekly", @"Monthly", @"Annually", nil];  //todo
}

- (void)viewDidUnload
{
    //    [self setBtnAddFromTemplate:nil];
//    [self setRepeatPicker:nil];
    [self setBtnManageTemplates:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {  //unwind segue, handled in MasterViewController
//        if ([self.titleIn.text length] || [self.descIn.text length]) {
//            UINavigationController *nav = [segue destinationViewController];
//            MasterViewController *mv = (MasterViewController* )nav.topViewController;
//            [mv addReminderItem:self.titleIn.text withDetails:self.descIn.text onDate:self.dateIn.date];
//        }
    }
    else if ([[segue identifier] isEqualToString:@"PopManage"]) {
//        if (self.chooseTemplatePopover) {
//            [self.chooseTemplatePopover dismissPopoverAnimated:YES];
//        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            UINavigationController *nav = [segue destinationViewController];
            ManageTemplatesViewController *tv = (ManageTemplatesViewController* )nav.topViewController;
            tv.delegate = self;
            [self setManageTemplatePopover: [(UIStoryboardPopoverSegue *)segue popoverController]];
        }
    }
}

- (IBAction)ManageTemplates:(id)sender
{
    
}

#pragma mark - Textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ((textField == self.titleIn) || (textField == self.descIn)) {
        [textField resignFirstResponder];
    }
    return YES;
}

//#pragma mark - popover and its delegate
//- (IBAction)AddFromTemplate:(id)sender {
//    if (self.manageTemplatePopover) {
//        [self.manageTemplatePopover dismissPopoverAnimated:YES];
//        [self setManageTemplatePopover:nil];
//    }
//
//    if (!self.chooseTemplatePopover) {
//        ChooseTemplateViewController *template = [[ChooseTemplateViewController alloc] init];
//        UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:template];
//        aPopover.popoverContentSize = CGSizeMake(500, 600);
//		aPopover.delegate = self;
//
//		// Store the popover in a custom property for later use.
//		self.chooseTemplatePopover = aPopover;
//		[self.chooseTemplatePopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//    }

    /* note - popover size could be adjusted by:
     *  1. contentSizeForViewInPopover
     *  2. change popoverContentSize
     */
//}

//- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
//{
//    if ([popoverController.contentViewController isKindOfClass:[ChooseTemplateViewController class]]) {
//        [self setChooseTemplatePopover:nil];
//    }
//    else {
//        [self setManageTemplatePopover:nil];
//    }
//}

#pragma mark - ManageTemplatesViewController delegate
- (void) SelectOnTemplate:(NSString *)name sender:(ManageTemplatesViewController *)sender
{
    self.selectedTemplate.text = name;
    [self.manageTemplatePopover dismissPopoverAnimated:YES];
}

//#pragma mark - PickerView DataSource
//- (NSInteger)numberOfComponentsInPickerView:
//(UIPickerView *)pickerView
//{
//    return 1;
//}
//- (NSInteger)pickerView:(UIPickerView *)pickerView
//numberOfRowsInComponent:(NSInteger)component
//{
//    return [options count];
//}
//- (NSString *)pickerView:(UIPickerView *)pickerView
//             titleForRow:(NSInteger)row
//            forComponent:(NSInteger)component
//{
//    return [options objectAtIndex:row];
//}
//
//#pragma mark - PickerView Delegate
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
//      inComponent:(NSInteger)component
//{
//    //        float rate = [[exchangeRates objectAtIndex:row] floatValue];
//    //        float dollars = [dollarText.text floatValue];
//    //        float result = dollars * rate;
//    //
//    //        NSString *resultString = [[NSString alloc] initWithFormat:
//    //		@"%.2f USD = %.2f %@", dollars, result,
//    //               [countryNames objectAtIndex:row]];
//    //        resultLabel.text = resultString;
//    NSLog(@"___");
//}

@end
