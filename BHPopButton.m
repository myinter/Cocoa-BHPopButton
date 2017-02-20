//
//  CustomeBottomView.m
//  Layover
//
//  Created by ios on 11/23/16.
//  Copyright © 2016 ios. All rights reserved.
//

#import "BHPopButton.h"
#import "BHPopView.h"

@implementation BHPopButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setOnClickBlock:(void (^)(BHPopButton *view))block
{
  clickBlock = block;
}

- (void)setOnLongPressBlock:(void (^)(BHPopButton *view))block
{

  longPressBlock = block;
  
}

- (void)setOnSubItemSelected:(void (^)(BHPopButton *, NSUInteger, NSString *))block
{
    
  selectBlock = block;
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
 
  [super touchesEnded:touches withEvent:event];
   
 [_popView touchesEnded:touches  withEvent:event];

 if (lastClickDate && fabs([lastClickDate timeIntervalSinceNow]) < 0.3) {
    
  if (clickBlock) {
      
   clickBlock(self);
      
  }
    
 }
 
 if (_popView) {
     
  [_popView removeFromSuperview];
     
  _popView = nil;
     
 }

  lastClickDate = nil;
 
  pressed = NO;
 
  self.alpha = 1.0f;
  
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [super touchesMoved:touches withEvent:event];
 
  [_popView touchesMoved:touches withEvent:event];
  
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [super touchesBegan:touches withEvent:event];
 
  pressed = YES;
  
 lastClickDate = [NSDate date];
 
 self.alpha = 0.7;
 
 __weak NSDate *theLastClickDate = lastClickDate;
    
    if (_longPressTimeInterval < 0.3) {
        
        _longPressTimeInterval = 0.3;
        
    }
 
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_longPressTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
   
    if (theLastClickDate && fabs([theLastClickDate timeIntervalSinceNow]) >= _longPressTimeInterval && pressed) {
        
        if (_optionsArray) {
            
            [self showSubOptionView];
            
        }
        
        if (longPressBlock) {
            
            longPressBlock(self);
            
        }
     
    }
    
  });

}

//将次级选项的视图显示出来。
-(void)showSubOptionView
{
    
    BHPopView *Aview = [[BHPopView alloc]initWithFrame:CGRectMake(100, 90, 100, 50)];
    
    Aview.chars = _optionsArray;
    
    Aview.fontForOptions = _fontForOptions;
    
    Aview.backgroundColor = [UIColor clearColor];
    
    [Aview sizeToFit];
    
    _popView = Aview;
    
    [Aview sizeToFit];
    
    [Aview setUpInsideBlock:^(BHPopView *view,UILabel *labelSelected) {
        
        if (selectBlock && labelSelected) {
            
            selectBlock(self,labelSelected.tag,labelSelected.text);
            
        }
        
    }];
    
    [self.superview addSubview:Aview];
    
    Aview.center = self.center;

    
    if (Aview.frame.origin.y < 10) {
        
        Aview.frame = CGRectMake(Aview.frame.origin.x, 10, Aview.frame.size.width, Aview.frame.size.height);
        
    }
    
    if (Aview.frame.origin.x < 10) {
        
        Aview.frame = CGRectMake(10, Aview.frame.origin.y, Aview.frame.size.width, Aview.frame.size.height);
        
    }
    
    if (Aview.frame.origin.x + Aview.frame.size.width > self.superview.frame.size.width) {
        
        Aview.frame = CGRectMake(self.superview.frame.size.width - Aview.frame.size.width - 10.0f, Aview.frame.origin.y, Aview.frame.size.width, Aview.frame.size.height);
        
    }

}

@end
