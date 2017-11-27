//
//  noticeTableViewController.m
//  Final_App
//
//  Created by Yeming on 4/22/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "noticeTableViewController.h"
#import "NotificationSet.h"
#import "NotificationStore.h"
@interface noticeTableViewController ()

@end

@implementation noticeTableViewController

@synthesize  _noticesArray;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.title = @"Notices";
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/notice.txt"];
    NotificationSet * noticeSet=[NSKeyedUnarchiver unarchiveObjectWithFile:(NSString *)path];
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    for( NotificationStore * obj in [noticeSet _noticeArray]){
        [temp addObject:[obj _mark]];
    }
    _noticesArray=temp;
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/notice.txt"];
    NotificationSet * noticeSet=[NSKeyedUnarchiver unarchiveObjectWithFile:(NSString *)path];
    _noticesArray=[noticeSet _noticeArray];
    
    NSLog(@"%lu",(unsigned long)_noticesArray.count);
    self.title = @"Notices";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSMutableArray * buttonArray = [[NSMutableArray alloc] init];
    [buttonArray addObject:self.editButtonItem ];//,_addNoticeButton,nil];
    [buttonArray addObject:_addNoticeButton];
    self.navigationItem.rightBarButtonItems = buttonArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _noticesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"noticeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self._noticesArray objectAtIndex:(indexPath.row)];
    cell.detailTextLabel.text =@" ";
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
