//
//  ManageTemplatesViewController.h
//  iKnow
//
//  Created by drm on 13-4-11.
//  Copyright (c) 2013年 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AddTemplateViewController.h"

@class Template;
@class ManageTemplatesViewController;

@protocol ManageTemplatesViewControllerDelegate
- (void) SelectOnTemplate:(NSString *)name sender:(ManageTemplatesViewController *)sender;
@end

@interface ManageTemplatesViewController : UITableViewController <NSFetchedResultsControllerDelegate, AddTemplateViewControllerDelegate> {
    NSMutableArray *aTemplateItems;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, weak) IBOutlet id <ManageTemplatesViewControllerDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *aTemplateItems;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UIButton *AddSelected;

- (IBAction)AddSelected:(id)sender;
- (void) AddTemplate: (NSString *)name withTitle:(NSString *)title withDesc:(NSString *)desc sender:(AddTemplateViewController *)sender;

@end
