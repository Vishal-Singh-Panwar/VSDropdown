//
//  VSDropdown.h
//  DropdownSample
//
//  Created by Vishal Singh Panwar on 24/07/14.
//  Copyright (c) 2014 Vishal Singh Panwar. All rights reserved.
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.



/** Enum representing different Dropdown direction*/
typedef NS_ENUM(NSUInteger, Dropdown_Direction)
{
    /** Enum representing automatic direction.*/
    DropdownDirection_Automatic = 0,
    
    /** Enum representing up direction.*/
    DropdownDirection_Up,
    
    /** Enum representing down direction.*/
    DropdownDirection_Down
};


@class VSDropdown;

/** Protocol for dropdown. */
@protocol VSDropdownDelegate <NSObject>

@optional

/** called on dropdown delegate whenever an item is selected from dropdown.
 
 @param dropDown reference to VSDropdown object.
 @param str String which is selected.
 @param index Index of selected item in the content array which was passed as datasource.
 
 */
-(void)dropdown:(VSDropdown *)dropDown didSelectValue:(NSString *)str atIndex:(NSUInteger)index;


/** called on dropdown delegate whenever dropdown is added to a view using showDropDownForView: method
 
 @param dropDown reference to VSDropdown object.
 
 */

-(void)dropdownDidAppear:(VSDropdown *)dropDown;


/** called on dropdown delegate whenever dropdown is removed from a view using remove method.
 
 @param dropDown reference to VSDropdown object.
 
 */
-(void)dropdownDidDisappear:(VSDropdown *)dropDown;



@end
#import <UIKit/UIKit.h>

/**---------------------------------------------------------------------------------------
 *  Custom Dropdown Menu. Use this class along with a nib file named "VSDropdown".
 *  ---------------------------------------------------------------------------------------
 */

@interface VSDropdown : UIView

/** Holds reference to tableView used in dropdown. */
@property (nonatomic,readonly)UITableView *tableView;

/** Holds reference to view for which dropdown is called. */
@property(nonatomic,weak,readonly)UIView *dropDownView;

/** Array containing items to show in dropdown. */
@property(nonatomic,readonly)NSArray *dataArr;

/** Alphabetically sorted dataArr. */
@property(nonatomic,readonly)NSMutableArray *sortedArr;

/** Reference to slected item in dropdown. */
@property(nonatomic,readonly)NSString *seletecdStr;

/** Reference to font used in dropdown*/
@property(nonatomic,readonly)UIFont *font;


/** Reference to text color used in dropdown*/
@property(nonatomic,readonly)UIColor *textColor;

/** Array containing items which should be disbaled*/
@property(nonatomic,readonly)NSMutableArray *disabledArray;

/** Direction for dropdown*/
@property(nonatomic,assign)Dropdown_Direction direction;

/** Assigned direction  for dropdown*/
@property(nonatomic,readonly)Dropdown_Direction assignedDirection;

/** Determines whether dropdown should adopt parent color theme. */
@property(nonatomic,assign)BOOL adoptParentTheme;


@property(nonatomic,assign)BOOL shouldSortItems;


/** Deleate to recive events from dropdown */
@property(nonatomic,weak)id<VSDropdownDelegate>delegate;


@property(nonatomic,assign)CGFloat dropdownHeight;


@property(nonatomic,readonly)UIImageView *backGroundImageView;



/** Initializes and returns a newly allocated Dropdown object with the specified delegate, selectedStr and content. Content is used as datasource for the dropdown tableView.
 
 @note content array should only conatin NSString objects.
 @param dele Delegate for the dropdown.
 @param str String which you want to show as selected.
 @param content Array containing NSString objects which will be shown in dropdown table.
 @param disabled Array containing NSString objects which will be shown as disabled in dropdown table.
 
 @return An initialized instance of a  VSDropdown class or nil if an error occurred in the attempt to initialize the object.
 */
-(id)initWithDelegate:(id<VSDropdownDelegate>)dele selectedStr:(NSString *)str andContent:(NSArray *)content andDisabledContent:(NSArray *)disabled;


/** Initializes and returns a newly allocated Dropdown object with the specified delegate, selectedStr and content. Content is used as datasource for the dropdown tableView.
 
 @note content array should only conatin NSString objects.
 @param dele Delegate for the dropdown.
 @param str String which you want to show as selected.
 @param content Array containing NSString objects which will be shown in dropdown table.
 @param keyPath A key path of the form relationship.property (with one or more relationships)
 
 @note It is assumed that all the objects in passed content respond to passed keyPath
 
 @return An initialized instance of a  VSDropdown class or nil if an error occurred in the attempt to initialize the object.
 */
-(id)initWithDelegate:(id<VSDropdownDelegate>)dele selectedStr:(NSString *)str contents:(NSArray *)content forKeyPath:(NSString *)keyPath;


/** Initializes and returns a newly allocated Dropdown object with the specified delegate, selectedStr and content. Content is used as datasource for the dropdown tableView.
 
 @param delegate delegate for the dropdown.
 
 */
-(id)initWithDelegate:(id<VSDropdownDelegate>)delegate;



/** Use this method to show a dropdown over/below a view. If view passed is a UIButton, than font of the UIButton will be used.
 
 @param view UIView below/over which dropdown is required.
 */
-(void)setupDropDownForView:(UIView *)view;



/** Use this method to show a dropdown over/below a view. If view passed is a UIButton, than font of the UIButton will be used.
 
 @param view UIView below/over which dropdown is required.
 @param direction direction in which dropdowm is required.
 */
-(void)setupDropDownForView:(UIView *)view direction:(Dropdown_Direction)direction;



/** Use this method to show a dropdown over/below a view. If view passed is a UIButton, than font of the UIButton will be used.
 
 @param view UIView below/over which dropdown is required.
 @param direction direction in which dropdowm is required.
 @param baseColor dropdown gadient will be formed using basecolor.
 @param scale gradient scale (from -1 to 1).
 
 */
-(void)setupDropDownForView:(UIView *)view direction:(Dropdown_Direction)direction withBaseColor:(UIColor *)baseColor scale:(float)scale;



/** Use this method to show a dropdown over/below a view. If view passed is a UIButton, than font of the UIButton will be used.
 
 @param view UIView below/over which dropdown is required.
 @param direction direction in which dropdowm is required.
 @param topColor top color component of gradient.
 @param bottomColor bottom color component of gradient.
 
 @param scale gradient scale (from -1 to 1).
 
 @note scale will be ignored if both topColor and bottomColor are not nil. bottomColor value will be ignored if topColor is nil. If adoptParentTheme is set to YES then all the color component values passed will be ignored.
 
 */
-(void)setupDropDownForView:(UIView *)view direction:(Dropdown_Direction)direction withTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor scale:(float)scale;


/** Removes the receiver from the screen.
 
 */
-(void)remove;


/** Use this method to reload the contents of Dropdown
 @param contents Array containing the NSString objects which will be displayed in dropdown after reload.
 */
-(void)reloadDropdownWithContents:(NSArray *)contents;


/** Use this method to to reload the contents of Dropdown
 @param contents Array containing the NSString objects which will be displayed in dropdown after reload.
 @param selectedString String which should be selected after reload.
 
 */
-(void)reloadDropdownWithContents:(NSArray *)contents andSelectedString:(NSString *)selectedString;


/** Use this method to to reload the contents of Dropdown using models
 @param contents Array containing the Model objects whose keyPath values will be displayed in dropDown
 @param keyPath A key path of the form relationship.property (with one or more relationships)
 @param selectedString String which should be selected after reload.
 
 */
-(void)reloadDropdownWithContents:(NSArray *)contents keyPath:(NSString *)keyPath selectedString:(NSString *)selectedItem;


@end

