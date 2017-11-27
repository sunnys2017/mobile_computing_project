//
//  newsViewController.m
//  Final_App
//
//  Created by Yeming on 4/17/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "newsViewController.h"

@interface newsViewController ()

@end

@implementation newsViewController
@synthesize _newsArray,_postsArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (!self) { return nil; }
    
    self.colors = @[
                    @"Turquoise",
                    @"Green Sea",
                    @"Emerald",
                    @"Nephritis",
                    @"Peter River",
                    @"Belize Hole",
                    @"Amethyst",
                    @"Wisteria",
                    @"Wet Asphalt",
                    @"Midnight Blue",
                    @"Sun Flower",
                    @"Orange",
                    @"Carrot",
                    @"Pumpkin",
                    @"Alizarin",
                    @"Pomegranate",
                    @"Clouds",
                    @"Silver",
                    @"Concrete",
                    @"Asbestos",
                    ];
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Events";
    AppDelegate * app = [[AppDelegate alloc]init];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/myCurrentUser.txt"];
    UserCurrent * userCur  = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSString * groupnumber = userCur._groupNumber;
    
    NSString * urlt = @"post";
    NSMutableArray * tempArray =[app getInfoFromWebServer:(NSString *) groupnumber urlString:(NSString *)urlt method:(NSString *)nil];
    _postsArray = tempArray;
    _newsArray= [[NSMutableArray alloc]init];
    if(tempArray!=nil){
        for(Post * obj in tempArray){
            [_newsArray addObject:[obj _postID]];
        }
    }
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    
    AppDelegate * app = [[AppDelegate alloc]init];

    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/myCurrentUser.txt"];
    UserCurrent * userCur  = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSString * groupnumber = userCur._groupNumber;
    NSString * urlt = @"post";
    NSMutableArray * tempArray =[app getInfoFromWebServer:(NSString *) groupnumber urlString:(NSString *)urlt method:(NSString *)nil];
    _postsArray = tempArray;
    _newsArray= [[NSMutableArray alloc]init];
    if(tempArray!=nil){
        for(Post * obj in tempArray){
            [_newsArray addObject:(NSString *)[obj _postID]];
        }
    }
    
    [self.tableView reloadData];
}

-(NSMutableArray *)getPostsArray{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/myCurrentUser.txt"];
    UserCurrent * userCur  = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSString * groupnumber = userCur._groupNumber;
    NSString * urlt = @"post";
    AppDelegate * app = [[AppDelegate alloc]init];
    NSMutableArray * tempArray =[app getInfoFromWebServer:(NSString *) groupnumber urlString:(NSString *)urlt method:(NSString *)nil];
    return tempArray;
}


-(NSString *) getName:(NSString *)postID{
    NSString * s =@"";
    for(Post* obj in _postsArray){
        if([[obj _postID] isEqualToString:postID]){
            s = obj._name;
            return s;
        }
    }
    return nil;
}

-(Post *) getSpecificPost:(NSString *)postID{

    for(Post* obj in [self getPostsArray]){
        if([[obj _postID] isEqualToString:postID]){
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
    return _newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...

    cell.textLabel.text = [self._newsArray objectAtIndex:(indexPath.row)];;
    cell.detailTextLabel.text =[self getName:(NSString *)[self._newsArray objectAtIndex:(indexPath.row)]];
    
    NSString*imgpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    imgpath = [imgpath stringByAppendingPathComponent:[cell.textLabel.text stringByAppendingString:@".jpg"]];
    NSData * itmImage = [NSData dataWithContentsOfFile:imgpath];
    cell.imageView.image = [UIImage imageWithData:itmImage];
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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"cellPushSegue"]){
        UIViewController * tovc = segue.destinationViewController;
        tovc.title = [_newsArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        
    }
    
}


@end
