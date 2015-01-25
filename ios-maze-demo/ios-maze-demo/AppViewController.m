//
//  AppViewController.m
//  ios-maze-demo
//
//  Created by Jeromy Evans (personal) on 22/01/2015.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "AppViewController.h"

@interface AppViewController ()

@property (strong, nonatomic) CMMotionManager  *motionManager;
@property (strong, nonatomic) NSOperationQueue *queue;

- (void)animateGhost:(UIImageView*)ghost withYOffset:(int)yOffset;


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
    
    self.packmanModel = [[PacmanModel alloc] init];
            
    self.motionManager = [[CMMotionManager alloc]  init];
    self.queue         = [[NSOperationQueue alloc] init];
    
    self.motionManager.accelerometerUpdateInterval = kUpdateInterval;

    [self.motionManager startAccelerometerUpdatesToQueue:self.queue withHandler:
     // invoke calculatePosition() with latest acceleration to recalculate position
     // invoke render on the main thread as we don't want to render within the callback block invoked by the motionManager
     ^(CMAccelerometerData *accelerometerData, NSError *error) {
         
         [self.packmanModel calculatePosition:accelerometerData.acceleration ];
         
         [self performSelectorOnMainThread:@selector(repaintPacman) withObject:nil waitUntilDone:NO];
     }];
}

/**
 Repaint the pacman using its current model
 */
- (void) repaintPacman {

    CGRect frame = self.pacman.frame;
    frame.origin.x = self.packmanModel.currentPoint.x;
    frame.origin.y = self.packmanModel.currentPoint.y;
    
    CABasicAnimation *rotationAnimation;
    rotationAnimation                     = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.fromValue           = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue             = [NSNumber numberWithFloat:self.packmanModel.angle];
    rotationAnimation.duration            = kUpdateInterval;
    rotationAnimation.repeatCount         = 1;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode            = kCAFillModeForwards;
    
    self.pacman.frame = frame;  // todo: seems unnecessary. is frame a new instance? maybe yeah.

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
