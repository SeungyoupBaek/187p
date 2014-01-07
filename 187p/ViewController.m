//
//  ViewController.m
//  187p
//
//  Created by Youp on 2014. 1. 7..
//  Copyright (c) 2014년 admin. All rights reserved.
//

#import "ViewController.h"
#define CELL_ID @"CELL_ID"

@interface ViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController{
    NSMutableArray *data;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    return cell;
}

// 셀 편집 승인 작업 작성
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [data removeObjectAtIndex:indexPath.row];
        //테이블에서 셀을 삭제해서 데이터와 동기화
        NSArray *rows = [NSArray arrayWithObject:indexPath];
        [self.table deleteRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}


-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSObject *obj = [data objectAtIndex:sourceIndexPath.row];
    [data removeObjectAtIndex:sourceIndexPath.row];
    [data insertObject:obj atIndex:destinationIndexPath.row];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    data = [[NSMutableArray alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
}

// 새데이터추가 - 셀반영
-(IBAction)addItem:(id)sender{
    NSString *inputStr = self.userInput.text;
    if ([inputStr length] > 0) {
        // add Data
        [data addObject:inputStr];
        
        // add cell
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(data.count-1) inSection:0];
        NSArray *row = [NSArray arrayWithObject:indexPath];
        [self.table insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationAutomatic];
        
        //init textfield
        self.userInput.text = @"";
    }
}

// change editMode to ToggleMode
-(IBAction)toggleEditMode:(id)sender{
    self.table.editing = !self.table.editing;
    ((UIBarButtonItem *)sender).title = self.table.editing ? @"Done" : @"Edit";
}

// add data using returnKey in TextField
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self addItem:nil];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
