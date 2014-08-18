//
//  ImageViewController.h
//  Ribbit
//
//  Created by Nick Ross on 6/17/14.
//  Copyright (c) 2014 Nick Ross. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ImageViewController : UIViewController

@property (nonatomic, strong) PFObject *message;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
