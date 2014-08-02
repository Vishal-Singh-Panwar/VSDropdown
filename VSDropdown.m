//
//  VSDropdown.m
//  DropdownSample
//
//  Created by Vishal Singh Panwar on 24/07/14.
//  Copyright (c) 2014 Vishal Singh Panwar. All rights reserved.
//

#import "VSDropdown.h"
#import <QuartzCore/QuartzCore.h>

static NSString *dropDownCellIdentifier = @"dropDownCellIdentifier";
static const CGFloat kDefaultHeight = 160.0;
static const NSTimeInterval kDefaultDuration = 0.35;


@interface VSDropdown ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *tap;
    BOOL topEdgeRounded;
    CGRect viewFrame;
    CGFloat colorComponentsVar[8];
    
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSMutableArray *sortedArr;
@property(nonatomic,strong)NSString *seletecdStr;
@property(nonatomic,strong)UIImageView *backGroundImageView;
@property(nonatomic,strong)UIFont *font;
@property(nonatomic,strong)UIColor *textColor;
@property(nonatomic,strong)NSMutableArray *disabledArray;
@property(nonatomic,weak)UIView *dropDownView;
@property(nonatomic,assign)Dropdown_Direction assignedDirection;

@end



@implementation VSDropdown

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        
    }
    return self;
}


-(void)awakeFromNib
{
    [self setBackgroundColor:[UIColor clearColor]];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGRect frame = rect;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGPathRef roundedRectPath = topEdgeRounded?[self newPathWithTopEdgeRounded:frame withRadius:5.0]:[self newPathWithBottomEdgeRounded:frame withRadius:5.0];
    
    
    CGContextAddPath(ctx, roundedRectPath);
    
    CGContextClip(ctx);
    
    
    [self addGradientToPath:roundedRectPath];
    
    CGPathRelease(roundedRectPath);
    
}


-(CGPathRef)newPathWithBottomEdgeRounded:(CGRect)rect withRadius:(CGFloat)radius
{
	CGMutablePathRef retPath = CGPathCreateMutable();
    
	CGRect innerRect = CGRectInset(rect, radius, radius);
    
	CGFloat inside_right = innerRect.origin.x + innerRect.size.width;
	CGFloat outside_right = rect.origin.x + rect.size.width;
	CGFloat inside_bottom =  innerRect.origin.y + innerRect.size.height;
	CGFloat outside_bottom =  rect.origin.y + rect.size.height;
    
	CGFloat inside_top = innerRect.origin.y;
	CGFloat outside_top = rect.origin.y;
	CGFloat outside_left = rect.origin.x;
    
	CGPathMoveToPoint(retPath, NULL, innerRect.origin.x, outside_top);
    
	CGPathAddLineToPoint(retPath, NULL, inside_right, outside_top);
	CGPathAddArcToPoint(retPath, NULL, outside_right, outside_top, outside_right, inside_top, 0);
	CGPathAddLineToPoint(retPath, NULL, outside_right, inside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_right, outside_bottom, inside_right, outside_bottom, radius);
    
	CGPathAddLineToPoint(retPath, NULL, innerRect.origin.x, outside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_bottom, outside_left, inside_bottom, radius);
	CGPathAddLineToPoint(retPath, NULL, outside_left, inside_top);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_top, innerRect.origin.x, outside_top, 0);
    
	CGPathCloseSubpath(retPath);
    
    return retPath;
}

-(CGPathRef)newPathWithTopEdgeRounded:(CGRect)rect withRadius:(CGFloat)radius
{
    
    CGMutablePathRef retPath = CGPathCreateMutable();
    
	CGRect innerRect = CGRectInset(rect, radius, radius);
    
	CGFloat inside_right = innerRect.origin.x + innerRect.size.width;
	CGFloat outside_right = rect.origin.x + rect.size.width;
	CGFloat inside_bottom =  innerRect.origin.y + innerRect.size.height;
	CGFloat outside_bottom =  rect.origin.y + rect.size.height;
    
	CGFloat inside_top = innerRect.origin.y;
	CGFloat outside_top = rect.origin.y;
	CGFloat outside_left = rect.origin.x;
    
	CGPathMoveToPoint(retPath, NULL, innerRect.origin.x, outside_top);
    
	CGPathAddLineToPoint(retPath, NULL, inside_right, outside_top);
	CGPathAddArcToPoint(retPath, NULL, outside_right, outside_top, outside_right, inside_top, radius);
	CGPathAddLineToPoint(retPath, NULL, outside_right, inside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_right, outside_bottom, inside_right, outside_bottom, 0);
    
	CGPathAddLineToPoint(retPath, NULL, innerRect.origin.x, outside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_bottom, outside_left, inside_bottom, 0);
	CGPathAddLineToPoint(retPath, NULL, outside_left, inside_top);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_top, innerRect.origin.x, outside_top, radius);
    
	CGPathCloseSubpath(retPath);
    
    return retPath;
    
}



-(void)addGradientToPath:(CGPathRef)path
{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGGradientRef gradient;
    CGColorSpaceRef colorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0,1.0 };
    colorspace = CGColorSpaceCreateDeviceRGB();
    gradient = CGGradientCreateWithColorComponents (colorspace, colorComponentsVar, locations, num_locations);
    CGContextAddPath(ctx, path);
    CGContextClip(ctx);
    CGPoint endPoint = CGPointMake(0, self.bounds.size.height);
    CGContextDrawLinearGradient (ctx, gradient, CGPointMake(0, 0), endPoint , 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    
}


-(void)getColorComponentFromColor:(UIColor *)color scale:(float)scale
{
    
    [self generateTopColorComponent:color andBottomColorComponent:[self getColorFromColor:color withScale:scale]];
    
}

-(void)generateTopColorComponent:(UIColor *)topColor andBottomColorComponent:(UIColor *)bottomColor
{
    CGFloat topRed = 0.0, topGreen = 0.0, topBlue = 0.0, topAlpha =0.0;
    [topColor getRed:&topRed green:&topGreen blue:&topBlue alpha:&topAlpha];
    
    CGFloat bottomRed = 0.0, bottomGreen = 0.0, bottomBlue = 0.0, bottomAlpha =0.0;
    [bottomColor getRed:&bottomRed green:&bottomGreen blue:&bottomBlue alpha:&bottomAlpha];
    colorComponentsVar[0] = topRed;
    colorComponentsVar[1] = topGreen;
    colorComponentsVar[2] = topBlue;
    colorComponentsVar[3] = topAlpha;
    colorComponentsVar[4] = bottomRed;
    colorComponentsVar[5] = bottomGreen;
    colorComponentsVar[6] = bottomBlue;
    colorComponentsVar[7] = bottomAlpha;
    
}

-(UIColor *)getColorFromColor:(UIColor *)color withScale:(float)scale
{
    
    if (scale<-1.0)
    {
        scale = -1.0;
    }
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha =0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    [self validColorComponet:&red forscale:scale];
    [self validColorComponet:&green forscale:scale];
    [self validColorComponet:&blue forscale:scale];
    
    UIColor *resultColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return resultColor;
    
}


-(void)validColorComponet:(CGFloat *)component forscale:(float)scale
{
    if (*component + (scale * (*component))>1)
    {
        *component = 1.0;
    }
    else if (*component + (scale * (*component))<0)
    {
        *component = 0.0;
    }
    else
    {
        *component = *component + (scale* (*component));
        
    }
    
}


-(id)initWithDelegate:(id<VSDropdownDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
        [self setUpViews];
        [self updateSortedArray];
        
    }
    return self;
    
    
}


-(void)setUpViews
{
    if (self.backGroundImageView == nil)
    {
        self.backGroundImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self.backGroundImageView setBackgroundColor:[UIColor clearColor]];
        [self.backGroundImageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [self addSubview:self.backGroundImageView];
    }
    [self setBackgroundColor:[UIColor clearColor]];
    self.tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self addSubview:self.tableView];
    
}


-(void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    [self updateSortedArray];
    
}

-(void)updateSortedArray
{
    self.sortedArr = [NSMutableArray arrayWithArray:self.dataArr];
    if (self.shouldSortItems)
    {
        [self.sortedArr sortUsingComparator:^(id firstObject,id secondObject) {
            if ([firstObject respondsToSelector:@selector(caseInsensitiveCompare:)])
            {
                return [firstObject caseInsensitiveCompare:secondObject];
            }
            return NSOrderedSame;
        }];
    }
    
    
}
-(void)setupDropdownForView:(UIView *)view
{
    [self setupDropdownForView:view direction:DropdownDirection_Automatic];
    
}



-(void)setupDropdownForView:(UIView *)view direction:(Dropdown_Direction)direction
{
    
    [self setupDropdownForView:view direction:direction withTopColor:nil bottomColor:nil scale:0.2];
}


-(void)setupDropdownForView:(UIView *)view direction:(Dropdown_Direction)direction withBaseColor:(UIColor *)baseColor scale:(float)scale
{
    [self setupDropdownForView:view direction:direction withTopColor:baseColor bottomColor:nil scale:scale];
    
}


-(void)setupDropdownForView:(UIView *)view direction:(Dropdown_Direction)direction withTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor scale:(float)scale
{
    [self remove];
    [self setDirection:direction];
    [self setDropDownView:view];
    if (self.adoptParentTheme&&self.dropDownView)
    {
        [self getColorComponentFromColor:[self.dropDownView backgroundColor] scale:scale];
    }
    else if (topColor && bottomColor)
    {
        [self generateTopColorComponent:topColor andBottomColorComponent:bottomColor];
        
    }
    else if (topColor)
    {
        [self getColorComponentFromColor:topColor scale:scale];
        
    }
    else
    {
        [self getColorComponentFromColor:[UIColor colorWithRed:131.0/255.0 green:134.0/255.0 blue:134.0/255.0 alpha:1.0] scale:0.2];
        
    }

    [self performSetup];
   
    if ([self vs_prepareForAnimation])
    {
        [self vs_performAnimation];
        
    }
    else
    {
        [self vs_finishPresentingDropdown];
    
    }
    
    [self setNeedsDisplay];

}


-(void)performSetup
{
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    viewFrame = self.dropDownView.frame;
    if ([self.dropDownView isKindOfClass:[UIButton class]])
    {
        UIButton *btn = (UIButton *)self.dropDownView;
        self.font = btn.titleLabel.font;
        self.textColor = btn.titleLabel.textColor;
    }
    else
    {
        self.textColor = [UIColor blackColor];
        self.font = [UIFont systemFontOfSize:17.0];
        
    }
    UIView *superView = [self getParentViewForView:self.dropDownView];;
    [superView addSubview:self];
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [tap setDelegate:self];
    [[[UIApplication sharedApplication] keyWindow] addGestureRecognizer:tap];
    [self assignDropdownDirectionAndFrame];

}


-(BOOL)vs_prepareForAnimation
{
    BOOL animationRequired = YES;
    [self setAlpha:1];
    
    switch (self.drodownAnimation) {
        case DropdownAnimation_Fade:
            
            [self setAlpha:0];
            break;

        case DropdownAnimation_Scale:
            
            [self setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1, 0.1)];
            break;
        case DropdownAnimation_None:
            
            animationRequired = NO;
            break;
        default:
            break;
    }
    
    return animationRequired;
}


-(void)vs_performAnimation
{
    [UIView animateWithDuration:[self animationDuration] animations:^{
        [self setAlpha:1];
        [self setTransform:CGAffineTransformIdentity];
        
    } completion:^(BOOL finished){
        if (finished)
        {
            
            [self vs_finishPresentingDropdown];
            
        }
        
    }];

}

-(void)vs_finishPresentingDropdown
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropdownDidAppear:)])
    {
        
        [self.delegate dropdownDidAppear:self];
        
    }
    
    if (self.seletecdStr)
    {
        if ([self.sortedArr containsObject:self.seletecdStr])
        {
            NSUInteger index = [self.sortedArr indexOfObject:self.seletecdStr];
            if ([self.tableView numberOfRowsInSection:0]>=(index + 1))
            {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.sortedArr indexOfObject:self.seletecdStr] inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            
        }
    }

}


-(NSTimeInterval)animationDuration
{
    return kDefaultDuration;

}

-(UIView *)getParentViewForView:(UIView *)childView
{
    UIView *parent = childView;
    while ([parent superview] && [[parent superview] isKindOfClass:[UIWindow class]] == NO)
    {
        parent = [parent superview];
    }
    return parent;
    
}
-(void)assignDropdownDirectionAndFrame
{
    CGFloat height = self.dropdownHeight == 0 ? kDefaultHeight:self.dropdownHeight;
    CGRect frame = CGRectZero;
    if (self.direction == DropdownDirection_Down)
    {
        [self setAssignedDirection:DropdownDirection_Down];
        frame = CGRectMake(viewFrame.origin.x, viewFrame.origin.y+viewFrame.size.height-1.0, viewFrame.size.width, height);
        topEdgeRounded = NO;
    }
    else if (self.direction == DropdownDirection_Up)
    {
        [self setAssignedDirection:DropdownDirection_Up];
        
        frame = CGRectMake(viewFrame.origin.x, viewFrame.origin.y-self.frame.size.height+1.0, viewFrame.size.width, height);
        topEdgeRounded = YES;
        
    }
    else
    {
        CGRect referenceFrame = [self.superview convertRect:viewFrame fromView:[self.dropDownView superview]];
        if (referenceFrame.origin.y+referenceFrame.size.height+self.bounds.size.height < ([UIScreen mainScreen].bounds.size.height))
        {
            frame = CGRectMake(viewFrame.origin.x, viewFrame.origin.y+viewFrame.size.height-1.0, viewFrame.size.width, height);
            [self setDirection:DropdownDirection_Automatic];
            [self setAssignedDirection:DropdownDirection_Down];
            topEdgeRounded = NO;
            
        }
        else
        {
            frame = CGRectMake(viewFrame.origin.x, viewFrame.origin.y-self.frame.size.height+1.0, viewFrame.size.width, height);
            [self setDirection:DropdownDirection_Automatic];
            [self setAssignedDirection:DropdownDirection_Up];
            topEdgeRounded = YES;
        }
        
    }
    
    frame = [self.superview convertRect:frame fromView:[self.dropDownView superview]];
    
    [self setFrame:frame];
    
}
- (void)setAssignedDirection:(Dropdown_Direction)assignedDirection
{
    _assignedDirection = assignedDirection;
    
    [self vs_configureAnchorPoint];

}

-(void)vs_configureAnchorPoint
{
    if (self.drodownAnimation == DropdownAnimation_Scale)
    {
        if (self.assignedDirection == DropdownDirection_Down)
        {
            [self.layer setAnchorPoint:CGPointMake(0, 0)];
            
        }
        else if (self.assignedDirection == DropdownDirection_Up)
        {
            
            [self.layer setAnchorPoint:CGPointMake(1, 1)];
            
        }
    }
    else
    {
    
        [self.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
    }

}


-(void)handleTap:(UITapGestureRecognizer *)recoz
{
    [self remove];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (CGRectContainsPoint(self.frame, [touch locationInView:gestureRecognizer.view]))
    {
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark - UITableView Delegate/Data Source methods.

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = 44.0;
    NSString* value = [self.sortedArr objectAtIndex:indexPath.row];
    
    NSDictionary *attributes = @{NSFontAttributeName: self.font};
    CGRect cellRect = [value boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width-60.0,0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    if (cellRect.size.height > height)
    {
        height = cellRect.size.height + 5.0;
    }
    return height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sortedArr count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dropDownCellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dropDownCellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        
    }
    [self configureCell:cell atIndex:indexPath.row];
    return cell;
    
}


-(void)configureCell:(UITableViewCell *)cell atIndex:(NSUInteger)index
{
    cell.textLabel.font = self.font;
    NSString *stringAtIndexPath  = nil;
    if ([self.sortedArr[index] isKindOfClass:[NSString class]])
    {
        stringAtIndexPath  = [self.sortedArr objectAtIndex:index];
    }
    
    cell.textLabel.text = stringAtIndexPath;
    if (self.seletecdStr && [self.seletecdStr isEqualToString:stringAtIndexPath])
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else
    {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        
    }
    
    if ([self.disabledArray containsObject:stringAtIndexPath])
    {
        [cell.textLabel setTextColor:[UIColor grayColor]];
        [cell setUserInteractionEnabled:NO];
    }
    else
    {
        [cell.textLabel setTextColor:self.textColor];
        [cell setUserInteractionEnabled:YES];
        
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setSeletecdStr:[self.sortedArr objectAtIndex:indexPath.row]];
    [tableView reloadData];
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropdown:didSelectValue: atIndex:)])
    {
        [self.delegate dropdown:self didSelectValue:self.seletecdStr atIndex:[self.dataArr indexOfObject:self.seletecdStr]];
    }
    
    [self remove];
    
}

-(void)reloadDropdownWithContents:(NSArray *)contents keyPath:(NSString *)keyPath selectedString:(NSString *)selectedItem
{
    NSArray *keyValues = nil;
    if (contents && [contents count]>0)
    {
        if ([contents[0] respondsToSelector:NSSelectorFromString(keyPath)])
        {
            keyValues = [contents valueForKeyPath:keyPath];
        }
        
    }
    
    [self reloadDropdownWithContents:keyValues andSelectedString:selectedItem];
}


-(void)reloadDropdownWithContents:(NSArray *)contents
{
    [self reloadDropdownWithContents:contents andSelectedString:nil];
    
    
}


-(void)reloadDropdownWithContents:(NSArray *)contents andSelectedString:(NSString *)selectedString
{
    if (self.dropDownView)
    {
        [self setDataArr:contents];
        
        [self setSeletecdStr:selectedString];
        
        [self.tableView reloadData];
        
        [self setNeedsDisplay];
    }
    else
    {
        NSLog(@"It seems like the drodown has not been setup for any view yet. Please setup dropdown for view before reloading dropdown contents.");
    }
    
}


-(void)remove
{
    [self.layer removeAllAnimations];
    if([[[[UIApplication sharedApplication] keyWindow]gestureRecognizers] containsObject:tap])
    {
        [[[UIApplication sharedApplication] keyWindow]removeGestureRecognizer:tap];
    }
    UIView *superview = [self superview];
    if (superview)
    {
        
        if (self.dataArr && [self.dataArr count]>0)
        {
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
        }
        
        [self removeFromSuperview];
        if (self.delegate && [self.delegate respondsToSelector:@selector(dropdownDidDisappear:)])
        {
            [self.delegate dropdownDidDisappear:self];
        }
    }
    
}


-(void)cleanup
{
    [tap setDelegate:nil];
    [self.tableView setDelegate:nil];
    [self.tableView setDataSource:nil];
    
}

-(void)dealloc
{
    [self cleanup];
}

@end
