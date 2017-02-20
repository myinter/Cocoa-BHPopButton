//
//  CustomeBottomView.h
//  Layover
//
//  Created by ios on 11/23/16.
//  Copyright © 2016 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BHPopButton;

typedef void(^EventBlock)(BHPopButton *view);

typedef void(^ItemSelectedBlock)(BHPopButton *view,NSUInteger index,NSString *itemContent);

@interface BHPopButton : UIButton
{
  
    BOOL pressed;
  
    EventBlock longPressBlock;
    
    EventBlock clickBlock;
    
    ItemSelectedBlock selectBlock;
  
    NSDate *lastClickDate;
    
    UIView *_popView;
  
}

/*设置长按操作被触发后调用的Block*/
- (void)setOnLongPressBlock:(void (^)(BHPopButton *view))block;
/*设置用户弹起手势后调用的Block*/
- (void)setOnSubItemSelected:(void (^)(BHPopButton *view,NSUInteger index,NSString *itemContent))block;
/*设置用户弹单击后调用的Block*/
- (void)setOnClickBlock:(void (^)(BHPopButton *view))block;
/*次级选项的文本数组*/
@property (nonatomic,strong) NSArray *optionsArray;
/*长按触发子菜单弹出所需要的时间间隔*/
@property (nonatomic) NSTimeInterval longPressTimeInterval;
/*次级选项的文本字体*/
@property (nonatomic,strong) UIFont *fontForOptions;

@end
