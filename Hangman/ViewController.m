//
//  ViewController.m
//  Hangman
//
//  Created by Jack Borthwick on 6/4/15.
//  Copyright (c) 2015 Jack Borthwick. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,weak) NSArray *wordArray;

@property (nonatomic, weak) IBOutlet UILabel *answerLabel1;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel2;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel3;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel4;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel5;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel6;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel7;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel8;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel9;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel10;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel11;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel12;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel13;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel14;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel15;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel16;
@property (nonatomic, strong) NSArray *answerArray;
@end

@implementation ViewController
NSString *answerWord;
int winCounterInt = 0;
int loseCounterInt = 0;

#pragma mark - New Game Methods

-(IBAction)newGamePressed:(id)sender
{
    NSLog(@"New Game Button Pressed");
    UIAlertView *newGameAlert = [[UIAlertView alloc] initWithTitle:@"New Game"
        message:@"Do you want to start a new game?" delegate:self cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Start",nil];
    newGameAlert.tag = 1;
    [newGameAlert show];
}
-(void)alertView:(UIAlertView *)alertview clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertview.tag == 1) {
        NSLog(@"clicked at index %i",buttonIndex);
        if(buttonIndex == [alertview firstOtherButtonIndex]) {
            [self pressedNewGameAlert:self];
        }
    }
    else if (alertview.tag == 2) {
        NSLog(@"clicked at index %i",buttonIndex);
        if(buttonIndex == [alertview firstOtherButtonIndex]) {
            [self pressedResetGame:self];
            [self pressedNewGameAlert:self];
            NSLog(@"start new game after winning");
            //reset board here
        }
    }
}
-(IBAction)pressedNewGameAlert:(id)sender {
    NSLog(@"pressed new game alert");
    _wordArray = [self convertCSVStringToArray:[self readBundleFileToString:@"AppleWordSet2" ofType:@"csv"]];
    int randomWordIndex = arc4random_uniform((uint32_t)_wordArray.count);
    NSLog(@"%@",_wordArray[randomWordIndex]);
    //[self findBiggestWord:self];
    //[_answerLabel1 setHidden:false];
    answerWord = _wordArray[randomWordIndex];
    [self setAnswerLabelUnhide:_wordArray[randomWordIndex]];
    _answerArray = [self convertStringToCharArray:answerWord];
    
    
}

-(NSArray *)convertStringToCharArray:(NSString *)textstring {
    NSMutableArray *characters= [[NSMutableArray alloc] initWithCapacity:[textstring length]];
    for (int i=0; i < [textstring length]; i++) {
        NSString *ichar =[NSString stringWithFormat:@"%c", [textstring characterAtIndex:i]];
        [characters addObject:ichar];
    }
    return characters;
}
-(void)setAnswerLabelUnhide:(NSString *)name {
    
    NSInteger nameLth = name.length;
    if (nameLth >= 1){
        [_answerLabel1 setHidden:false];
    }
    if (nameLth >= 2){
        [_answerLabel2 setHidden:false];
    }
    if (nameLth >= 3){
        [_answerLabel3 setHidden:false];
    }
    if (nameLth >= 4){
        [_answerLabel4 setHidden:false];
    }
    if (nameLth >= 5){
        [_answerLabel5 setHidden:false];
    }
    if (nameLth >= 6){
        [_answerLabel6 setHidden:false];
    }
    if (nameLth >= 7){
        [_answerLabel7 setHidden:false];
    }
    if (nameLth >= 8){
        [_answerLabel8 setHidden:false];
    }
    if (nameLth >= 9){
        [_answerLabel9 setHidden:false];
    }
    if (nameLth >= 10){
        [_answerLabel10 setHidden:false];
    }
    if (nameLth >= 11){
        [_answerLabel11 setHidden:false];
    }
    if (nameLth >= 12){
        [_answerLabel12 setHidden:false];
    }
    if (nameLth >= 13){
        [_answerLabel13 setHidden:false];
    }
    if (nameLth >= 14){
        [_answerLabel14 setHidden:false];
    }
    if (nameLth >= 15){
        [_answerLabel15 setHidden:false];
    }
    if (nameLth >= 16){
        [_answerLabel16 setHidden:false];
    }
}
-(IBAction)findBiggestWord:(id)sender {
    NSLog(@"find biggestword");
    int maxLength, stringLength;
    maxLength = 0;
    stringLength = 1;
    for (NSString *name in _wordArray) {
        stringLength = [name length];
        if (stringLength > maxLength) {
            NSLog(@"%i",maxLength);
            maxLength = stringLength;
        }
    }
    NSLog(@"%i",maxLength);
}


- (IBAction)keyboardPressed:(UIButton *)key {
    NSLog(@"Key: %@", key.titleLabel.text);
    NSString *letter = key.titleLabel.text.lowercaseString;
    NSMutableArray *letterPositionArray = [[NSMutableArray alloc] init];
    BOOL wordContainsLetter = false;
    for(int i=0;i<_answerArray.count;i++){
        if ([letter isEqualToString:_answerArray[i]]){
            NSLog(@"Correct Letter Found at %i",i);
            [letterPositionArray addObject:[NSNumber numberWithInt:i]];
            int firstValue = [[letterPositionArray objectAtIndex:0] intValue];
            NSLog(@"in letterPositionArray %i",firstValue);
            wordContainsLetter = true;
            
            //UIColor *color = [UIColor greenColor];
            //key.titleLabel.text = @"X";
            [key setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];//set user interactivity
            NSLog(key.titleLabel.text);//changing the text but not on the screen.
        }
    }
    if (!wordContainsLetter) {//letter not found game state////
        loseCounterInt++;
        [key setTitle:@"X" forState:UIControlStateNormal];
        [key setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        //make images appear here
        
        NSLog(@"you have failed %i times",loseCounterInt);
    }
    if (loseCounterInt ==10) {
        UIAlertView *loseGameAlert = [[UIAlertView alloc] initWithTitle:@"You LOSE!"
                                                                   message:@"Do you want to start a new game?" delegate:self cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:@"Start",nil];
        loseGameAlert.tag = 2;
        [loseGameAlert show];
    }
    [key setUserInteractionEnabled:false];
    [self setAnswerLabelCorrect:letterPositionArray];
}
-(void) setAnswerLabelCorrect:(NSMutableArray *)letterPositionArray {
    for(int i=0;i<letterPositionArray.count;i++){
        winCounterInt++;
        int position = [[letterPositionArray objectAtIndex:i] intValue];
        if (position == 0){
            _answerLabel1.text = _answerArray[0];
            _answerLabel1.text = _answerLabel1.text.capitalizedString;
        }
        if (position == 1){
            _answerLabel2.text = _answerArray[1];
            _answerLabel2.text = _answerLabel2.text.capitalizedString;
        }
        if (position == 2){
            _answerLabel3.text = _answerArray[2];
            _answerLabel3.text = _answerLabel3.text.capitalizedString;
        }
        if (position == 3){
            _answerLabel4.text = _answerArray[3];
            _answerLabel4.text = _answerLabel4.text.capitalizedString;
        }
        if (position == 4){
            _answerLabel5.text = _answerArray[4];
            _answerLabel5.text = _answerLabel5.text.capitalizedString;
        }
        if (position == 5){
            _answerLabel6.text = _answerArray[5];
            _answerLabel6.text = _answerLabel6.text.capitalizedString;
        }
        if (position == 6){
            _answerLabel7.text = _answerArray[6];
            _answerLabel7.text = _answerLabel7.text.capitalizedString;
        }
        if (position == 7){
            _answerLabel8.text = _answerArray[7];
            _answerLabel8.text = _answerLabel8.text.capitalizedString;
        }
        if (position == 8){
            _answerLabel9.text = _answerArray[8];
            _answerLabel9.text = _answerLabel9.text.capitalizedString;
        }
        
        if (position == 9){
            _answerLabel10.text = _answerArray[9];
            _answerLabel10.text = _answerLabel10.text.capitalizedString;
        }
        if (position == 10){
            _answerLabel11.text = _answerArray[10];
            _answerLabel11.text = _answerLabel11.text.capitalizedString;
        }
        if (position == 11){
            _answerLabel12.text = _answerArray[11];
            _answerLabel12.text = _answerLabel12.text.capitalizedString;
        }
        if (position == 12){
            _answerLabel13.text = _answerArray[12];
            _answerLabel13.text = _answerLabel13.text.capitalizedString;
        }
        if (position == 13){
            _answerLabel14.text = _answerArray[13];
            _answerLabel14.text = _answerLabel14.text.capitalizedString;
        }
        if (position == 14){
            _answerLabel15.text = _answerArray[14];
            _answerLabel15.text = _answerLabel15.text.capitalizedString;
        }
        if (position == 15){
            _answerLabel16.text = _answerArray[15];
            _answerLabel16.text = _answerLabel16.text.capitalizedString;
        }
    }
    if(winCounterInt == answerWord.length) {//win game state
        
        UIAlertView *restartGameAlert = [[UIAlertView alloc] initWithTitle:@"You Won!"
                                                               message:@"Do you want to start a new game?" delegate:self cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:@"Start",nil];
        restartGameAlert.tag = 2;
        [restartGameAlert show];
    }

}
-(IBAction)pressedResetGame:(id)sender {
    [_answerLabel1 setHidden:true];
    [_answerLabel2 setHidden:true];
    [_answerLabel3 setHidden:true];
    [_answerLabel4 setHidden:true];
    [_answerLabel5 setHidden:true];
    [_answerLabel6 setHidden:true];
    [_answerLabel7 setHidden:true];
    [_answerLabel8 setHidden:true];
    [_answerLabel9 setHidden:true];
    [_answerLabel10 setHidden:true];
    [_answerLabel11 setHidden:true];
    [_answerLabel12 setHidden:true];
    [_answerLabel13 setHidden:true];
    [_answerLabel14 setHidden:true];
    [_answerLabel15 setHidden:true];
    [_answerLabel16 setHidden:true];
    _answerLabel1.text = @"";
    _answerLabel2.text = @"";
    _answerLabel3.text = @"";
    _answerLabel4.text = @"";
    _answerLabel5.text = @"";
    _answerLabel6.text = @"";
    _answerLabel7.text = @"";
    _answerLabel8.text = @"";
    _answerLabel9.text = @"";
    _answerLabel10.text = @"";
    _answerLabel11.text = @"";
    _answerLabel12.text = @"";
    _answerLabel13.text = @"";
    _answerLabel14.text = @"";
    _answerLabel15.text = @"";
    _answerLabel16.text = @"";
    loseCounterInt = 0;
    winCounterInt = 0;
    
    //remember to undisable key board
    
    

}

#pragma mark - Core Methods

- (NSString *)readBundleFileToString:(NSString *)filename ofType:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:type];
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
}

- (NSArray *)convertCSVStringToArray:(NSString *)csvString {
    NSString *cleanString = [[csvString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@","];
    return [cleanString componentsSeparatedByCharactersInSet:set];
}


#pragma mark - life cycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
