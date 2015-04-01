//
//  LHWModalInputViewController.m
//  Weather
//
//  Created by Jeffrey C Rosenthal on 3/24/15.
//  Copyright (c) 2015 Lighthouse Labs. All rights reserved.
//

#import "LHWModalInputViewController.h"
#import "Toto.h"
#import "TotoStore.h"

@interface LHWModalInputViewController () <UITextFieldDelegate>
@property (strong, nonatomic)Toto *thingToDo;

-(int)fieldScanner:(NSString *)fieldInput;


@end

@implementation LHWModalInputViewController {
    NSString *taskInput;
    NSInteger priorityInput;
    NSString *taskDescriptionInput;
    CGFloat width;
    CGFloat height;
    NSInteger questionCount;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    questionCount = 0;
    taskDescriptionInput = [[NSString alloc]init];
    taskInput = [[NSString alloc]init];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundamerica"]];
    
    UITextField *taskListTextField = [[UITextField alloc]initWithFrame:CGRectMake((width / 6), 73, ((width / 3) * 2), (height / 3))];
    taskListTextField.delegate = self;
    taskListTextField.textColor = [UIColor whiteColor];
    taskListTextField.borderStyle = UITextBorderStyleBezel;
    taskListTextField.placeholder = @"Nam yr Task";
    taskListTextField.tintColor = [UIColor whiteColor];
    taskListTextField.returnKeyType = UIReturnKeyDone;
    taskListTextField.backgroundColor = [UIColor colorWithRed:0 green:(128 / 255.0) blue:(128 / 255.0) alpha:1];
    
    [self.view addSubview:taskListTextField];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(LHWViewController *)cityWithNameAndImage{
//    if (tempInput && nameInput) {
//        LHWCityModel *aCity = [[LHWCityModel alloc]initCustomName:nameInput Temperature:tempInput Image:[self checkTemperature]];
//
//        return [LHWViewController cityViewWithCity:aCity];
//    }
//    else {
//        return [LHWViewController cityViewWithCity:[LHWCityModel initCardiff]];
//    }
//    }

-(int)fieldScanner:(NSString *)fieldInput{
    NSMutableString *numberCatcher = [[NSMutableString alloc]init];
    NSScanner *numberScanner = [NSScanner scannerWithString:fieldInput];
    [numberScanner setCharactersToBeSkipped:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    [numberScanner scanCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:&numberCatcher];
    NSString *wtf = [NSString stringWithString:[numberCatcher copy]];
    int lol = [wtf intValue];
    return lol;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (questionCount == 0) {
        taskInput = textField.text;
        textField.placeholder = [NSString stringWithFormat:@"thx man. is %@ a big priority?", taskInput];
        textField.text = @"";
        questionCount = 1;
        [textField resignFirstResponder];
        return YES;
    }
    else if (questionCount == 1) {
        priorityInput = [self fieldScanner:textField.text];
        textField.placeholder = @"cool. Now how about a description";
        textField.text = @"";
        [textField resignFirstResponder];
        questionCount++;
        return YES;
        
    }
        else if (questionCount == 2){
            taskDescriptionInput = textField.text;
            textField.placeholder = @"OMG GREAT U ADDED A ITEM LULZZ";
            textField.text = @"";
            [textField resignFirstResponder];
//            [[TotoStore sharedStore] addItemToList:[Toto initWithTitle:taskInput andDetails:taskDescriptionInput andPriority:priorityInput andCompletedBool:false]];
            
            taskInput = nil;
            questionCount = 0;
            return YES;
        
}
    else {
        questionCount = 0;
        textField.placeholder = @"huh? Lets start again. Name?";
        textField.text = @"";
        [textField resignFirstResponder];
        return YES;
    }
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