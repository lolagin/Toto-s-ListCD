//
//  Toto.h
//  totolist
//
//  Created by Jeffrey C Rosenthal on 3/31/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Toto : NSManagedObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSString *itemKey;
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, strong) NSString *priorityImageName;
@property (nonatomic) double orderingValue;
@property (nonatomic, strong) NSManagedObject *assetType;

@end
