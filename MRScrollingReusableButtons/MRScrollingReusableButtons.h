//
//  MRScrollingReusableButtons.h
//  MRScrollingReusableButtons
//
//  Created by Mayank Rikh on 08/11/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MRScrollingReusableButtonsDelegate <NSObject>

-(void)buttonPressed:(UIButton *)sender;

@end

@interface MRScrollingReusableButtons : NSObject

@property (strong, nonatomic) UIColor *labelBackgroundColor;

@property (strong, nonatomic) UIColor *labelBorderColor;

@property (strong, nonatomic) UIColor *labelTextColor;

@property (strong, nonatomic) UIFont *labelFont;

@property (assign, nonatomic) BOOL shouldLoop;

@property (weak, nonatomic) id<MRScrollingReusableButtonsDelegate> delegate;

-(instancetype)initOnView:(UIView *)view withArray:(NSArray *)array;

-(void)startAnimating;

@end
