//
//  AppViewController.h
//  ios-maze-demo
//
//  Created by Jeromy Evans (personal) on 22/01/2015.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIImageView *pacman;

@property (strong, nonatomic) IBOutlet UIImageView *ghost1;
@property (strong, nonatomic) IBOutlet UIImageView *ghost2;
@property (strong, nonatomic) IBOutlet UIImageView *ghost3;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *walls;

@end
