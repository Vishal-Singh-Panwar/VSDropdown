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
static const CGFloat kTableOffset = 5.0;
static const CGFloat kDropdownOffset = 0.0;

static const NSTimeInterval kDefaultDuration = 0.25;


@interface VSDropdown ()
{
    BOOL topEdgeRounded;
    CGRect viewFrame;
    CGFloat colorComponentsVar[8];
    CGFloat dropdownHeight;
    
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSMutableArray *sortedArr;
@property(nonatomic,strong)NSArray *selectedItems;
@property(nonatomic,strong)UIImageView *backGroundImageView;
@property(nonatomic,strong)UIFont *font;
@property(nonatomic,strong)NSMutableArray *disabledArray;
@property(nonatomic,weak)UIView *dropDownView;
@property(nonatomic,assign)VSDropdown_Direction assignedDirection;

@end

@implementation VSDropdownItem



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
    
    const CGFloat outlineStrokeWidth = [self outlineWidth];
    
    const CGColorRef outlineColor = [[self outlineColor] CGColor];
    const CGColorRef clearColor = [[UIColor clearColor] CGColor];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, clearColor);
    
    CGContextFillRect(context, rect);
    
    CGRect insetRect = CGRectInset(rect, outlineStrokeWidth/2.0f, outlineStrokeWidth/2.0f);
    
    CGPathRef path = topEdgeRounded?[self newPathWithTopEdgeRounded:insetRect withRadius:[self cornerRadius]]:[self newPathWithBottomEdgeRounded:insetRect withRadius:[self cornerRadius]];
    CGContextAddPath(context, path);
    
    CGContextSetStrokeColorWithColor(context, outlineColor);
    CGContextSetLineWidth(context, outlineStrokeWidth);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    [self addGradientToPath:path];
    
    //CGContextClip(context);
    
    CGPathRelease(path);
    
    
    
}


-(CGFloat)cornerRadius
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cornerRadiusForDropdown:)])
    {
        return [self.delegate cornerRadiusForDropdown:self];
    }
    
    return 0.0;
    
}

-(CGFloat)outlineWidth
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(outlineWidthForDropdown:)])
    {
        return [self.delegate outlineWidthForDropdown:self];
    }
    
    return 0.0;
    
}

-(UIColor *)outlineColor
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(outlineColorForDropdown:)])
    {
        return [self.delegate outlineColorForDropdown:self];
    }
    
    return [UIColor clearColor];
}


-(CGPathRef)newPathWithBottomEdgeRounded:(CGRect)rect withRadius:(CGFloat)radius
{
    CGMutablePathRef retPath = CGPathCreateMutable();
    
    CGRect innerRect = CGRectInset(rect, radius, radius);
    
    if (innerRect.origin.x == INFINITY || innerRect.origin.y == INFINITY)
    {
        innerRect = CGRectZero;
    }
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
    
    if (innerRect.origin.x == INFINITY || innerRect.origin.y == INFINITY)
    {
        innerRect = CGRectZero;
    }
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
    CGFloat components[8];
    
    
    
    if (self.assignedDirection == VSDropdownDirection_Up)
    {
        components[0] = colorComponentsVar[4];
        components[1] = colorComponentsVar[5];
        components[2] = colorComponentsVar[6];
        components[3] = colorComponentsVar[7];
        components[4] = colorComponentsVar[0];
        components[5] = colorComponentsVar[1];
        components[6] = colorComponentsVar[2];
        components[7] = colorComponentsVar[3];
        
    }
    else
    {
        int numItems = sizeof(colorComponentsVar)/sizeof(CGFloat);
        memcpy(components, colorComponentsVar, sizeof(colorComponentsVar[0]) * numItems);
        
    }
    gradient = CGGradientCreateWithColorComponents (colorspace, components, locations, num_locations);
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

- (instancetype)init
{
    return [self initWithDelegate:nil];
    
}

-(instancetype)initWithDelegate:(id<VSDropdownDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
        _shouldSortItems = YES;
        [self setUpViews];
        [self updateSortedArray];
        [self didPerformSetup];
        
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
    [self.tableView setSeparatorColor:self.separatorColor];
    [self.tableView setSeparatorStyle:self.separatorType];
    [self addSubview:self.tableView];
    
}

-(void)setSeparatorColor:(UIColor *)sepratorColor
{
    _separatorColor = sepratorColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setSeparatorColor:sepratorColor];
}

- (void)setSeparatorType:(UITableViewCellSeparatorStyle)separatorType
{
    _separatorType = separatorType;
    [self.tableView setSeparatorStyle:separatorType];
}

-(void)didPerformSetup
{
    
    
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
        [self.sortedArr sortUsingComparator:^(VSDropdownItem *firstObject,VSDropdownItem *secondObject) {
            if ([firstObject.itemValue respondsToSelector:@selector(caseInsensitiveCompare:)])
            {
                return [firstObject.itemValue caseInsensitiveCompare:secondObject.itemValue];
            }
            return NSOrderedSame;
        }];
    }
    
    
}
-(void)setupDropdownForView:(UIView *)view
{
    [self setupDropdownForView:view direction:VSDropdownDirection_Automatic];
    
}



-(void)setupDropdownForView:(UIView *)view direction:(VSDropdown_Direction)direction
{
    
    [self setupDropdownForView:view direction:direction withTopColor:nil bottomColor:nil scale:0.2];
}


-(void)setupDropdownForView:(UIView *)view direction:(VSDropdown_Direction)direction withBaseColor:(UIColor *)baseColor scale:(float)scale
{
    [self setupDropdownForView:view direction:direction withTopColor:baseColor bottomColor:nil scale:scale];
    
}


-(void)setupDropdownForView:(UIView *)view direction:(VSDropdown_Direction)direction withTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor scale:(float)scale
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
        //[self getColorComponentFromColor:[UIColor colorWithRed:131.0/255.0 green:134.0/255.0 blue:134.0/255.0 alpha:1.0] scale:0.2];
        
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
    [self.tableView setAllowsMultipleSelection:self.allowMultipleSelection];
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
    //[self assignDropdownDirectionAndFrame];
    
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
    
    if (self.selectedItems && self.selectedItems.count >0)
    {
        NSString *firstItem = [self.selectedItems firstObject];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemValue = %@",firstItem];
        NSArray *filtered = [self.sortedArr filteredArrayUsingPredicate:predicate];
        
        if (filtered.count > 0)
        {
            NSUInteger index = [self.sortedArr indexOfObject:[filtered firstObject]];
            if ([self.tableView numberOfRowsInSection:0]>=(index + 1))
            {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self assignDropdownDirectionAndFrame];
}

-(void)assignDropdownDirectionAndFrame
{
    CGFloat height = self.maxDropdownHeight == 0 ? kDefaultHeight:self.maxDropdownHeight;
    
    
    if (self.tableView.contentSize.height<height + kTableOffset)
    {
        height = self.tableView.contentSize.height + kTableOffset;
    }
    
    
    dropdownHeight = height;
    
    if (self.direction == VSDropdownDirection_Down)
    {
        [self setAssignedDirection:VSDropdownDirection_Down];
        
    }
    else if (self.direction == VSDropdownDirection_Up)
    {
        [self setAssignedDirection:VSDropdownDirection_Up];
        
    }
    else
    {
        CGRect referenceFrame = [self.superview convertRect:viewFrame fromView:[self.dropDownView superview]];
        
        CGFloat totalHeight = referenceFrame.origin.y+referenceFrame.size.height+height;
        
        UIInterfaceOrientation appOrientation = [UIApplication sharedApplication].statusBarOrientation;
        
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1 == NO)
        {
            if (appOrientation == UIInterfaceOrientationLandscapeLeft || appOrientation == UIInterfaceOrientationLandscapeRight)
            {
                screenHeight = [UIScreen mainScreen].bounds.size.width;
            }
        }
        
        if (totalHeight < screenHeight)
        {
            [self setDirection:VSDropdownDirection_Automatic];
            [self setAssignedDirection:VSDropdownDirection_Down];
            
        }
        else
        {
            [self setDirection:VSDropdownDirection_Automatic];
            [self setAssignedDirection:VSDropdownDirection_Up];
        }
        
    }
    
    [self updateFrame];
    
    if (self.bounds.size.height > [self outlineWidth])
    {
        [self.tableView setFrame:CGRectInset(self.bounds, [self outlineWidth], [self outlineWidth])];
        
    }
    
}

-(void)updateFrame
{
    BOOL  topRounded = topEdgeRounded;
    CGRect frame = CGRectZero;
    
    viewFrame = self.dropDownView.frame;
    
    CGFloat dropdownOffset = kDropdownOffset;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(offsetForDropdown:)])
    {
        dropdownOffset = [self.delegate offsetForDropdown:self];
    }
    
    if (self.assignedDirection == VSDropdownDirection_Down)
    {
        frame = CGRectMake(viewFrame.origin.x, viewFrame.origin.y+viewFrame.size.height+dropdownOffset, viewFrame.size.width, dropdownHeight);
        topEdgeRounded = NO;
    }
    else
    {
        frame = CGRectMake(viewFrame.origin.x, viewFrame.origin.y-dropdownHeight-dropdownOffset, viewFrame.size.width, dropdownHeight);
        topEdgeRounded = YES;
        
    }
    
    frame = [self.superview convertRect:frame fromView:[self.dropDownView superview]];
    
    [self setFrame:frame];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropdown:didSetFrame:)])
    {
        [self.delegate dropdown:self didSetFrame:frame];
    }
    
    if (topEdgeRounded != topRounded)
    {
        [self setNeedsDisplay];
    }
}


- (void)setAssignedDirection:(VSDropdown_Direction)assignedDirection
{
    _assignedDirection = assignedDirection;
    [self vs_configureAnchorPoint];
    
}

-(void)vs_configureAnchorPoint
{
    if (self.drodownAnimation == DropdownAnimation_Scale)
    {
        if (self.assignedDirection == VSDropdownDirection_Down)
        {
            [self.layer setAnchorPoint:CGPointMake(0, 0)];
            
        }
        else if (self.assignedDirection == VSDropdownDirection_Up)
        {
            
            [self.layer setAnchorPoint:CGPointMake(1, 1)];
            
        }
    }
    else
    {
        
        [self.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
    }
    
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    
    BOOL inside = [super pointInside:point withEvent:event];
    
    if (inside == NO && self.controlRemovalManually == NO)
    {
        [self remove];
        
    }
    
    return inside;
    
}

#pragma mark -
#pragma mark - UITableView Delegate/Data Source methods.

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = 44.0;
    VSDropdownItem *ddItem = [self.sortedArr objectAtIndex:indexPath.row];
    
    NSString* value = ddItem.itemValue;
    
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
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
    
}


-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.font = self.font;
    NSString *stringAtIndexPath  = nil;
    NSUInteger index = indexPath.row;
    if ([self.sortedArr[index] isKindOfClass:[VSDropdownItem class]])
    {
        VSDropdownItem *ddItem = self.sortedArr[index];
        
        stringAtIndexPath  = ddItem.itemValue;
    }
    
    cell.textLabel.text = stringAtIndexPath;
    
    if (self.selectedItems.count > 0 && [self.selectedItems containsObject:stringAtIndexPath])
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }
    else
    {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelected:NO];
        
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
    VSDropdownItem *ddi = [self.sortedArr objectAtIndex:indexPath.row];
    
    if (self.allowMultipleSelection)
    {
        NSMutableArray *allSelectedItems = [NSMutableArray arrayWithArray:self.selectedItems];
        
        if ([allSelectedItems containsObject:ddi.itemValue] == NO)
        {
            [allSelectedItems addObject:ddi.itemValue];
            
        }
        
        [self setSelectedItems:[NSArray arrayWithArray:allSelectedItems]];
        
        [tableView reloadData];
    }
    else
    {
        [self setSelectedItems:@[ddi.itemValue]];
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropdown:didChangeSelectionForValue:atIndex:selected:)])
    {
        [self.delegate dropdown:self didChangeSelectionForValue:ddi.itemValue atIndex:[self.dataArr indexOfObject:ddi] selected:YES];
    }
    
    if (self.allowMultipleSelection == NO)
    {
        [self remove];
        
    }
    
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.allowMultipleSelection)
    {
        VSDropdownItem *ddi = [self.sortedArr objectAtIndex:indexPath.row];
        
        NSMutableArray *allSelectedItems = [NSMutableArray arrayWithArray:self.selectedItems];
        
        [allSelectedItems removeObject:ddi.itemValue];
        
        [self setSelectedItems:[NSArray arrayWithArray:allSelectedItems]];
        
        [tableView reloadData];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(dropdown:didChangeSelectionForValue:atIndex:selected:)])
        {
            [self.delegate dropdown:self didChangeSelectionForValue:ddi.itemValue atIndex:[self.dataArr indexOfObject:ddi] selected:NO];
        }
        
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
    
}

-(void)reloadDropdownWithContents:(NSArray *)contents keyPath:(NSString *)keyPath selectedItems:(NSArray *)selectedItems
{
    [self reloadDropdownWithContents:contents keyPath:keyPath selectedItems:selectedItems imageKey:nil];
}



-(void)reloadDropdownWithContents:(NSArray *)contents keyPath:(NSString *)keyPath selectedItems:(NSArray *)selectedItems imageKey:(NSString *)imageKey
{
    NSArray *keyValues = nil;
    
    NSArray *imageValues = nil;
    if (contents && [contents count]>0)
    {
        if(keyPath == nil)
        {
            keyValues = contents;
        }
        else
        {
            if ([contents[0] respondsToSelector:NSSelectorFromString(keyPath)])
            {
                keyValues = [contents valueForKeyPath:keyPath];
            }
        }
        
        if(imageKey != nil)
        {
            if ([contents[0] respondsToSelector:NSSelectorFromString(imageKey)])
            {
                imageValues = [contents valueForKeyPath:imageKey];
            }
        }
        
    }
    
    
    
    [self reloadDropdownWithContents:keyValues imageNames:imageValues selectedItems:selectedItems];
}



-(void)reloadDropdownWithContents:(NSArray *)contents
{
    [self reloadDropdownWithContents:contents andSelectedItems:nil];
    
    
}


-(void)reloadDropdownWithContents:(NSArray *)contents andSelectedItems:(NSArray *)selectedItems
{
    [self reloadDropdownWithContents:contents imageNames:nil selectedItems:selectedItems];
    
}

-(void)reloadDropdownWithContents:(NSArray *)contents imageNames:(NSArray *)imageNames selectedItems:(NSArray *)selectedItems
{
    
    if (self.dropDownView)
    {
        [self setDataArr:[self dropdownItmesWithContents:contents images:imageNames]];
        
        [self setSelectedItems:selectedItems];
        
        [self.tableView reloadData];
        
        [self setNeedsLayout];
        
        [self setNeedsDisplay];
    }
    else
    {
        NSLog(@"It seems like the drodown has not been setup for any view yet. Please setup dropdown for view before reloading dropdown contents.");
    }
    
}


-(NSArray *)dropdownItmesWithContents:(NSArray *)contents images:(NSArray *)images
{
    NSMutableArray *ddItems = [[NSMutableArray alloc]init];
    
    for (int i = 0; i <  contents.count; i++)
    {
        VSDropdownItem *ddItem = [[VSDropdownItem alloc]init];
        [ddItem setItemValue:contents[i]];
        if (images && images.count > i)
        {
            [ddItem setItemImage:images[i]];
        }
        [ddItems addObject:ddItem];
    }
    return [NSArray arrayWithArray:ddItems];
    
}

-(void)remove
{
    [self.layer removeAllAnimations];
    
    UIView *superview = [self superview];
    if (superview)
    {
        
        if (self.dataArr && [self.dataArr count]>0)
        {
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
        }
        
        [self removeFromSuperview];
        
    }
    
}

- (void)removeFromSuperview
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropdownWillDisappear:)])
    {
        [self.delegate dropdownWillDisappear:self];
    }
    
    [super removeFromSuperview];
    
}


-(void)cleanup
{
    [_tableView setDelegate:nil];
    [_tableView setDataSource:nil];
    
}

-(void)dealloc
{
    [self cleanup];
}

@end
