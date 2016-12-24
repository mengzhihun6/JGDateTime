//
//  JGPicker.h
//  JGPicker
//
//  Created by stkcctv on 16/12/14.
//  Copyright © 2016年 JG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JGPickerDelegate <NSObject>

//改变了
- (void)changeTime:(NSDate *)date;
//确定选择
- (void)determinSelected:(NSDate *)date;

@end

@interface JGPicker : UIView

@property (nonatomic,assign)id<JGPickerDelegate> delegate;


@property (nonatomic,assign)UIDatePickerMode  type;

@property (nonatomic,strong)UIView            *backgroundView;
@property (nonatomic,strong)UIView            *topView;
@property (nonatomic,strong)UIDatePicker      *datePicker;

@property (nonatomic,strong)UIButton          *cancleButton;

@property (nonatomic,strong)UIButton          *determineButton;


//类方法创建
+(instancetype)datePickerViewWithType:(UIDatePickerMode)type andDelegate:(id)delegate;;
//实例方法创建
- (instancetype)initWithFrame:(CGRect)frame type:(UIDatePickerMode)type  andDelegate:(id)delegate;

- (void)show;

// NSDate <-- NSString
- (NSDate*)dateFromString:(NSString*)dateString;
// NSDate --> NSString
- (NSString*)stringFromDate:(NSDate*)date;


@end
