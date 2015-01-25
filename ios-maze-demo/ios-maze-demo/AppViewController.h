//
//  AppViewController.h
//  ios-maze-demo
//
//  Created by Jeromy Evans (personal) on 22/01/2015.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CAAnimation.h>
#import <CoreMotion/CoreMotion.h>

@interface AppViewController : UIViewController

// interval that we read accelerometer data
#define kUpdateInterval (1.0f / 60.0f)

@property (strong, nonatomic) IBOutlet UIImageView *pacman;

@property (strong, nonatomic) IBOutlet UIImageView *ghost1;
@property (strong, nonatomic) IBOutlet UIImageView *ghost2;
@property (strong, nonatomic) IBOutlet UIImageView *ghost3;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *walls;

@property (assign, nonatomic) CGPoint currentPoint;
@property (assign, nonatomic) CGPoint previousPoint;
@property (assign, nonatomic) CGFloat pacmanXVelocity;
@property (assign, nonatomic) CGFloat pacmanYVelocity;
@property (assign, nonatomic) CGFloat angle;

@property (assign, nonatomic) CMAcceleration acceleration;
@property (strong, nonatomic) CMMotionManager  *motionManager;
@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSDate *lastUpdateTime;


@end
