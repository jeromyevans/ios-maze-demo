//
//  AppViewController.m
//  ios-maze-demo
//
//  Created by Jeromy Evans (personal) on 22/01/2015.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "AppViewController.h"

@interface AppViewController ()

- (void)animateGhost:(UIImageView*)ghost withYOffset:(int)yOffset;

#define SCALE 500

@end

@implementation AppViewController


/*
 Set up a CABasicAnimation fo rthe specificed ghost. It will set up a 
 simple repeating translation from the origin to the offset 
 */
- (void)animateGhost:(UIImageView*)ghost withYOffset:(int)yOffset {
 
    CGPoint origin = ghost.center;
    CGPoint target = CGPointMake(ghost.center.x, ghost.center.y + yOffset);
    
    CABasicAnimation *bounceAnim = [CABasicAnimation animationWithKeyPath:@"position.y"];
    bounceAnim.fromValue = [NSNumber numberWithInt:origin.y];
    bounceAnim.toValue = [NSNumber numberWithInt:target.y];
    bounceAnim.duration = 2;
    bounceAnim.autoreverses = YES;
    bounceAnim.repeatCount = HUGE_VALF;
    
    [ghost.layer addAnimation:bounceAnim forKey:@"position"];
}

/**
 Set up the motion manager to read accelerometer inputs every kUpdateInterval. Values
 are added to the queue
 */
- (void)setupPacmanMotion {
    self.lastUpdateTime = [[NSDate alloc] init];
    
    self.currentPoint = CGPointMake(0, 144);
    self.motionManager = [[CMMotionManager alloc]  init];
    self.queue         = [[NSOperationQueue alloc] init];
    
    self.motionManager.accelerometerUpdateInterval = kUpdateInterval;

    [self.motionManager startAccelerometerUpdatesToQueue:self.queue withHandler:
// this block sets the pacman's acceleration value and invokes updatePacmanPosition() on the main
// thread. We don't want to render within the callback block invoked by the motionManager
     ^(CMAccelerometerData *accelerometerData, NSError *error) {
         [(id) self setAcceleration:accelerometerData.acceleration];
         [self performSelectorOnMainThread:@selector(updatePacmanPosition) withObject:nil waitUntilDone:NO];
     }];
}

/**
 Use current position and vector, new acceleration and time to calculate a new position 
 for the pacman. Then render in new position
 */
- (void) updatePacmanPosition {
 
    NSTimeInterval secondsSinceLastDraw = -([self.lastUpdateTime timeIntervalSinceNow]);
    
    self.pacmanYVelocity = self.pacmanYVelocity - (self.acceleration.y * secondsSinceLastDraw);
    self.pacmanXVelocity = self.pacmanXVelocity - (self.acceleration.x * secondsSinceLastDraw);

    CGFloat xDelta = secondsSinceLastDraw * self.pacmanXVelocity * SCALE;
    CGFloat yDelta = secondsSinceLastDraw * self.pacmanYVelocity * SCALE;

    self.currentPoint = CGPointMake(self.currentPoint.x + xDelta,
                                    self.currentPoint.y + yDelta);
    
    // extra angle in degrees
    CGFloat newAngle = (self.pacmanXVelocity + self.pacmanYVelocity) * M_PI * 4;
    
    self.angle += newAngle * kUpdateInterval;  //
    
    [self repaintPacman];

    self.lastUpdateTime = [NSDate date];
}

- (void) repaintPacman {

    self.previousPoint = self.currentPoint;

    CGRect frame = self.pacman.frame;
    frame.origin.x = self.currentPoint.x;
    frame.origin.y = self.currentPoint.y;
    
    self.pacman.frame = frame;  // todo: seems unnecessary. is frame a new instance? maybe yeah.
    
    CABasicAnimation *rotationAnimation;
    rotationAnimation                     = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.fromValue           = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue             = [NSNumber numberWithFloat:self.angle];
    rotationAnimation.duration            = kUpdateInterval;
    rotationAnimation.repeatCount         = 1;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode            = kCAFillModeForwards;
    
    [self.pacman.layer addAnimation:rotationAnimation forKey:@"10"];
}

/**
 After the view is loaded from the nib, start the ghost animations
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self animateGhost:self.ghost1 withYOffset:-124];
    [self animateGhost:self.ghost2 withYOffset:+284];
    [self animateGhost:self.ghost3 withYOffset:-284];
    
    [self setupPacmanMotion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
