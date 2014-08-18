//
//  FriendsViewController.h
//  Ribbit
//
//  Created by Nick Ross on 6/16/14.
//  Copyright (c) 2014 Nick Ross. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FriendsViewController : UITableViewController

@property (nonatomic, strong) PFRelation *friendsRelation;
@property (nonatomic, strong) NSArray *friends;

@end
