//
//  MRScrollingReusableButtons.m
//  MRScrollingReusableButtons
//
//  Created by Mayank Rikh on 08/11/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import "MRScrollingReusableButtons.h"

@interface MRScrollingReusableButtons(){
    
    NSUInteger counter;
    
    UIView *superview;
    
    NSArray *arrayOfStrings;
}

@end

@implementation MRScrollingReusableButtons

-(instancetype)initOnView:(UIView *)view withArray:(NSArray *)array{
    
    //    CGSize stringSize = [text boundingRectWithSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width, FLT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:self.labelFont} context:nil].size;
    
    self = [super init];
    
    if(self){
        
        self.labelTextColor = [UIColor blackColor];
        
        self.labelBackgroundColor = [UIColor whiteColor];
        
        self.labelBorderColor = [UIColor blackColor];

        self.labelFont = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
        
        self.shouldLoop = NO;
        
        superview = view;
        
        arrayOfStrings = array;
    }
    
    return self;
}

-(void)startAnimating{
    
    UIView *mainView = [self createMainViewOnView];
    
    [superview layoutIfNeeded];
    
    [self show:YES mainView:mainView];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        [superview layoutIfNeeded];
    }];
    
    if(arrayOfStrings.count == 0){
        
        NSLog(@"Developer sir, please add atleast one string");
    
    }else if(arrayOfStrings.count == 1){
        
        UIButton *firstButton = [self createButtonWithTitle:[arrayOfStrings firstObject]];
        
        [mainView addSubview:firstButton];
        
        [self createConstraintsForLabel:firstButton andMultiplier:1];
        
        [mainView layoutIfNeeded];
        
        [self startAnimatingViewToShow:firstButton andSecondView:nil andOnCompletion:^{
            
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
            
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                
                [self startAnimatingViewAway:firstButton andViewThatWillAppear:nil andOnCompletion:^{
                    
                    [self show:NO mainView:mainView];
                    
                    [UIView animateWithDuration:0.5f animations:^{
                        
                        [superview layoutIfNeeded];
                    
                    }completion:^(BOOL finished) {
                        
                        [mainView removeFromSuperview];
                    }];
                }];
            });
        }];
    
    }else{
        
        counter = 2;
        
        UIButton *firstButton, *secondButton;
        
        firstButton = [self createButtonWithTitle:arrayOfStrings[0]];
        
        secondButton = [self createButtonWithTitle:arrayOfStrings[1]];
        
        [mainView addSubview:firstButton];
        
        [mainView addSubview:secondButton];
        
        [self createConstraintsForLabel:firstButton andMultiplier:1];
        
        [self createConstraintsForLabel:secondButton andMultiplier:2];
        
        [mainView layoutIfNeeded];
        
        [self startAnimatingViewToShow:firstButton andSecondView:secondButton andOnCompletion:^{
            
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
            
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                
                [self startAnimatingViewAway:firstButton andViewThatWillAppear:secondButton andOnCompletion:^{
                    
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
                    
                    dispatch_after(popTime, dispatch_get_main_queue(), ^{
                        
                        BOOL shouldStop = NO;
                        
                        if(counter > arrayOfStrings.count - 1){
                            
                            shouldStop = YES;
                        }
                        
                        [self startAnimationChainFor:firstButton andSecond:secondButton andStop:shouldStop andStringArray:arrayOfStrings];
                    });
                }];
            });
        }];
    }
}

#pragma mark - Private functions

-(UIView *)createMainViewOnView{
    
    UIView *mainView = [[UIView alloc] init];
    
    [superview addSubview:mainView];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(mainView);
    
    NSMutableArray *customConstraints = [NSMutableArray new];
    
    [customConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-1)-[mainView]-(-1)-|" options:0 metrics:nil views:viewsDictionary]];
    
    [customConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[mainView(0)]-(-1)-|" options:0 metrics:nil views:viewsDictionary]];
    
    [superview addConstraints:customConstraints];
    
    [mainView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [mainView setBackgroundColor:self.labelBackgroundColor];
    
    [mainView.layer setBorderColor:self.labelBorderColor.CGColor];
    
#warning change to variable
    [mainView.layer setBorderWidth:1.0f];
    
    return mainView;
}

#pragma mark - Label Create
    
-(UIButton *)createButtonWithTitle:(NSString *)text{
    
    UIButton *button = [[UIButton alloc] init];
    
    [button setTitle:text forState:UIControlStateNormal];
    
    [button setTitleColor:self.labelTextColor forState:UIControlStateNormal];
    
    [button.titleLabel setLineBreakMode:NSLineBreakByTruncatingMiddle];
    
    [button setTintColor:self.labelTextColor];
    
    [button.titleLabel setFont:self.labelFont];
    
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

#pragma mark Add Constraints

-(void)createConstraintsForLabel:(UIButton *)button andMultiplier:(int)multiplier{
    
    NSMutableArray *customConstraints = [NSMutableArray new];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(button);
    
    [customConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[button(%f)]", [UIScreen mainScreen].bounds.size.width] options:0 metrics:nil views:viewsDictionary]];
    
    [customConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-(%f)-[button]", multiplier * [UIScreen mainScreen].bounds.size.width] options:0 metrics:nil views:viewsDictionary]];
    
    [customConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(40)]|" options:0 metrics:nil views:viewsDictionary]];
    
    [button.superview addConstraints:customConstraints];
    
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
}


-(void)show:(BOOL)show mainView:(UIView *)view{
    
    [view.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if(obj.firstAttribute == NSLayoutAttributeHeight && obj.firstItem == view){
            
            if(show){
            
                [obj setConstant:41.0f];
                
            }else{
                
                [obj setConstant:0.0f];
            }
            
            *stop = YES;
        }
        
    }];
}



-(void)startAnimatingViewToShow:(UIView *)firstView andSecondView:(UIView *)secondView andOnCompletion:(void(^)(void))completion{
    
    [self adjustConstraintValueOfView:firstView];
    
    if(secondView){
    
        [self adjustConstraintValueOfView:secondView];
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        
        [firstView.superview layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        completion();
    }];
}

-(void)startAnimatingViewAway:(UIView *)viewToHide andViewThatWillAppear:(UIView *)viewThatWillAppear andOnCompletion:(void(^)(void))completion{
    
    [self adjustConstraintValueOfView:viewToHide];
    
    if(viewThatWillAppear){
        
        [self adjustConstraintValueOfView:viewThatWillAppear];
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        
        [viewToHide.superview layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        completion();
        
    }];
}

#pragma mark Animation add and remove constraints

-(void)adjustConstraintValueOfView:(UIView *)view{
    
    [view.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if(obj.firstItem == view && obj.firstAttribute == NSLayoutAttributeLeading){
            
            obj.constant -= [UIScreen mainScreen].bounds.size.width;
            
            *stop = YES;
        }
    }];
}

-(void)resetLabelLeading:(UIView *)view{
    
    [view.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if(obj.firstItem == view && obj.firstAttribute == NSLayoutAttributeLeading){
            
            obj.constant = [UIScreen mainScreen].bounds.size.width;
            
            *stop = YES;
        }
    }];
}


#pragma mark Animate Multiple labels

-(void)startAnimationChainFor:(UIButton *)first andSecond:(UIButton *)second andStop:(BOOL)shouldStop andStringArray:(NSArray *)array{

    if(shouldStop){
        
        [self show:!shouldStop mainView:first.superview];
        
        [second removeFromSuperview];
        
        [UIView animateWithDuration:0.3f animations:^{
            
            [superview layoutIfNeeded];
            
        }completion:^(BOOL finished) {
            
            if(shouldStop){
                
                [first.superview removeFromSuperview];
            }
        }];
        
        return;
    }
    
    [first setTitle:array[counter] forState:UIControlStateNormal];
    
    [self resetLabelLeading:first];
    
    counter++;
    
    [first.superview layoutIfNeeded];
    
    [self startAnimatingViewAway:second andViewThatWillAppear:first andOnCompletion:^{
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
        
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            
            BOOL shouldStop;
            
            if(counter > array.count - 1){
                
                shouldStop = YES;
                
            }else{
                
                shouldStop = NO;
            }
            
            [self startAnimationChainFor:second andSecond:first andStop:shouldStop andStringArray:array];
        });
    }];
}

#pragma mark - Button Press

-(void)buttonPressed:(UIButton *)sender{
    
    if([self.delegate respondsToSelector:@selector(buttonPressed:)]){
        
        [self.delegate buttonPressed:sender];
    }
}

@end
