//
//  TotoStore.h
//  totolist
//
//  Created by Jeffrey C Rosenthal on 3/25/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Toto;
@interface TotoStore : NSObject

@property(nonatomic, readonly, copy) NSArray *allItems;
+ (instancetype)sharedStore;
- (void)addItemToList:(Toto *)todoItem;
- (void)removeItem:(Toto *)item;
- (void)moveItemAtIndex: (NSUInteger)fromIndex
                toIndex: (NSUInteger)toIndex;

+(UIImage *)imageForToto:(Toto*)toto;



@end
