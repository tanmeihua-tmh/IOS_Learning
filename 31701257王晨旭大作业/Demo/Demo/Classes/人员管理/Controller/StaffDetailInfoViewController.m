//
//  StaffDetailInfoViewController.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/28.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "StaffDetailInfoViewController.h"
#import "QrCodeImage.h"
@interface StaffDetailInfoViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *qrCode;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *studentNTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneNTF;
@property (weak, nonatomic) IBOutlet UITextField *QQNTF;
@property (weak, nonatomic) IBOutlet UITextField *weChatTF;
@property (weak, nonatomic) IBOutlet UITextField *emailNTF;
@property (weak, nonatomic) IBOutlet UIScrollView *scrolleView;

@property (nonatomic, copy) NSString *currentName;

@end

@implementation StaffDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super awakeFromNib];
     [self.qrCode layoutIfNeeded];
    self.qrCode.clipsToBounds=YES;
    _nameTF.delegate = self;
    _studentNTF.delegate = self;
    _phoneNTF.delegate = self;
    _QQNTF.delegate = self;
    _weChatTF.delegate = self;
    _emailNTF.delegate = self;
    
    self.widthConstraint.constant = kScreenWidth;
    if ([self.title isEqualToString:@"添加人员"]) {
        _nameTF.enabled = YES;
        _studentNTF.enabled = YES;
        _phoneNTF.enabled = YES;
        _QQNTF.enabled = YES;
        _weChatTF.enabled = YES;
        _emailNTF.enabled = YES;
        [self setupAddNavBarItem];
    }else {
        [self setupEditNavBarItem];
    }

    _nameTF.text = self.info.name;
    _studentNTF.text = self.info.studentNumber;
    _phoneNTF.text = self.info.phoneNumber;
    _QQNTF.text = self.info.QQNumber;
    _weChatTF.text = self.info.WeChatNumber;
    _emailNTF.text = self.info.emailNumber;
    
    _currentName = self.info.name;
    // Do any additional setup after loading the view from its nib.
    [self addTapGesture];
}
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)    // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }
        else
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)ciImage size:(CGFloat)widthAndHeight
{
    CGRect extentRect = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(widthAndHeight / CGRectGetWidth(extentRect), widthAndHeight / CGRectGetHeight(extentRect));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extentRect) * scale;
    size_t height = CGRectGetHeight(extentRect) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extentRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extentRect, bitmapImage);
    
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    //return [UIImage imageWithCGImage:scaledImage]; // 黑白图片
    UIImage *newImage = [UIImage imageWithCGImage:scaledImage];
    return [self imageBlackToTransparent:newImage withRed:200.0f andGreen:70.0f andBlue:189.0f];
}
- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.view addGestureRecognizer:tap];
}
- (void)qrTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tC:)];
    [self.view addGestureRecognizer:tap];
}
-(void)tC:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:gesture.view];
     CGRect rect = [self.qrCode convertRect:self.qrCode.bounds toView:nil];
    if ( CGRectContainsPoint(rect, point)) {
        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        [filter setDefaults];
        NSData *data = [_nameTF.text dataUsingEncoding:NSUTF8StringEncoding];
        [filter setValue:data forKeyPath:@"InputMessage"];
        
        // 4.从滤镜从取出生成好的二维码图片
        CIImage *ciImage = [filter outputImage];
        
        self.qrCode.layer.shadowOffset = CGSizeMake(0, 0.5);  // 设置阴影的偏移量
        self.qrCode.layer.shadowRadius = 1;  // 设置阴影的半径
        self.qrCode.layer.shadowColor = [UIColor blackColor].CGColor; // 设置阴影的颜色为黑色
        self.qrCode.layer.shadowOpacity = 0.3; // 设置阴影的不透明度
        
        self.qrCode.image = [self createNonInterpolatedUIImageFormCIImage:ciImage size: 500];
        
        
    }
}
- (void)tapClick:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:gesture.view];
    CGRect rect = [self.phoneNTF convertRect:self.phoneNTF.bounds toView:nil];
    if (!self.phoneNTF.enabled && CGRectContainsPoint(rect, point)) {
        NSString * str=[[NSString alloc] initWithFormat:@"tel:%@",self.phoneNTF.text];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
                }];
            });
        });
    }
}

- (void)setupEditNavBarItem {
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitle:@"完成" forState:UIControlStateSelected];
    [editBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = editItem;
}

- (void)setupAddNavBarItem {
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"完成" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = addItem;
}

//MARK: Click
- (void)editClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (!sender.selected) {
        [self changeData];
    }else {
        [self.nameTF becomeFirstResponder];
        self.nameTF.enabled = YES;
        self.studentNTF.enabled = YES;
        self.phoneNTF.enabled = YES;
        self.QQNTF.enabled = YES;
        self.weChatTF.enabled = YES;
        self.emailNTF.enabled = YES;
    }
}

- (void)addClick:(UIButton *)sender {
    [self changeData];
}

- (void)changeData {
    [self.view resignFirstResponder];
    NSDictionary *dict = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:UserDefaultGet(@"staffInfosDict") error:nil];
    
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:dict];
    if (![_currentName isEqualToString:self.nameTF.text]) {
        [temp removeObjectForKey:_currentName];
    }if ([NSObject validateIsEmpty:self.nameTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"姓名不能为空"];
        return;}
    StaffInfo *info = [StaffInfo new];
    info.name = self.nameTF.text;
    info.phoneNumber = self.phoneNTF.text;
    info.studentNumber = self.studentNTF.text;
    info.QQNumber = self.QQNTF.text;
    info.WeChatNumber = self.weChatTF.text;
    info.emailNumber = self.emailNTF.text;
    [temp setObject:info forKey:info.name];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:temp.copy requiringSecureCoding:YES error:nil];
    UserDefaultSet(data, @"staffInfosDict");
    UserDefaultSet(@{UserDefaultGet(@"userName"): data}, [UserDefaultGet(@"userName") stringByAppendingString:@"staff"]);
    !_block ? : _block();
    [self.navigationController popViewControllerAnimated:YES];
}

// MARK: UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _nameTF) {
//        if (![NSObject validateNickname:textField.text]) {
//            [SVProgressHUD showErrorWithStatus:@"用户名格式不符"];
//            return;
//        }
    }else if (textField == _phoneNTF) {
        if (![NSObject validateMobile:textField.text]) {
            [SVProgressHUD showErrorWithStatus:@"手机号格式不符"];
            return;
        }
    }else if (textField == _studentNTF) {
        
    }else if (textField == _QQNTF) {
        if (![NSObject validateIsValidQQ:textField.text]) {
            [SVProgressHUD showErrorWithStatus:@"QQ号格式不符"];
            return;
        }
    }else if (textField == _weChatTF) {
        if (![NSObject validateIsValidWeChat:textField.text]) {
            [SVProgressHUD showErrorWithStatus:@"微信号格式不符"];
            return;
        }
    }else if (textField == _emailNTF) {
        if (![NSObject validateEmail:textField.text]) {
            [SVProgressHUD showErrorWithStatus:@"邮箱格式不符"];
            return;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD setAnimationDuration:0.01];
    [SVProgressHUD dismissWithDelay:0.01];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [SVProgressHUD setAnimationDuration:0.01];
    [SVProgressHUD dismissWithDelay:0.01];
    
}

- (void)dealloc {
    [SVProgressHUD setAnimationDuration:0.01];
    [SVProgressHUD dismissWithDelay:0.01];
    
}

@end
