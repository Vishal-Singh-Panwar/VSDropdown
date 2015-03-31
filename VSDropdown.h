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


#import <UIKit/UIKit.h>

/** Enum representing different Dropdown direction*/
typedef NS_ENUM(NSUInteger, VSDropdown_Direction)
{
    /** Enum representing automatic direction.*/
    VSDropdownDirection_Automatic = 0,
    
    /** Enum representing up direction.*/
    VSDropdownDirection_Up,
    
    /** Enum representing down direction.*/
    VSDropdownDirection_Down
};

/** Enum representing different Dropdown direction*/
typedef NS_ENUM(NSUInteger, DropdownAnimation)
{
    /** Enum representing automatic direction.*/
    DropdownAnimation_Fade = 0,
    
    /** Enum representing up direction.*/
    DropdownAnimation_Scale,
    
    /** Enum representing down direction.*/
    DropdownAnimation_None
};


@class VSDropdown;

/** Protocol for dropdown. */
@protocol VSDropdownDelegate <NSObject>

@optional



/** Asks  dropdown delegate for the corner radius.
 
 @param dropDown reference to VSDropdown object.
 @return Return corner radius of dropdown.
 
 */
-(CGFloat)cornerRadiusForDropdown:(VSDropdown *)dropdown;

/** Asks  dropdown delegate for the color of outline.
 
 @param dropDown reference to VSDropdown object.
 @return Return color of outline.
 
 */
-(UIColor *)outlineColorForDropdown:(VSDropdown *)dropdown;


/** Asks dropdown delegate for the outline width.
 
 @param dropDown reference to VSDropdown object.
 @return Return width of outline.
 
 */
-(CGFloat)outlineWidthForDropdown:(VSDropdown *)dropdown;


/** Asks  dropdown delegate for the dropdown offset.
 
 @param dropDown reference to VSDropdown object.
 @return Return offset of dropdown.
 
 */
-(CGFloat)offsetForDropdown:(VSDropdown *)dropdown;


/** called on dropdown delegate whenever an item is selected from dropdown.
 
 @param dropDown reference to VSDropdown object.
 @param str String which is selected.
 @param index Index of selected item in the content array which was passed as datasource.
 
 */
-(void)dropdown:(VSDropdown *)dropDown didSelectValue:(NSString *)str atIndex:(NSUInteger)index __attribute((deprecated("use  dropdown: didChangeSelectionForValue: atIndex: selected:  instead")));



/** called on dropdown delegate whenever selection is changed for an item.
 
 @param dropDown reference to VSDropdown object.
 @param str String for which selection is changed.
 @param index Index of item in the content array for which selection is changed.
 @param selected Bool value, if YES then item is selected else it is deselected.
 */

-(void)dropdown:(VSDropdown *)dropDown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected;



/** called on dropdown delegate whenever frame calculation is completed on dropdown.
 
 @param dropDown reference to VSDropdown object.
 @param frame Frame which is set. This can be used to provide some offset as per your requirement.
 
 */
-(void)dropdown:(VSDropdown *)dropDown didSetFrame:(CGRect )frame;


/** called on dropdown delegate whenever an item is deselected from dropdown.
 
 @param dropDown reference to VSDropdown object.
 @param str String which is deselected.
 @param index Index of selected item in the content array which was passed as datasource.
 
 */
-(void)dropdown:(VSDropdown *)dropDown didDeselectValue:(NSString *)str atIndex:(NSUInteger)index;


/** called on dropdown delegate whenever dropdown is added to a view using showDropDownForView: method
 
 @param dropDown reference to VSDropdown object.
 
 */

-(void)dropdownDidAppear:(VSDropdown *)dropDown;


/** called on dropdown delegate whenever dropdown is removed from a view using remove method.
 
 @param dropDown reference to VSDropdown object.
 
 */
-(void)dropdownWillDisappear:(VSDropdown *)dropDown;



@end

/**---------------------------------------------------------------------------------------
 *  Custom Dropdown Menu. In order to have common view for different models, any model can be used by specifying the keypath name of the key whose value needs to be displayed in the dropdown.
 *  ---------------------------------------------------------------------------------------
 */

@interface VSDropdown : UIView<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,assign)UITableViewCellSeparatorStyle separatorType;

@property(nonatomic,strong)UIColor *separatorColor;

@property(nonatomic,strong)UIColor *textColor;

/** Holds reference to tableView used in dropdown. */
@property (nonatomic,readonly)UITableView *tableView;

/** Holds reference to view for which dropdown is called. */
@property(nonatomic,weak,readonly)UIView *dropDownView;

/** Array containing items to show in dropdown. */
@property(nonatomic,readonly)NSArray *dataArr;

/** Alphabetically sorted dataArr. */
@property(nonatomic,readonly)NSMutableArray *sortedArr;

/** Reference to slected items in dropdown. */
@property(nonatomic,readonly)NSArray *selectedItems;

/** Reference to font used in dropdown*/
@property(nonatomic,readonly)UIFont *font;

/** Array containing items which should be disbaled*/
@property(nonatomic,readonly)NSMutableArray *disabledArray;

/** Direction for dropdown*/
@property(nonatomic,assign)VSDropdown_Direction direction;

/** Assigned direction  for dropdown*/
@property(nonatomic,readonly)VSDropdown_Direction assignedDirection;

/** Determines whether dropdown should adopt parent color theme. */
@property(nonatomic,assign)BOOL adoptParentTheme;

/** Determines whether dropdown should display items in sorted form. */
@property(nonatomic,assign)BOOL shouldSortItems;

/** Determines whether dropdown should display items in sorted form. */
@property(nonatomic,assign)BOOL controlRemovalManually;


/** Delegate to recive events from dropdown */
@property(nonatomic,weak)id<VSDropdownDelegate>delegate;

/** Dropdown height. Default is 160.0*/
@property(nonatomic,assign)CGFloat maxDropdownHeight;

/** Dropdown backGround imageview.*/
@property(nonatomic,readonly)UIImageView *backGroundImageView;

/** Dropdown backGround imageview.*/
@property(nonatomic,assign)DropdownAnimation drodownAnimation;


@property(nonatomic,assign)BOOL allowMultipleSelection;


/** Initializes and returns a newly allocated Dropdown object with the specified delegate, selectedStr and content. Content is used as datasource for the dropdown tableView.
 
 @param delegate delegate for the dropdown.
 
 */
-(instancetype)initWithDelegate:(id<VSDropdownDelegate>)delegate;



/** Use this method to show a dropdown over/below a view. If view passed is a UIButton, than font of the UIButton will be used.
 
 @param view UIView below/over which dropdown is required.
 */
-(void)setupDropdownForView:(UIView *)view;



/** Use this method to show a dropdown over/below a view. If view passed is a UIButton, than font of the UIButton will be used.
 
 @param view UIView below/over which dropdown is required.
 @param direction direction in which dropdowm is required.
 */
-(void)setupDropdownForView:(UIView *)view direction:(VSDropdown_Direction)direction;



/** Use this method to show a dropdown over/below a view. If view passed is a UIButton, than font of the UIButton will be used.
 
 @param view UIView below/over which dropdown is required.
 @param direction direction in which dropdowm is required.
 @param baseColor dropdown gadient will be formed using basecolor.
 @param scale gradient scale (from -1 to 1).
 
 */
-(void)setupDropdownForView:(UIView *)view direction:(VSDropdown_Direction)direction withBaseColor:(UIColor *)baseColor scale:(float)scale;



/** Use this method to show a dropdown over/below a view. If view passed is a UIButton, than font of the UIButton will be used.
 
 @param view UIView below/over which dropdown is required.
 @param direction direction in which dropdowm is required.
 @param topColor top color component of gradient.
 @param bottomColor bottom color component of gradient.
 
 @param scale gradient scale (from -1 to 1).
 
 @note scale will be ignored if both topColor and bottomColor are not nil. bottomColor value will be ignored if topColor is nil. If adoptParentTheme is set to YES then all the color component values passed will be ignored.
 
 */
-(void)setupDropdownForView:(UIView *)view direction:(VSDropdown_Direction)direction withTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor scale:(float)scale;


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
-(void)reloadDropdownWithContents:(NSArray *)contents andSelectedItems:(NSArray *)selectedItems;



/** Use this method to to reload the contents of Dropdown using models
 @param contents Array containing the Model objects whose keyPath values will be displayed in dropDown
 @param keyPath A key path of the form relationship.property (with one or more relationships)
 @param selectedItems Items which should be selected after reload.
 
 */
-(void)reloadDropdownWithContents:(NSArray *)contents keyPath:(NSString *)keyPath selectedItems:(NSArray *)selectedItems;



-(void)reloadDropdownWithContents:(NSArray *)contents keyPath:(NSString *)keyPath selectedItems:(NSArray *)selectedItems imageKey:(NSString *)imageKey;


-(void)reloadDropdownWithContents:(NSArray *)contents imageNames:(NSArray *)imageNames selectedItems:(NSArray *)selectedItems;



-(void)didPerformSetup;


-(CGFloat)cornerRadius;


-(CGFloat)outlineWidth;


-(UIColor *)outlineColor;

@end



/**---------------------------------------------------------------------------------------
 *  Dropdown model.
 *  ---------------------------------------------------------------------------------------
 */
@interface VSDropdownItem : NSObject

@property (nonatomic,strong)NSString *itemValue;
@property (nonatomic,strong)UIImage *itemImage;

@end

