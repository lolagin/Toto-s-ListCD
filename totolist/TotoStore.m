//
//  TotoStore.m
//  totolist
//
//  Created by Jeffrey C Rosenthal on 3/25/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "TotoStore.h"
#import "Toto.h"
@interface TotoStore()
@property (nonatomic) NSMutableArray *privateItems;

@end
@implementation TotoStore
+ (instancetype)sharedStore{
    static TotoStore *sharedStore;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}
- (instancetype)init {
    [NSException raise:@"Singleton" format:@"Use +[ItemStore sharedStore]"];
    return nil;
    
}
- (instancetype)initPrivate {
    self = [super init];
    if (self){
        _privateItems = [[NSMutableArray alloc] init];
        [_privateItems addObject:[Toto initSample]];
        [_privateItems addObject:[Toto initSample]];
        
    }
    return self;
}


- (NSArray *)allItems {
    return [self.privateItems copy];
}



- (void)addItemToList:(Toto *)todoItem {

    [self.privateItems addObject:todoItem];
}

- (void)removeItem:(Toto *)todoItem {
    [self.privateItems removeObjectIdenticalTo:todoItem];
}

- (void)moveItemAtIndex: (NSUInteger)fromIndex
                toIndex: (NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    Toto *todoItem = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:todoItem atIndex:toIndex];
}
+(UIImage *)imageForToto:(Toto*)toto{
        NSString *imageName = [[NSString alloc]init];
    if (toto.priority > 9) {
        imageName = @"high_priority";
    }
    else if (toto.priority <= 9 && toto.priority >= 7) {
        imageName = @"mid-high_priority";
    }
    else if (toto.priority <= 6 && toto.priority >= 4) {
        imageName = @"mid_priority";
    }
    else if (toto.priority < 4 && toto.priority >= 1) {
        imageName = @"low_priority";
    }
    else if (toto.priority < 1) {
        imageName = @"alarm_clock";
    }
    
    
    if (toto.completed == true) {
        [imageName stringByAppendingString:@"_filled"];
    }
    
    UIImage *wtfImage = [UIImage imageNamed:imageName];
    return wtfImage;
}





@end
