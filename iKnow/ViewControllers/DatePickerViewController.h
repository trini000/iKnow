//
//  DatePickerViewController.h
//  iKnow
//
//  Created by Yuyi Zhang on 4/11/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *GoToDate;
- (IBAction)GoToDate:(id)sender;
- (void)setInitDate:(NSDate *)date;

@end
