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
@property (nonatomic,strong) IBOutlet NSLayoutConstraint *answerWidthConstraint;

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

@property (nonatomic, weak) IBOutlet UIButton *keyA;
@property (nonatomic, weak) IBOutlet UIButton *keyB;
@property (nonatomic, weak) IBOutlet UIButton *keyC;
@property (nonatomic, weak) IBOutlet UIButton *keyD;
@property (nonatomic, weak) IBOutlet UIButton *keyE;
@property (nonatomic, weak) IBOutlet UIButton *keyF;
@property (nonatomic, weak) IBOutlet UIButton *keyG;
@property (nonatomic, weak) IBOutlet UIButton *keyH;
@property (nonatomic, weak) IBOutlet UIButton *keyI;
@property (nonatomic, weak) IBOutlet UIButton *keyJ;
@property (nonatomic, weak) IBOutlet UIButton *keyK;
@property (nonatomic, weak) IBOutlet UIButton *keyL;
@property (nonatomic, weak) IBOutlet UIButton *keyM;
@property (nonatomic, weak) IBOutlet UIButton *keyN;
@property (nonatomic, weak) IBOutlet UIButton *keyO;
@property (nonatomic, weak) IBOutlet UIButton *keyP;
@property (nonatomic, weak) IBOutlet UIButton *keyQ;
@property (nonatomic, weak) IBOutlet UIButton *keyR;
@property (nonatomic, weak) IBOutlet UIButton *keyS;
@property (nonatomic, weak) IBOutlet UIButton *keyT;
@property (nonatomic, weak) IBOutlet UIButton *keyU;
@property (nonatomic, weak) IBOutlet UIButton *keyV;
@property (nonatomic, weak) IBOutlet UIButton *keyW;
@property (nonatomic, weak) IBOutlet UIButton *keyX;
@property (nonatomic, weak) IBOutlet UIButton *keyY;
@property (nonatomic, weak) IBOutlet UIButton *keyZ;

@property (nonatomic, strong) IBOutlet UIImageView *hangmanImageView;
@property (nonatomic, strong) NSArray *hangmanImagesArray;


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
        NSLog(@"clicked at index %li",(long)buttonIndex);
        if(buttonIndex == [alertview firstOtherButtonIndex]) {
            [self pressedResetGame:self];
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
        else{
            [self lockDownKeyBoard];
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
    UIImage *image1 = [UIImage imageNamed:@"Hangman01.png"];
    UIImage *image2 = [UIImage imageNamed:@"Hangman02.png"];
    UIImage *image3 = [UIImage imageNamed:@"Hangman03.png"];
    UIImage *image4 = [UIImage imageNamed:@"Hangman04.png"];
    UIImage *image5 = [UIImage imageNamed:@"Hangman05.png"];
    UIImage *image6 = [UIImage imageNamed:@"Hangman06.png"];
    UIImage *image7 = [UIImage imageNamed:@"Hangman07.png"];
    UIImage *image8 = [UIImage imageNamed:@"Hangman08.png"];
    UIImage *image9 = [UIImage imageNamed:@"Hangman09.png"];
    UIImage *image10 = [UIImage imageNamed:@"Hangman10.png"];
    _hangmanImagesArray = [[NSArray alloc] initWithObjects:image1,image2,image3,image4,image5,image6,image7,image8,image9,image10, nil];
    NSLog(@"Array of Image: %lu", _hangmanImagesArray.count);
//    _hangmanImagesArray= @[image1,image2,image3,image4,image5,image6,image7,image8,image9,image10];
    
    
    
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
        NSLog(@"Wrong Count: %lu", (unsigned long)_hangmanImagesArray.count);
        
        [_hangmanImageView setImage:_hangmanImagesArray[loseCounterInt]];
        loseCounterInt++;
        [key setTitle:@"X" forState:UIControlStateNormal];
        [key setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        //make images appear here
        
        
        
        NSLog(@"you have failed %i times",loseCounterInt);
    }
    //answerWord = [answerWord uppercaseString];
    NSString *loseResponseString =[NSString stringWithFormat:@"The word was %@. Do you want to start a new game?",answerWord.uppercaseString];
    if (loseCounterInt ==10) {
        UIAlertView *loseGameAlert = [[UIAlertView alloc] initWithTitle:@"You LOSE!"
                                                                   message:loseResponseString delegate:self cancelButtonTitle:@"Cancel"
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

- (void)setButtonValues:(UIButton *)key withString:(NSString *)letterName {
    [key setUserInteractionEnabled:true];
    [key setTitle:letterName forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
    
    // *** Repeat next line for other 25 keys
    [self setButtonValues:_keyA withString:@"A"];
    //undisable key board
    UIButton *key = _keyA;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"A" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyB;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"B" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    key = _keyC;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"C" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyD;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"D" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyE;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"E" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyF;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"F" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyG;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"G" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyH;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"H" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyI;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"I" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyJ;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"J" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyK;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"K" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyL;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"L" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyM;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"M" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyN;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"N" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyO;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"O" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyP;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"P" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyQ;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"Q" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyR;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"R" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyS;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"S" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyT;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"T" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyU;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"U" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyV;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"V" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyW;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"W" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyX;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"X" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyY;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"Y" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    key = _keyZ;
    [key setUserInteractionEnabled:true];
    [key setTitle:@"Z" forState:UIControlStateNormal];
    [key setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_hangmanImageView setImage:nil];
    

}
-(void) lockDownKeyBoard {
    UIButton *key = _keyA;
    [key setUserInteractionEnabled:false];
    
    key = _keyB;
    [key setUserInteractionEnabled:false];
    
    key = _keyC;
    [key setUserInteractionEnabled:false];
    
    key = _keyD;
    [key setUserInteractionEnabled:false];
    
    key = _keyE;
    [key setUserInteractionEnabled:false];
    
    key = _keyF;
    [key setUserInteractionEnabled:false];
    
    key = _keyG;
    [key setUserInteractionEnabled:false];
    
    key = _keyH;
    [key setUserInteractionEnabled:false];
    
    key = _keyI;
    [key setUserInteractionEnabled:false];
    
    key = _keyJ;
    [key setUserInteractionEnabled:false];
    
    key = _keyK;
    [key setUserInteractionEnabled:false];
    
    key = _keyL;
    [key setUserInteractionEnabled:false];
    
    key = _keyM;
    [key setUserInteractionEnabled:false];
    
    key = _keyN;
    [key setUserInteractionEnabled:false];
    
    key = _keyO;
    [key setUserInteractionEnabled:false];
    
    key = _keyP;
    [key setUserInteractionEnabled:false];
    
    key = _keyQ;
    [key setUserInteractionEnabled:false];
    
    key = _keyR;
    [key setUserInteractionEnabled:false];
    
    key = _keyS;
    [key setUserInteractionEnabled:false];
    
    key = _keyT;
    [key setUserInteractionEnabled:false];
    
    key = _keyU;
    [key setUserInteractionEnabled:false];
    
    key = _keyV;
    [key setUserInteractionEnabled:false];
    
    key = _keyW;
    [key setUserInteractionEnabled:false];
    
    key = _keyX;
    [key setUserInteractionEnabled:false];
    
    key = _keyY;
    [key setUserInteractionEnabled:false];
    
    key = _keyZ;
    [key setUserInteractionEnabled:false];

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
    [self lockDownKeyBoard];
        // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
