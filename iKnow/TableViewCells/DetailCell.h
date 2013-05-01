//
//  DetailCell.h
//  iKnow
//
//  Created by Yuyi Zhang on 3/24/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReminderItem;

@interface DetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (nonatomic) BOOL checked;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void) toggleSelection;

@end
