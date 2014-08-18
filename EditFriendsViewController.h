//
//  EditFriendsViewController.h
//  Ribbit
//
//  Created by Nick Ross on 6/16/14.
//  Copyright (c) 2014 Nick Ross. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PARSE/PARSE.h>

@interface EditFriendsViewController : UITableViewController

@property (nonatomic, strong) NSArray *allUsers;
@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, strong) NSMutableArray *friends;

- (BOOL)isFriend:(PFUser *)user;

@end
