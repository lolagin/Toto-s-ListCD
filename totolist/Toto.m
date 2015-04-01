//
//  Toto.m
//  totolist
//
//  Created by Jeffrey C Rosenthal on 3/31/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "Toto.h"


@implementation Toto

@dynamic title;
@dynamic details;
@dynamic priority;
@dynamic priorityImageName;
@dynamic orderingValue;
@dynamic assetType;
@dynamic itemKey;



-(void)awakeFromInsert {
    [super awakeFromInsert];

    NSUUID *uuid = [[NSUUID alloc]init];
    NSString *key = [uuid UUIDString];
    self.itemKey = key;
}
@end
