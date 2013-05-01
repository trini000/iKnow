//
//  AddTemplateViewController.h
//  iKnow
//
//  Created by drm on 13-4-12.
//  Copyright (c) 2013年 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddTemplateViewController;

@protocol AddTemplateViewControllerDelegate
- (void) AddTemplate: (NSString *)name withTitle:(NSString *)title withDesc:(NSString *)desc sender:(AddTemplateViewController *)sender;
@end

@interface AddTemplateViewController : UITableViewController

@property (nonatomic, weak) IBOutlet id <AddTemplateViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *nameIn;
@property (weak, nonatomic) IBOutlet UITextField *titleIn;
@property (weak, nonatomic) IBOutlet UITextField *descIn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *Cancel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Done;
- (IBAction)Done:(id)sender;
- (IBAction)Cancel:(id)sender;

@end
