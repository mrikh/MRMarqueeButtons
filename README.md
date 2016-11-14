# MRMarqueeButtons
You can show the buttons on any view and it will display a sort of ticker based on an array of strings that you pass. It will adjust itself to fit across the whole width and display all the strings once. Now as they are buttons, you need to implement the delegate to get which button is pressed. (They don't have tags but you can compare the title label :D). There are only at most 2 buttons created at any time so you can use as large as an array as you want, without worrying about memory issues. All the layouting is done using constraints so using it directly from viewDidLoad won't pose a problem.

**To do:** 
  * Support orientation changes
  * Make the text loopable
  * Remove truncation if required by user and automatically calculate height.
  * Allow user to set set duration of label visibility

##How to:-
To use this, simply download the whole project and drag and drop the marqueeButton group folder to your own project.

![Alt Text](https://thumbs.gfycat.com/WhichOpenCrustacean-size_restricted.gif)

######Use the below code segment anywhere to show the pop over:
    
    NSArray *stringsArray = @[@"Hello",@"Work!",@"OMG",@"Is it fine?",@"Please :D"];
    
    MRMarqueeButtons *labels = [[MRMarqueeButtons alloc] initOnView:self.view withArray:stringsArray];
    
    labels.delegate = self;
    
    [labels startAnimating];
   
To call the delegate-

    -(void)buttonPressed:(UIButton *)sender{
    
          NSLog(@"Handle Button Press");
    }
