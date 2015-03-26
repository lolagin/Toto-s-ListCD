//
//  DetailViewController.h
//  totolist
//
//  Created by Jeffrey C Rosenthal on 3/25/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Toto;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic)Toto *toto;

@end

