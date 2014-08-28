//
//  UserInfoEditViewController.m
//  Booking
//
//  Created by 1 on 14-6-23.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "UserInfoEditViewController.h"
#import "ConstantField.h"
#import "CustomAlertView.h"
#import "UserInfoChangeCell.h"
#import "SharedUserDefault.h"
#import "NSString+CheckUserInfo.h"
#import "AccountCheckViewController.h"
#import "UIImageView+AFNetworking.h"


@interface UserInfoEditViewController ()

@end

@implementation UserInfoEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"个人资料";
    
    userElement = [[SharedUserDefault sharedInstance] getUserInfo];
    
    userArr1 = [NSArray arrayWithObjects:@"",@"昵称",@"姓名",@"性别", nil];
    
    paramArr = [NSArray arrayWithObjects:@"",@"name",@"contact",@"sex", nil];
    
    alertType = [NSArray arrayWithObjects:[NSNumber numberWithInt:EditField_type],[NSNumber numberWithInt:EditField_type],[NSNumber numberWithInt:SexChoice_type], nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoChange:) name:@"UserInfoChange" object:nil];
    
    userType = [self checkUserType];
    
//    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicatorView.frame= CGRectMake(SCREEN_WIDTH/2, 20,0,0);
//    [self.view addSubview:indicatorView];
//    
//    indicatorView2 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    indicatorView2.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 0, 0);
    
    [self initUserInfoView];
	// Do any additional setup after loading the view.
}

- (void)initUserInfoView
{
    myFirTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, 300, 200)];
    [self initWithTableView:myFirTable];
}

- (void)initWithTableView:(UITableView*)tableView
{
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.layer.borderWidth = 1;
    tableView.layer.borderColor = [LOAD_SEPERATE_COLOR CGColor];
    tableView.bounces = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (int)checkUserType
{
    if ([userElement.userCode checkUserPhoneNumber])
    {
        return 0;
    }
    return 1;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CGRect fram = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    if ([indexPath row] == 0)
    {
        //更换头像
        [self selectImage];
    }
    else
    {
        NSString *title = [userArr1 objectAtIndex:[indexPath row]];
        int styleIndex = [[alertType objectAtIndex:[indexPath row]-1] integerValue];
        UserInfoChangeCell *cell = (UserInfoChangeCell *)[tableView cellForRowAtIndexPath:indexPath];
        CustomAlertView *alertView = [[CustomAlertView alloc] initWithFrame:fram withTitle:title withPoint:CGPointMake(30, 50) withIndex:[indexPath row] withStyle:styleIndex withText:cell.contentLabel.text];
        [self.view addSubview:alertView];
    }
}
- (void)selectImage
{
    UIActionSheet *sheet;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else
    {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    [sheet showInView:self.view];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *firCellIndentify = @"USERCHANGECELL";
    UserInfoChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:firCellIndentify];
    if (cell == nil) {
        cell = [[UserInfoChangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firCellIndentify];
    }
    if ([indexPath row] == 0)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
        imageView.tag = 1001;
        [ConUtils checkFileWithURLString:userElement.logoUrl withImageView:imageView withDirector:@"MinePhoto" withDefaultImage:@"defaultImg.png"];
        [cell addSubview:imageView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 200, 50)];
        [label setText:@"修改头像"];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:12];
        [cell addSubview:label];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        cell.titleLabel.text = [userArr1 objectAtIndex:[indexPath row]];
        switch ([indexPath row]) {
            case 1:
                cell.contentLabel.text = userElement.name;
                break;
            case 2:
                cell.contentLabel.text = userElement.contact;
                break;
            case 3:
                if ([userElement.sex integerValue] == 0)
                {
                    cell.contentLabel.text = @"男";
                }
                else
                {
                    cell.contentLabel.text = @"女";
                }
                break;
                
            default:
                break;
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *seperateLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, 300, 1)];
    [seperateLine setBackgroundColor:LOAD_SEPERATE_COLOR];
    [cell addSubview:seperateLine];
    return cell;
}

#pragma mark NSNotification
- (void)userInfoChange:(NSNotification *)notification
{
    if (![ConUtils checkUserNetwork])
    {
        [self showToast:@"网络连接不可用，请稍后再试！" ];
    }
    else
    {
        //[indicatorView startAnimating];
        [SVProgressHUD show];
        int cellIndex = [[notification object] integerValue];
        NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
        [mulDic setObject:userElement.userCode forKey:@"userCode"];
        [mulDic setObject:userElement.sessionId forKey:@"sid"];
        [mulDic setObject:[[notification userInfo] objectForKey:@"UserName"] forKey:[paramArr objectAtIndex:cellIndex]];
        [HttpRequestComm updateMemberInfo:mulDic withDelegate:self];
    }
}

- (void)uploadImg
{
    [self.view setUserInteractionEnabled:NO];
    backImg = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [backImg setBackgroundColor:ALERT_BACKGROUND_COLOR];
    [backImg setAlpha:0.3];
    [self.view addSubview:backImg];
//    [backImg addSubview:indicatorView2];
//    [indicatorView2 startAnimating];
    [SVProgressHUD show];
    [HttpRequestComm updateFile:[FILE_PATH stringByAppendingString:[NSString stringWithFormat:@"/%@.jpg",userElement.userCode]] withIsCompress:@"yes" withDelegate:self];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

# pragma mark HttpRequestCommDelegate
//网络请求成功协议的方法
-(void)httpRequestSuccessComm:(int) tagId withInParams:(id) inParam
{
    [SVProgressHUD dismiss];
    switch (tagId) {
        case USERUPDATE:
            [self.view setUserInteractionEnabled:YES];
            [backImg removeFromSuperview];
            //NSLog(@"Veritify code get success %@,%@,%@",inParam,[[inParam objectForKey:@"result"] objectForKey:@"code"],[[inParam objectForKey:@"result"] objectForKey:@"msg"]);
            if (inParam == nil)
            {
                [self showToast:@"网络异常，请稍后再试"];
            }
            else
            {
                if ([[[inParam objectForKey:@"result"] objectForKey:@"code"] integerValue] == 0)
                {
                    loginResponse = [[LoginResponse alloc] init];
                    [loginResponse setResultData:inParam];
                    userElement = loginResponse.userElement;
                    
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userElement];
                    [[SharedUserDefault sharedInstance] setUserInfo:data];
                    
                    if (userElement.name != nil && ![userElement.name isEqualToString:@""])
                    {
                        UserInfoChangeCell *cell = (UserInfoChangeCell *)[myFirTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                        cell.contentLabel.text = userElement.name;
                    }
                    if (userElement.contact != nil && ![userElement.contact isEqualToString:@""])
                    {
                        UserInfoChangeCell *cell = (UserInfoChangeCell *)[myFirTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
                        cell.contentLabel.text = userElement.contact;
                    }
                    if (userElement.sex != nil)
                    {
                        UserInfoChangeCell *cell = (UserInfoChangeCell *)[myFirTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
                        if ([userElement.sex integerValue] == 1)
                        {
                            cell.contentLabel.text = @"女";
                        }
                        else
                        {
                            cell.contentLabel.text = @"男";
                        }
                        
                    }
                    if (userElement.logoUrl != nil && ![userElement.logoUrl isEqualToString:@""])
                    {
                        UITableViewCell *cell = [myFirTable cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
                        [ConUtils checkFileWithURLString:userElement.logoUrl withImageView:(UIImageView*)[cell viewWithTag:1001] withDirector:@"MinePhoto" withDefaultImage:@"defaultImg.png"];
                    }
                    else
                    {
                        UITableViewCell *cell = [myFirTable cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
                        [cell.imageView setImage:[UIImage imageNamed:@"defaultImg.png"]];
                    }
                }
                else
                {
                    [self showToast:[[inParam objectForKey:@"result"] objectForKey:@"msg"]];
                }
            }
            break;
        case UPLOADFILE:
            if (inParam != nil)
            {
                //NSLog(@"上传文件返回内容:%@",inParam);
                if ([[[[inParam objectForKey:@"result"] objectForKey:@"code"] objectForKey:@"state"] integerValue] == 0)
                {
                    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
                    [mulDic setObject:userElement.userCode forKey:@"userCode"];
                    [mulDic setObject:userElement.sessionId forKey:@"sid"];
                    [mulDic setObject:[[[inParam objectForKey:@"result"] objectForKey:@"body"] objectForKey:@"path"] forKey:@"logoUrl"];
                    [HttpRequestComm updateMemberInfo:mulDic withDelegate:self];
                }
                else
                {
                    [self showToast:[[inParam objectForKey:@"result"] objectForKey:@"msg"]];
                }
                
            }
            break;
        default:
            break;
    }
    
}

//网络请求失败协议方法
-(void)httpRequestFailueComm:(int)tagId withInParams:(NSString *) error
{
    [SVProgressHUD dismiss];
    switch (tagId) {
        case USERUPDATE:
            [self.view setUserInteractionEnabled:YES];
            [backImg removeFromSuperview];
//            [indicatorView2 stopAnimating];
//            [indicatorView stopAnimating];
            [self showToast:@"网络异常，请稍后再试"];
            break;
        case UPLOADFILE:
            [self showToast:@"网络异常，请稍后再试"];
            break;
            
        default:
            break;
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    userElement = [[SharedUserDefault sharedInstance] getUserInfo];
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        switch (buttonIndex) {
            case 0:
                return;
                break;
            case 1:
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 2:
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
                
            default:
                break;
        }
    }
    else
    {
        switch (buttonIndex) {
            case 0:
                return;
                break;
            case 1:
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                break;
                
            default:
                break;
        }
    }
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.allowsEditing = YES;
    pickerController.sourceType = sourceType;
    [self presentViewController:pickerController animated:YES completion:^(){}];
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *selectImg = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if (selectImg != nil)
    {
        if ([UIImageJPEGRepresentation(selectImg, 0.5) writeToFile:[FILE_PATH stringByAppendingString:[NSString stringWithFormat:@"/%@.jpg",userElement.userCode]] atomically:YES]) {
            [picker dismissViewControllerAnimated:YES completion:^(void){}];
            
            [self uploadImg];
        }
    }
}

-(void)popViewController
{
    [SVProgressHUD dismiss];
    [super popViewController];
}
@end
