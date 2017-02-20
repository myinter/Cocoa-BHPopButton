//
//  CustomeView.m
//  Layover
//
//  Created by ios on 11/23/16.
//  Copyright © 2016 ios. All rights reserved.
//

#import "BHPopView.h"

@implementation BHPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setChars:(NSArray *)chars
{
    if (_charLabels) {
        
        for (UIView *view in _charLabels) {
            
            [view removeFromSuperview];
            
        }
        
    }
    else
    {
        
        _charLabels = [NSMutableArray arrayWithCapacity:chars.count];

    }
    
    [_charLabels removeAllObjects];
    
    [chars enumerateObjectsUsingBlock:^(NSString   * _Nonnull string, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *label = [UILabel new];
        
        if (_fontForOptions) {
            
            label.font = _fontForOptions;
            
        }
        else
        {
            
            label.font = [UIFont fontWithName:@"Arial" size:20.0f];
            
        }
        
        label.text = string;
        
        label.tag = idx;
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [label sizeToFit];
        
        label.layer.cornerRadius = 3.0f;
        
        label.clipsToBounds = YES;
        
        label.bounds = CGRectMake(0.0f, 0.0f, label.frame.size.width + 4.0F, label.frame.size.height + 5.0f);
        
        [_charLabels addObject:label];

    }];
    
}

#define X_GAP 4.0f
#define Y_GAP 15.0f

-(void)sizeToFit
{
    //将文本label布局到界面上
    
    CGFloat x_off_set = X_GAP;
    
    if (labelView == nil) {
        
        labelView = [UIView new];
        
        labelView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        labelView.layer.cornerRadius = 5.0f;
        
        labelView.layer.borderWidth = 0.5f;
        
        labelView.layer.borderColor = [UIColor lightGrayColor].CGColor;
     
        [self addSubview:labelView];
    }
    
    for (UILabel *label in _charLabels) {
        
        label.frame = CGRectMake(x_off_set, X_GAP, label.frame.size.width, label.frame.size.height);
        
        [self addSubview:label];
        
        x_off_set += label.frame.size.width + X_GAP;
    }
    
    CGPoint centerPoint = self.center;
    
    self.bounds = CGRectMake(0.0f, 0.0f, x_off_set , 120.0f);
    
    labelView.frame = CGRectMake(0.0f, 0.0f, x_off_set, _charLabels[0].frame.size.height + _charLabels[0].frame.origin.y + X_GAP);
    
    self.center = centerPoint;
}

-(void)setUpInsideBlock:(void (^)(BHPopView *view,UILabel *labelSelected))block
{
    _touchUpBlock = block;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [super touchesBegan:touches withEvent:event];
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [super touchesMoved:touches withEvent:event];
  
    CGPoint point = [[event.allTouches anyObject]locationInView:self];
    
    CGFloat x_off_set = MAX(0.0, MIN(self.bounds.size.width, point.x));
    
    labelSelected = nil;
    
    for (UILabel *label in _charLabels) {
        
        if (label.frame.origin.x < x_off_set && ((label.frame.origin.x + label.frame.size.width + X_GAP) > x_off_set)) {
            
            label.backgroundColor = [UIColor colorWithRed:5.0/255.0f green:157.0f/255.0f blue:254.0f/255.0f alpha:1.0f];
            
            labelSelected = label;
            
        }
        else
        {
            label.backgroundColor = [UIColor clearColor];
        }
        
    }
    
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
  return self;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [super touchesEnded:touches withEvent:event];
    
    if (_touchUpBlock) {
        
        _touchUpBlock(self,labelSelected);
        
    }

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    [self removeFromSuperview];

  });
}
@end
