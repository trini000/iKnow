//
//  DatePickerViewController.m
//  iKnow
//
//  Created by Yuyi Zhang on 4/11/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setGoToDate:nil];
    [self setDatePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GoToDate:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SyncDate" object:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)setInitDate:(NSDate *)date
{
    if (date) {
        self.datePicker.date = date;
    }
}

@end
