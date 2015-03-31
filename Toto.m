//
//  Toto.m
//  totolist
//
//  Created by Jeffrey C Rosenthal on 3/25/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "Toto.h"
@interface Toto ()

+(NSString *)imageNameForToto:(NSInteger)priority;

@end
@implementation Toto

+(instancetype)initSample {

    
    Toto *toto = [Toto initWithTitle:@"wash the dog" andDetails:@"the dog is quite dirty and its getting ridiculous" andPriority:1 andCompletedBool:false];
    return toto;
}
+(instancetype)initSampleTwo {
    
    
    Toto *toto = [Toto initWithTitle:@"MoreThings TODO" andDetails:@"lulz i have no idea, tired" andPriority:7 andCompletedBool:false];
    return toto;
}
+(instancetype)initWithTitle:(NSString *)title andDetails:(NSString *)details andPriority:(NSInteger)priority andCompletedBool:(BOOL)completedBool{
    Toto *toto = [[Toto alloc]init];
    
    toto.title = title;
    toto.details = details;
    toto.priority = priority;
    toto.completed = completedBool;
    toto.priorityImageName = [self imageNameForToto:priority];
    return toto;
}


-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.details forKey:@"details"];
    [aCoder encodeInteger:self.priority forKey:@"priority"];
    [aCoder encodeObject:self.priorityImageName forKey:@"priorityImageName"];
    [aCoder encodeBool: self.completed forKey:@"completed"];
    
}



-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _title = [aDecoder decodeObjectForKey:@"title"];
        _details = [aDecoder decodeObjectForKey:@"details"];
        _priority = [aDecoder decodeIntegerForKey:@"priority"];
        _priorityImageName = [aDecoder decodeObjectForKey:@"priorityImageName"];
        _completed = [aDecoder decodeBoolForKey:@"completed"];
    }
    return self;
}



+(NSString *)imageNameForToto:(NSInteger)priority{
    NSString *imageName = [[NSString alloc]init];
   
    if (priority > 9) {
        imageName = @"high_priority";
    }
    else if (priority <= 9 && priority >= 7) {
        imageName = @"mid-high_priority";
    }
    else if (priority <= 6 && priority >= 4) {
        imageName = @"mid_priority";
    }
    else if (priority < 4 && priority >= 1) {
        imageName = @"low_priority";
    }
    else if (priority < 1) {
        imageName = @"alarm_clock";
    }
    return imageName;
}




@end
