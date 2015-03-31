//
//  DetailViewController.m
//  totolist
//
//  Created by Jeffrey C Rosenthal on 3/25/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "DetailViewController.h"
#import "Toto.h"
#import "TotoStore.h"

@interface DetailViewController ()
@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic)UILabel *descriptionLabel;
@property (strong, nonatomic)UIImageView *iconView;
@end

@implementation DetailViewController




#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.toto) {
        self.titleLabel.text = self.toto.title;
        self.descriptionLabel.text = self.toto.details;
        self.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.toto.priorityImageName]];
        self.iconView.backgroundColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.descriptionLabel.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:self.titleLabel];
        [self.view addSubview:self.descriptionLabel];
        [self.view addSubview:self.iconView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundamerica"]];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 73, (self.view.bounds.size.width - 16), (self.view.bounds.size.height / 4))];
    self.descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, (self.view.bounds.size.height / 2), (self.view.bounds.size.width - 16), (self.view.bounds.size.height / 4))];
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width / 2), (self.view.bounds.size.height / 2), 100, 100)];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
