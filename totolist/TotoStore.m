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

        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (!_privateItems){
            _privateItems = [[NSMutableArray alloc]init];
        }
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



- (NSString *)itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}



-(BOOL)saveChanges{
    NSString *path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}




@end