//
//  Toto.m
//  totolist
//
//  Created by Jeffrey C Rosenthal on 3/25/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "Toto.h"

@implementation Toto

+(instancetype)initSample {

    
    Toto *toto = [Toto initWithTitle:@"wash the dog" andDetails:@"the dog is quite dirty and its getting ridiculous" andPriority:1 andCompletedBool:false];
    return toto;
}

+(instancetype)initWithTitle:(NSString *)title andDetails:(NSString *)details andPriority:(NSInteger)priority andCompletedBool:(BOOL)completedBool{
    Toto *toto = [[Toto alloc]init];
    
    toto.title =title;
    toto.details = details;
    toto.priority = priority;
    toto.completed = completedBool;
    return toto;
}
@end
