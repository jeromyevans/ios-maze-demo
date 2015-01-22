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

@end

@implementation AppViewController


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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self animateGhost:self.ghost1 withYOffset:-124];
    [self animateGhost:self.ghost2 withYOffset:+284];
    [self animateGhost:self.ghost3 withYOffset:-284];
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
