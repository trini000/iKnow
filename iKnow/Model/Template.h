//
//  Template.h
//  iKnow
//
//  Created by Yuyi Zhang on 4/13/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Template : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * itemtitle;
@property (nonatomic, retain) NSString * itemdesc;

@end
