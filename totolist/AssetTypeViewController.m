//
//  AssetTypeViewController.m
//  totolist
//
//  Created by Jeffrey C Rosenthal on 4/1/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "AssetTypeViewController.h"
#import "Toto.h"
#import "TotoStore.h"


@implementation AssetTypeViewController
- (instancetype)init
{
    return [super initWithStyle:UITableViewStylePlain];
}

-(instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[TotoStore sharedStore]allAssetTypes] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray *allAsses = [[TotoStore sharedStore] allAssetTypes];
    NSManagedObject *assType = allAsses[indexPath.row];
    
    NSString *assLabel = [assType valueForKey:@"label"];
    cell.textLabel.text = assLabel;
    
    
    if (assType == self.toto.assetType){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    NSArray *allAsses = [[TotoStore sharedStore] allAssetTypes];
    NSManagedObject *assType = allAsses[indexPath.row];
    self.toto.assetType = assType;
    [self.navigationController popViewControllerAnimated:YES];
}






@end
