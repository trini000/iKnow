//
//  DetailCell.m
//  iKnow
//
//  Created by Yuyi Zhang on 3/24/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import "DetailCell.h"
#import "ReminderItem.h"

@implementation DetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      //      self.titleLabel.text = item.title;
      //      self.descLabel.text = item.description;
      //  self.checked = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) toggleSelection
{
    self.checked = !self.checked;
    //refresh self
}

@end
