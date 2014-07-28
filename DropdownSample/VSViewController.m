//
//  VSViewController.m
//  DropdownSample
//
//  Created by Vishal Singh Panwar on 24/07/14.
//  Copyright (c) 2014 Vishal Singh Panwar. All rights reserved.
//

#import "VSViewController.h"
#import "VSDropdown.h"
@interface VSViewController ()<VSDropdownDelegate>
{
    VSDropdown *_dropdown;
}
- (IBAction)testAction:(id)sender;

@end

@implementation VSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dropdown = [[VSDropdown alloc]initWithDelegate:self];
    [_dropdown setAdoptParentTheme:YES];
    [_dropdown setShouldSortItems:YES];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testAction:(id)sender
{
    [self showDropDownForButton:sender adContents:@[@"Hello World",@"Dropdown test",@"Aplhabetic Sorting",@"Test Dropdown 1",@"Test Dropdown 2",@"Test Dropdown 3",@"Test Dropdown 4",@"Just a random text to check multi-line capability of dropdown. We will be having self sizing cells in iOS8  :D"]];
    
}

-(void)showDropDownForButton:(UIButton *)sender adContents:(NSArray *)contents
{
    [_dropdown setupDropDownForView:sender];
    
    [_dropdown reloadDropdownWithContents:contents andSelectedString:sender.titleLabel.text];
    
    
}


- (void)dropdown:(VSDropdown *)dropDown didSelectValue:(NSString *)str atIndex:(NSUInteger)index
{
    if ([dropDown.dropDownView isKindOfClass:[UIButton class]])
    {
        UIButton *btn = (UIButton *)dropDown.dropDownView;
        [btn setTitle:str forState:UIControlStateNormal];
        
    }
    
}

@end
