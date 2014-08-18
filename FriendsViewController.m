//
//  FriendsViewController.m
//  Ribbit
//
//  Created by Nick Ross on 6/16/14.
//  Copyright (c) 2014 Nick Ross. All rights reserved.
//

#import "FriendsViewController.h"
#import "EditFriendsViewController.h"
#import "GravatarUrlBuilder.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    
    [super viewWillAppear:animated];
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error %@ %@",error, [error userInfo]);
        }
        else {
            self.friends = objects;
            [self.tableView reloadData];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showEditFriends"]) {
        EditFriendsViewController *viewController = (EditFriendsViewController *)segue.destinationViewController;
        viewController.friends = [NSMutableArray arrayWithArray:self.friends];
    }
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
    return [self.friends count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        // 1. Get the email address
        NSString *email = [user objectForKey:@"email"];
        
        // 2. Create the md5 hash
        NSURL *gravatarUrl = [GravatarUrlBuilder getGravatarUrl:email];
        
        // 3. Request the image from Gravatar
        NSData *imageData = [NSData dataWithContentsOfURL:gravatarUrl];
        if  (imageData !=nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = [UIImage imageWithData:imageData];
            [cell setNeedsLayout];
        });
        }
        // 4. Set image in cell
    });
    cell.imageView.image = [UIImage imageNamed:@"icon_person"];
    
    return cell;
}



@end










