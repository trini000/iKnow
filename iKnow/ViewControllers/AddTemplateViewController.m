//
//  AddTemplateViewController.m
//  iKnow
//
//  Created by drm on 13-4-12.
//  Copyright (c) 2013年 Camel. All rights reserved.
//

#import "AddTemplateViewController.h"
#import "TemplateDetailCell.h"

@interface AddTemplateViewController ()

@end

@implementation AddTemplateViewController

@synthesize Cancel;
@synthesize Done;
@synthesize nameIn;
@synthesize titleIn;
@synthesize descIn;
@synthesize delegate;

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
}

- (void)viewDidUnload
{
    [self setCancel:nil];
    [self setDone:nil];
    [self setNameIn:nil];
    [self setTitleIn:nil];
    [self setDescIn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

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

- (IBAction)Done:(id)sender {
    if ([self.nameIn.text length] && ([self.titleIn.text length] || [self.descIn.text length])) {   //todo -validation alert
        [self.delegate AddTemplate:self.nameIn.text withTitle:self.titleIn.text
                          withDesc:self.descIn.text sender:self];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)Cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ((textField == self.nameIn) || (textField == self.titleIn) || (textField == self.descIn)) {
        [textField resignFirstResponder];
    }
    return YES;
}


@end
