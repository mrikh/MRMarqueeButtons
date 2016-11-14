# MRMarqueeButtons

To use this, simply download the whole project and drag and drop the marqueeButton group folder to your own project.

**To do:** 
  * Support orientation changes
  * Make the text loopable
  * Remove truncation if required by user and automatically calculate height.
  * Allow user to set set duration of label visibility

##How to:-
You can show the labels on any view you desire and it will display a sort of ticker based on an array of strings that you pass. It will adjust itself to fit across the whole width and display all the strings once. Now as they are buttons, you need to implement the delegate to get which button is pressed. (They don't have tags but you can compare the title label :D).

######Use the below code segment anywhere to show the pop over:
    
    NSArray *stringsArray = @[@"Hello",@"Work!",@"OMG",@"Is it fine?",@"Please :D"];
    
    MRMarqueeButtons *labels = [[MRMarqueeButtons alloc] initOnView:self.view withArray:stringsArray];
    
    labels.delegate = self;
    
    [labels startAnimating];
   
To call the delegate-

    -(void)buttonPressed:(UIButton *)sender{
    
          NSLog(@"Handle Button Press");
    }
