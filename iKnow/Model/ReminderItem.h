//
//  ReminderItem.h
//  iKnow
//
//  Created by drm on 13-4-10.
//  Copyright (c) 2013年 Camel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ReminderItem : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSNumber * checked;
@property (nonatomic, retain) NSDate * date;

@end
