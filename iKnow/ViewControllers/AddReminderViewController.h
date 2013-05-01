//
//  AddReminderViewController.h
//  iKnow
//
//  Created by Yuyi Zhang on 4/1/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManageTemplatesViewController.h"

@class ReminderItem;

@interface AddReminderViewController : UITableViewController <UITextFieldDelegate, UIPopoverControllerDelegate, ManageTemplatesViewControllerDelegate>

@property (strong, nonatomic) ReminderItem *item;
@property (weak, nonatomic) IBOutlet UITextField *titleIn;
@property (weak, nonatomic) IBOutlet UITextField *descIn;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateIn;
//@property (weak, nonatomic) IBOutlet UIPickerView *repeatPicker;        //todo - could be more specific, maybe using a separate view.
@property (weak, nonatomic) IBOutlet UILabel *selectedTemplate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnManageTemplates;
- (IBAction)ManageTemplates:(id)sender;

@end
