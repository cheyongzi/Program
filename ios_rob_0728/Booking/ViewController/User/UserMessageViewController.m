//
//  UserMessageViewController.m
//  Booking
//
//  Created by 1 on 14-7-2.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "UserMessageViewController.h"
#import "SharedUserDefault.h"
#import "MessageElement.h"

@interface UserMessageViewController ()

@end

@implementation UserMessageViewController

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
    
    self.title = @"我的消息";
    
    currentIndex = 1;
    
    mulArr = [[NSMutableArray alloc] init];
    
    CGSize size = [[UIScreen mainScreen] applicationFrame].size;
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, size.height - 44)];
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
    UIImage *img = [UIImage imageNamed:@"dataNil.png"];
    nilStatuView = [[DataNilStatuView alloc] initWithFrame:CGRectMake(size.width/2-50, size.height/2 - 62, 100, 80) withTitle:@"您还没有信息" withImage:img];
    [nilStatuView setHidden:YES];
    [self.view addSubview:nilStatuView];
    
//    for (int i= 0; i<8; i++) {
//        messageView = [[MessageView alloc] initWithFrame:CGRectMake(10, 10+210*i, 300, 200) withViewType:i%2];
//        messageView.delegate = self;
//        [myScrollView addSubview:messageView];
//        myScrollView.contentSize = CGSizeMake(320, (i+1)*210+10);
//    }
    
    
    userElement = [[SharedUserDefault sharedInstance] getUserInfo];
    
    if ([ConUtils checkUserNetwork])
    {
        [HttpRequestComm getUserMessageWithMemId:userElement.memberId withPageIndex:currentIndex withDelegate:self];
    }
    else
    {
        [self showToast:@"网络异常，请稍后再试"];
    }
	// Do any additional setup after loading the view.
}

#pragma mark HttpBaseCommDelegate

- (void)httpRequestSuccessComm:(int)tagId withInParams:(id)inParam
{
    //NSLog(@"我的消息返回数据:%@",inParam);
    if (inParam != nil)
    {
        messageResponse = [[MessageResponse alloc] init];
        [messageResponse setResultData:inParam];
        if (messageResponse.code == 0)
        {
            NSDictionary *dic = [inParam objectForKey:@"body"];
            if (dic == nil || [dic count] == 0)
            {
                [nilStatuView setHidden:NO];
            }
            else
            {
                [mulArr addObjectsFromArray:messageResponse.array];
                for (int i=0; i<[messageResponse.array count]; i++)
                {
                    MessageElement *messageElement = (MessageElement *)[messageResponse.array objectAtIndex:i];
                    NSString *urlStr = [messageElement newsUrl];
                    if (urlStr == nil || [urlStr isEqualToString:@""])
                    {
                        messageView = [[MessageView alloc] initWithFrame:CGRectMake(10, myScrollView.contentSize.height+10, 300, 200) withViewType:1];
                        CGSize strSize = [messageElement.content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:NSLineBreakByCharWrapping];
                        if (strSize.height <= 120)
                        {
                            [messageView.button.label setText:@""];
                        }
                    }
                    else
                    {
                        messageView = [[MessageView alloc] initWithFrame:CGRectMake(10, 10+210*i, 300, 200) withViewType:0];
                    }
                    messageView.titleLabel.text = messageElement.title;
                    messageView.contentLabel.text = [NSString stringWithFormat:@"      %@",messageElement.content];
                    messageView.button.timeLabel.text = messageElement.sendTime;
                    messageView.delegate = self;
                    [myScrollView addSubview:messageView];
                    myScrollView.contentSize = CGSizeMake(320, myScrollView.contentSize.height + 210);
                }
                myScrollView.contentSize = CGSizeMake(320, myScrollView.contentSize.height + 10);
            }
        }
        else
        {
            [self showToast:@"数据加载失败，请稍后重试"];
        }
    }
    else
    {
        
    }
}

- (void)httpRequestFailueComm:(int)tagId withInParams:(NSString *)error
{
    [nilStatuView setHidden:NO];
}

#pragma mark MessageViewDelegate

- (void)messageViewClicked:(int)type withView:(id)view
{
    NSArray *viewArr = [myScrollView subviews];
    MessageView *mView = (MessageView *)view;
    int index = [viewArr indexOfObject:mView];
    if (type == 1)
    {
        //内容标签的原始坐标点和size
        CGPoint contentLabelOrign = mView.contentLabel.frame.origin;
        CGSize contentLabelSize = mView.contentLabel.frame.size;
        //MessageView整体的原始坐标点和size
        CGPoint viewOrign = mView.frame.origin;
        CGSize viewSize = mView.frame.size;
        //按钮的原始坐标点和size
        CGPoint buttonOrign = mView.button.frame.origin;
        CGSize buttonSize = mView.button.frame.size;
        //第二个分割线的位置
        CGPoint seperateOrign = mView.seperateLabel2.frame.origin;
        //内容标签的size
        CGSize strSize = [mView.contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:NSLineBreakByCharWrapping];
        //变换的高度
        CGFloat changeHeight = 0;
        if (strSize.height > 120)
        {
            if (contentLabelSize.height > 120)
            {
                changeHeight = 120 - contentLabelSize.height;
            }
            else
            {
                changeHeight = strSize.height - contentLabelSize.height;
            }
        }
        else
        {
            return;
        }
        [mView.contentLabel setFrame:CGRectMake(contentLabelOrign.x, contentLabelOrign.y, contentLabelSize.width, contentLabelSize.height + changeHeight)];
        [mView setFrame:CGRectMake(viewOrign.x, viewOrign.y, viewSize.width, viewSize.height + changeHeight)];
        [mView.button setFrame:CGRectMake(buttonOrign.x, mView.frame.size.height - 30, buttonSize.width, buttonSize.height)];
        if (changeHeight < 0)
        {
            [mView.button.label setText:@"查看详情 v"];
        }
        else
        {
            [mView.button.label setText:@"   收起 ^"];
        }
        [mView.seperateLabel2 setFrame:CGRectMake(0, seperateOrign.y+changeHeight, 300, 1)];
        myScrollView.contentSize = CGSizeMake(320, myScrollView.contentSize.height + changeHeight);
        
        for (int i = index+1; i<[viewArr count]-2; i++)
        {
            CGRect orignFrame = [[viewArr objectAtIndex:i] frame];
            [[viewArr objectAtIndex:i] setFrame:CGRectMake(orignFrame.origin.x, orignFrame.origin.y+changeHeight, orignFrame.size.width, orignFrame.size.height)];
        }
    }
    else if (type == 0)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[mulArr objectAtIndex:index] newsUrl]]];
    }
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y == (scrollView.contentSize.height - scrollView.frame.size.height))
    {
        if (currentIndex < messageResponse.totalPage) {
            currentIndex ++ ;
            [HttpRequestComm getUserMessageWithMemId:userElement.memberId withPageIndex:currentIndex withDelegate:self];
        }
        else
        {
            [self showToast:@"数据已全部加载完成"];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
