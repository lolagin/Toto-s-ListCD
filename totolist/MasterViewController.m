//
//  MasterViewController.m
//  totolist
//
//  Created by Jeffrey C Rosenthal on 3/25/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Toto.h"
#import "TotoStore.h"
#import "LHWModalInputViewController.h"
#import "CustomTableViewCell.h"

@interface MasterViewController ()

@property NSMutableArray *objects;


-(void)modalAddView;


@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(modalAddView)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UINib *nib = [UINib nibWithNibName:@"CustomTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CustomTableViewCell"];
    
    UIImageView *viewWithAmericaPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundamerica"]];
    self.tableView.backgroundView = viewWithAmericaPic;

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"list to do";
        
        UIBarButtonItem *barbie = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(modalAddView)];
        
        navItem.rightBarButtonItem = barbie;
        
        navItem.leftBarButtonItem = self.editButtonItem;
        
    }
    
    return self;
}


-(void)modalAddView{
    LHWModalInputViewController *modalView = [[LHWModalInputViewController alloc]init];
    
    modalView.todoItem = [[TotoStore sharedStore] createTodoItem];
    [self.navigationController pushViewController:modalView animated:true];
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Toto *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[TotoStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomTableViewCell" forIndexPath:indexPath];

    cell.backgroundColor = [UIColor blueColor];
    
    
    NSArray *items = [[TotoStore sharedStore] allItems];
    Toto *totoItem = items[indexPath.row];
    
    cell.titleLabel.text = totoItem.title;
    cell.descriptionLabel.text = totoItem.details;
    cell.priorityLabel.text = [NSString stringWithFormat:@"%ld",(long)totoItem.priority];
    cell.thumbnailView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",totoItem.priorityImageName]];
    cell.backgroundView.alpha = 0.4;

    return cell;

}




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        
                NSArray *totoItems = [[TotoStore sharedStore] allItems];
                Toto *toto = totoItems[indexPath.row];
                [[TotoStore sharedStore] removeItem:toto];
                
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      
        }
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[TotoStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"remove";
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    
    NSArray *items = [[TotoStore sharedStore] allItems];
    Toto *selectedTodoItem = items[indexPath.row];
    detailViewController.toto = selectedTodoItem;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
