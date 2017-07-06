//
//  ProgressViewController.m
//  WeightLoss
//
//  Created by Dev on 6/3/17.
//  Copyright © 2017 Dev. All rights reserved.
//

#import "ProgressViewController.h"

@interface ProgressViewController ()
{
    UIView *firstDotView;
}
@end

@implementation ProgressViewController
@synthesize ref;
@synthesize arrData;
@synthesize lineChartView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arrData = [[NSMutableArray alloc] init];
    
    lineChartView = [[JBLineChartView alloc] init];
    lineChartView.dataSource = self;
    lineChartView.delegate = self;
    [self.view addSubview:lineChartView];
    
    [self.view bringSubviewToFront:self.navView];
        
    firstDotView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 6)];
    [firstDotView setBackgroundColor:[UIColor whiteColor]];
    firstDotView.layer.cornerRadius = 3;
    [self.view addSubview:firstDotView];
    [firstDotView setHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self drawGraphBackground];
}


- (IBAction)onBack:(id)sender {
    self.view.tag = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) drawGraphBackground
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect rect = CGRectMake(0, 0, screenSize.width, screenSize.height);
    
    float bottomY = screenSize.height * 325 / 375.0f;
    
    
    UIGraphicsBeginImageContext(screenSize);
    
    //draw the entire image in the specified rectangle frame
    [self.graph_bg.image drawInRect:rect];
    
    
    //set line cap, width, stroke color and begin path
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 0.1f);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 151/255.0f, 151/255.0f, 151/255.0f, 0.5f);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    //begin a new new subpath at this point
    float spacingH = bottomY / 10;
    for (int i = 0; i < 10; i++) {
        
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 25, bottomY - i * spacingH);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), screenSize.width, bottomY - i * spacingH);
        
        NSString *strWeight = [NSString stringWithFormat:@"%d", i * 20];
        
        [self addText:strWeight withPoint:CGPointMake(12, bottomY - i * spacingH - 8) fontSize:11];
    }
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 25, bottomY);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), screenSize.width, bottomY);
    
    NSInteger totalcount = arrData.count;
    if (totalcount > 30) totalcount = 30;
    
    NSInteger maxIndex = 29;
    if (self.arrData.count < 30)
        maxIndex = self.arrData.count - 1;
    
    totalcount = 30;
    maxIndex = 29;
    
    float spacing = (screenSize.width-25) / 30;
    for (int i = 0; i < totalcount; i++) {
        
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 25 + spacing * i, 5);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 25 + spacing * i, bottomY);
        
        NSString *strDay = [NSString stringWithFormat:@"%d", i+1];
        
        [self addText:strDay withPoint:CGPointMake(25 + spacing * i, bottomY + 8) fontSize:11];
        
    }
    
    //paint a line along the current path
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    CGContextFlush(UIGraphicsGetCurrentContext());
    
    //set the image based on the contents of the current bitmap-based graphics context
    self.graph_bg.image = UIGraphicsGetImageFromCurrentImageContext();
    
    //remove the current bitmap-based graphics context from the top of the stack
    UIGraphicsEndImageContext();
    
    
    FIRUser *user = [[FIRAuth auth] currentUser];
    ref = [[[FIRDatabase database] reference] child:[NSString stringWithFormat:@"users/%@", user.uid]];
    
    [[ref child:@"data"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        if (snapshot.value == [NSNull null]) {
            NSLog(@"No data");
            
        } else {
            arrData = snapshot.value;
            
            CGRect chartRect = CGRectMake(25, 0, spacing * (arrData.count-1), screenSize.height * 325 / 375.0f);
            lineChartView.frame = chartRect;
            [lineChartView setBackgroundColor:[UIColor clearColor]];
            
            [lineChartView setMinimumValue:0];
            [lineChartView setMaximumValue:200];
            
            [self.lineChartView reloadData];
            
            if (arrData.count == 1) {
                NSDictionary *dicData = arrData[0];
                float yValue = 0;
                yValue = [[dicData valueForKey:@"weight"] floatValue];
                
                float y = lineChartView.frame.size.height * (200-yValue) / 200.0f;
            
                [firstDotView setFrame:CGRectMake(25, y-3, 6, 6)];
                [firstDotView setHidden:NO];
                
            }
            
            
            
        }
    }];
    
}

- (void)addText:(NSString*)text withPoint:(CGPoint)point fontSize:(CGFloat)fontSize
{
    UIFont *font = [UIFont fontWithName:@"OpenSans-Semibold" size:fontSize];
    
    CGRect renderingRect = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];
    
    renderingRect = CGRectMake(point.x - renderingRect.size.width / 2.0f, point.y, renderingRect.size.width, renderingRect.size.height);
    
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentLeft;
    NSDictionary *textAttributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style, NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    [text drawInRect:renderingRect withAttributes:textAttributes];
    
}



#pragma mark - JBLineChartView datasource
- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView
{
    return 1;
}


- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    if (arrData.count < 30)
        return arrData.count;
    return 30;
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    NSDictionary *dicData = arrData[horizontalIndex];
    
    float yValue = 0;
    yValue = [[dicData valueForKey:@"weight"] floatValue];
    
    return yValue;
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [UIColor colorWithRed:122/255.0f green:218/255.0f blue:1 alpha:1];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView fillColorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [UIColor clearColor]; // color of area under line in chart
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex
{
    return 2; // width of line in chart
}

- (JBLineChartViewLineStyle)lineChartView:(JBLineChartView *)lineChartView lineStyleForLineAtLineIndex:(NSUInteger)lineIndex
{
    return JBLineChartViewLineStyleSolid; // style of line in chart (solid or dashed)
}


- (JBLineChartViewColorStyle)lineChartView:(JBLineChartView *)lineChartView colorStyleForLineAtLineIndex:(NSUInteger)lineIndex
{
    return JBLineChartViewColorStyleSolid; // color line style of a line in the chart
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView showsDotsForLineAtLineIndex:(NSUInteger)lineIndex
{
    return YES;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex
{
    return NO;
}

#pragma mark - JBLineChartView Delegate
- (JBLineChartViewColorStyle)lineChartView:(JBLineChartView *)lineChartView fillColorStyleForLineAtLineIndex:(NSUInteger)lineIndex
{
    return JBLineChartViewColorStyleSolid; // color style for the area under a line in the chart
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView dotRadiusForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    return 3;
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    return [UIColor whiteColor];
}


- (void)lineChartView:(JBLineChartView *)lineChartView didSelectLineAtIndex:(NSUInteger)lineIndex horizontalIndex:(NSUInteger)horizontalIndex touchPoint:(CGPoint)touchPoint
{
    NSDictionary *dicData = arrData[horizontalIndex];
    
    NSString *date = [dicData valueForKey:@"date"];
    NSString *weight = [dicData valueForKey:@"weight"];
    NSString *strTitle = [NSString stringWithFormat:@"%@ - %@Kg", date, weight];
    
    self.lblTitle.text = strTitle;
}

- (void)didDeselectLineInLineChartView:(JBLineChartView *)lineChartView
{
    self.lblTitle.text = @"Progress";
}



@end
