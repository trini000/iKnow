//
//  TemplateDetailCell.m
//  iKnow
//
//  Created by drm on 13-4-12.
//  Copyright (c) 2013年 Camel. All rights reserved.
//

#import "TemplateDetailCell.h"

@implementation TemplateDetailCell
@synthesize label;
@synthesize textIn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
