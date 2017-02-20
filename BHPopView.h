//
//  CustomeView.h
//  Layover
//
//  Created by ios on 11/23/16.
//  Copyright © 2016 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BHPopView;
typedef void(^touchUpBlock)(BHPopView *view,UILabel *labelSelected);
@interface BHPopView : UIView
{
    
    touchUpBlock _touchUpBlock;

    NSMutableArray<UILabel *> *_charLabels;
    
    UILabel *labelSelected;
    
    UIView *labelView;
}

@property (nonatomic,strong) NSArray *chars;

@property (nonatomic,strong) UIFont *fontForOptions;

-(void)setUpInsideBlock:(void (^)(BHPopView *view,UILabel *labelSelected))block;

@end
