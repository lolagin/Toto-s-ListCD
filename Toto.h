//
//  Toto.h
//  totolist
//
//  Created by Jeffrey C Rosenthal on 3/25/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Toto : NSObject <NSCoding>
@property (strong,nonatomic)NSString *title;
@property (strong,nonatomic)NSString *details;
@property (assign,nonatomic)NSInteger priority;
@property (strong, nonatomic)NSString *priorityImageName;
@property (assign,nonatomic)BOOL completed;
+(instancetype)initSample;
+(instancetype)initSampleTwo;
+(instancetype)initWithTitle:(NSString *)title andDetails:(NSString *)details andPriority:(NSInteger)priority andCompletedBool:(BOOL)completedBool;




@end
