//
//  TotoStore.m
//  totolist
//
//  Created by Jeffrey C Rosenthal on 3/25/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "TotoStore.h"
#import "Toto.h"

@import CoreData;

@interface TotoStore()
@property (nonatomic) NSMutableArray *privateItems;
@property (nonatomic, strong) NSMutableArray *allAssetTypes;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;

- (NSArray *)allItems;

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

        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
        
        NSString *path = self.itemArchivePath;
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
            [NSException raise:@"Open Failure" format:[error localizedDescription]];
        }
        _context = [[NSManagedObjectContext alloc]init];
        _context.persistentStoreCoordinator = psc;
        [self loadAllItems];
    }
    return self;
}



-(void)loadAllItems {
    
    if (!self.privateItems) {
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        NSEntityDescription *e = [NSEntityDescription entityForName:@"Toto" inManagedObjectContext:self.context];
        
        request.entity = e;
        
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        request.sortDescriptors = @[sd];
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"fetch failed" format:@"reason: %@", [error localizedDescription]];
        }
        self.privateItems = [[NSMutableArray alloc] initWithArray:result];
    
    }
    
    
    
}



- (Toto *)createTodoItem {
    double order;
    
    if ([self.allItems count] == 0){
        order = 1.0;
    }
    else {
        order = [[self.privateItems lastObject] orderingValue] + 1.0;
    }
    NSLog(@"adding after %lu items, order = %.2f", (unsigned long)[self.privateItems count], order);
    Toto *todoItem = [NSEntityDescription insertNewObjectForEntityForName:@"Toto" inManagedObjectContext:self.context];
    
    todoItem.orderingValue = order;
    
    
    [self.privateItems addObject:todoItem];
    return todoItem;
}

- (NSArray *)allItems {
    return [self.privateItems copy];
}

- (NSArray *)allAssetTypes {
    if (!_allAssetTypes) {
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        NSEntityDescription *e = [NSEntityDescription entityForName:@"BNRAssetType" inManagedObjectContext:self.context];
        request.entity = e;
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        
        if (!result) {
            [NSException raise:@"fetch failed" format:@"reason: %@", [error localizedDescription]];
        }
        _allAssetTypes = [result mutableCopy];

    }
    
    
    if ([_allAssetTypes count] == 0) {
        NSManagedObject *type;

        type = [NSEntityDescription insertNewObjectForEntityForName:@"AssetType" inManagedObjectContext:self.context];
        [type setValue:@"Personal" forKey:@"label"];
        [_allAssetTypes addObject:type];
                
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AssetType" inManagedObjectContext:self.context];
        [type setValue:@"Work" forKey:@"label"];
        [_allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AssetType" inManagedObjectContext:self.context];
        [type setValue:@"Random" forKey:@"label"];
        [_allAssetTypes addObject:type];
        
        
    }
    return _allAssetTypes;
}
- (void)addItemToList:(Toto *)todoItem {

    [self.privateItems addObject:todoItem];
}

- (void)removeItem:(Toto *)todoItem {
    
    
    [self.context deleteObject:todoItem];
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


    double lowerBound = 0.0;
    
    if (toIndex > 0){
        lowerBound = [self.privateItems[(toIndex-1)] orderingValue];
    } else {
        lowerBound = [self.privateItems[1] orderingValue] - 2.0;
    }
    double upperBound = 0.0;
    
    if (toIndex < [self.privateItems count] -1){
        upperBound = [self.privateItems[(toIndex + 1)] orderingValue];
    } else {
        upperBound = [self.privateItems[(toIndex - 1)] orderingValue] + 2.0;
    }
    double newOrderValue = (lowerBound + upperBound) / 2.0;
    
    NSLog(@"moving to order %f", newOrderValue);
    todoItem.orderingValue = newOrderValue;


}



- (NSString *)itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}



-(BOOL)saveChanges{
    NSError *error;
    BOOL successful = [self.context save:&error];
    if (!successful) {
        NSLog(@"error saving dummy: %@", [error localizedDescription]);
    }
    return successful;
}
//
//+(NSString *)imageNameForToto:(NSInteger)priority{
//    NSString *imageName = [[NSString alloc]init];
//    
//    if (priority > 9) {
//        imageName = @"high_priority";
//    }
//    else if (priority <= 9 && priority >= 7) {
//        imageName = @"mid-high_priority";
//    }
//    else if (priority <= 6 && priority >= 4) {
//        imageName = @"mid_priority";
//    }
//    else if (priority < 4 && priority >= 1) {
//        imageName = @"low_priority";
//    }
//    else if (priority < 1) {
//        imageName = @"alarm_clock";
//    }
//    return imageName;
//}



@end