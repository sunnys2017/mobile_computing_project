//
//  diaryViewController.m
//  Final_App
//
//  Created by Yeming on 4/17/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "diaryViewController.h"

@interface diaryViewController ()

@end

@implementation diaryViewController

@synthesize _contents,_filteredContents;

NSFileManager * fileMgr;
//NSString * title;
NSMutableArray * diaryArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    
    diaryArray =[self getMyDiaryArray];
    NSMutableArray * temp1 = [[NSMutableArray alloc]init];
    for(Diary * d in diaryArray){
        [temp1 addObject:(NSString * )d._diaryID];
    }
    _contents =temp1;

    [self.tableView reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title =@"Diary";
    diaryArray =[self getMyDiaryArray];
    
    NSMutableArray * temp1 = [[NSMutableArray alloc]init];
    for(Diary * d in diaryArray){
        
        [temp1 addObject:(NSString * )d._diaryID];
    }
    _contents =temp1;
    
    NSLog(@"content number:%lu",(unsigned long)_contents.count);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (NSMutableArray *)getMyDiaryArray{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/myCurrentUser.txt"];
    UserCurrent * userCur  = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    User * user = [[User alloc] init];
    diaryArray=[user getDiaris:userCur._userName];
    return diaryArray;
}

-(Diary *)getMySpecificDiary:(NSString *)diaryID{
    
    for(Diary * obj in [self getMyDiaryArray]){
        if ([obj._diaryID isEqualToString:diaryID]) {
            return obj;
        }
    }
    return nil;
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
     if(tableView == self.tableView){
        return [_contents count];
     }else {
         return [_filteredContents count];
     }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"myCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
  
    if(tableView ==self.searchDisplayController.searchResultsTableView){
        cell.textLabel.text = [self._filteredContents objectAtIndex:(indexPath.row)];
        cell.detailTextLabel.text =@" ";
        NSString*imgpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        imgpath = [imgpath stringByAppendingPathComponent:[cell.textLabel.text stringByAppendingString:@".jpg"]];
        NSData * itmImage = [NSData dataWithContentsOfFile:imgpath];
        cell.imageView.frame = CGRectMake(0, 0, 5, 5);
        cell.imageView.image = [UIImage imageWithData:itmImage];
        //cell.imageView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:1.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.textLabel.text = [self._contents objectAtIndex:(indexPath.row)];
        cell.detailTextLabel.text =@" ";

        NSString*imgpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        imgpath = [imgpath stringByAppendingPathComponent:[cell.textLabel.text stringByAppendingString:@".jpg"]];
        NSData * itmImage = [NSData dataWithContentsOfFile:imgpath];
        
        cell.imageView.frame = CGRectMake(0, 0, 5, 5);
        cell.imageView.image = [UIImage imageWithData:itmImage];
        //cell.imageView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:1.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

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
        NSString * temp =[self._contents objectAtIndex:indexPath.row];
        
        [self DeleteRecords:(NSString *)temp];
        [self._contents removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
-(NSString *)GetDocumentDirectory{
    
    NSString * homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    return homeDir;
}

- (void)finishInputForTextView:(id)sender {
    [sender resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
    [aSearchBar resignFirstResponder];
}

-(void)DeleteRecords:(NSString *)txt{
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    sqlite3_stmt *stmt;
    sqlite3 *db;
    
    //insert
    NSString *insertSQL = [NSString stringWithFormat: @"DELETE FROM Diary WHERE diaryID=\"%@\"",txt];
    const char *sql = [insertSQL UTF8String];
    
    NSString *dbPath = [self.GetDocumentDirectory stringByAppendingPathComponent:@"finaldatabase.sqlite"];
    
    BOOL success = [fileMgr fileExistsAtPath:dbPath];
    if(!success){
        NSLog(@"Can't locate database file %@", dbPath);
    }
    
    if(sqlite3_open([dbPath UTF8String], &db)==SQLITE_OK){
        sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
        
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            NSLog(@"Deleted");
        } else {
            NSLog(@"Failed to delete");
        }
        
        sqlite3_finalize(stmt);
        
        sqlite3_close(db);
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

-(void) filterContentForSearchText:(NSString*)searchText scope:(NSString *)scope {
    NSPredicate * resultPredicate  = [NSPredicate predicateWithFormat:@"self contains[c] %@", searchText];
    self._filteredContents = (NSMutableArray *) [self._contents filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]] ];
    return YES;
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if([segue.identifier isEqualToString:@"DetailSegue"]){
        
        UIViewController * tovc = segue.destinationViewController;
        tovc.title = [_contents objectAtIndex:self.tableView.indexPathForSelectedRow.row];

    }

}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //print text
    NSLog(@"You typed :%@", [textField text]);
    
    //or use an alert screen to display it
    NSString * msg = [NSString stringWithFormat:@"You typed : %@", [textField text]];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
    
    //the user pressed the "done" button, so dismiss the keyboard.
    [textField resignFirstResponder];
    
    return YES;
}
@end
