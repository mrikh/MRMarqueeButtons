//
//  ViewController.m
//  marqueeLabel
//
//  Created by Mayank Rikh on 08/11/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import "ViewController.h"
#import "MRMarqueeButtons.h"

@interface ViewController () <MRMarqueeButtonsDelegate>

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
    
    MRMarqueeButtons *labels = [[MRMarqueeButtons alloc] initOnView:self.view withArray:stringsArray];
    
    labels.delegate = self;
    
    [labels startAnimating];
    
}

-(void)buttonPressed:(UIButton *)sender{
    
    NSLog(@"Handle Button Press");
}

@end
