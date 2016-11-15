//
//  ViewController.m
//  MRScrollingReusableButtons
//
//  Created by Mayank Rikh on 08/11/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import "ViewController.h"
#import "MRScrollingReusableButtons.h"

@interface ViewController () <MRScrollingReusableButtonsDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    NSArray *stringsArray = @[@"Hello",@"Work!",@"OMG",@"Is it fine?",@"Please :D"];
    
    MRScrollingReusableButtons *labels = [[MRScrollingReusableButtons alloc] initOnView:self.view withArray:stringsArray];
    
    labels.delegate = self;
    
    [labels startAnimating];
    
}

-(void)buttonPressed:(UIButton *)sender{
    
    NSLog(@"Handle Button Press");
}

@end
