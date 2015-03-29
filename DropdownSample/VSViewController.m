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
    [self showDropDownForButton:sender adContents:@[@"Hello World",@"Dropdown test",@"Aplhabetic sorting",@"Dropdown Item 1",@"Dropdown Item 2",@"Dropdown Item 3",@"Dropdown Item 4",@"Dropdown Item 5",@"Dropdown Item 6",@"Dropdown Item 7",@"Dropdown Item 8",@"Dropdown Item 9",@"Dropdown Item 10"]];
    
}

-(void)showDropDownForButton:(UIButton *)sender adContents:(NSArray *)contents
{
    [_dropdown setAllowMultipleSelection:YES];
    
    [_dropdown setDrodownAnimation:rand()%2];
    
    [_dropdown setupDropdownForView:sender];
    
    [_dropdown setSeparatorColor:[UIColor whiteColor]];
    
    [_dropdown reloadDropdownWithContents:contents andSelectedItems:[sender.titleLabel.text componentsSeparatedByString:@","]];
    
    
}


- (void)dropdown:(VSDropdown *)dropDown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected
{
    if ([dropDown.dropDownView isKindOfClass:[UIButton class]])
    {
        UIButton *btn = (UIButton *)dropDown.dropDownView;
        NSString *allSelectedItems = [dropDown.selectedItems componentsJoinedByString:@","];
        [btn setTitle:allSelectedItems forState:UIControlStateNormal];
        
    }

}

- (UIColor *)outlineColorForDropdown:(VSDropdown *)dropdown
{
    return [UIColor whiteColor];
}

- (CGFloat)outlineWidthForDropdown:(VSDropdown *)dropdown
{
    return 2.0;
}



@end
