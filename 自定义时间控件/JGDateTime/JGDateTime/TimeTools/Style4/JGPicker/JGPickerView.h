//
//  JGPickerView.h
//  JG5ColDataPicker
//
//  Created by stkcctv on 16/12/19.
//  Copyright © 2016年 JG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JGPickerViewDelegate <NSObject>

@optional
-(void)didFinishPickView:(NSString*)date;
-(void)pickerviewbuttonclick:(UIButton *)sender;
//-(void)hiddenPickerView;


@end

@interface JGPickerView : UIView

@property (nonatomic, copy) NSString *province;
@property(nonatomic,strong)NSDate*curDate;
//@property (nonatomic,strong)UITextField *myTextField;
@property (nonatomic,strong)UIButton *myButton;

@property(nonatomic,strong)id<JGPickerViewDelegate>delegate;
- (void)showInView:(UIView *)view;
- (void)hiddenPickerView;

@end
