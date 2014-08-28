//
//  LoadingView.m
//  Booking
//
//  Created by jinchenxin on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(id) initType:(NSInteger) type {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    if (self) {
        [self initView:type];
    }
    return self;
}

-(void) initView:(NSInteger) type{
    UIView *boView ;
    switch (type) {
        case 0:{
            boView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            boView.clipsToBounds = YES;
            UIImageView *loadingImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"com_loading"]];
            
            UIView *fbgView = [[UIView alloc] init];
            loadingImg.frame = CGRectMake(70, 0, loadingImg.frame.size.width, loadingImg.frame.size.height);
            fbgView.clipsToBounds = YES;
            fbgView.backgroundColor = [UIColor grayColor];
            fbgView.frame = loadingImg.frame ;
            
            self.sbgView = [[UIView alloc] init];
            self.sbgView.backgroundColor = [UIColor colorWithRed:0.867 green:0.078 blue:0.251 alpha:1];
            self.sbgView.frame = CGRectMake(0, fbgView.frame.size.height-4, loadingImg.frame.size.width, loadingImg.frame.size.height);
            
            self.desLa = [[UILabel alloc] initWithFrame:CGRectMake(120, 8, 200, 25)];
            self.desLa.text = @"正在加载数据…";
            self.desLa.font = [ConUtils boldAndSizeFont:16];
            self.desLa.backgroundColor = [UIColor clearColor];
            self.desLa.textColor = [UIColor colorWithRed:0.557 green:0.557 blue:0.557 alpha:1];
            [boView addSubview:self.desLa];
            
            [boView addSubview:fbgView];
            [fbgView addSubview:self.sbgView];
            [boView addSubview:loadingImg];
            
            [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
            
            [self addSubview:boView];
        }
            break;
        case 1:{
            boView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            boView.clipsToBounds = YES;
            UIImageView *loadingImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"com_loading"]];
            
            UIView *fbgView = [[UIView alloc] init];
            loadingImg.frame = CGRectMake(70, 0, loadingImg.frame.size.width, loadingImg.frame.size.height);
            fbgView.clipsToBounds = YES;
            fbgView.backgroundColor = [UIColor grayColor];
            fbgView.frame = loadingImg.frame ;
            
            self.sbgView = [[UIView alloc] init];
            self.sbgView.backgroundColor = [UIColor colorWithRed:0.867 green:0.078 blue:0.251 alpha:1];
            self.sbgView.frame = CGRectMake(0, fbgView.frame.size.height-4, loadingImg.frame.size.width, loadingImg.frame.size.height);
            
            self.desLa = [[UILabel alloc] initWithFrame:CGRectMake(120, 8, 200, 25)];
            self.desLa.text = @"无更多数据!";
            self.desLa.font = [ConUtils boldAndSizeFont:16];
            self.desLa.backgroundColor = [UIColor clearColor];
            self.desLa.textColor = [UIColor colorWithRed:0.557 green:0.557 blue:0.557 alpha:1];
            [boView addSubview:self.desLa];
            
            [boView addSubview:fbgView];
            [fbgView addSubview:self.sbgView];
            [boView addSubview:loadingImg];
            
//            [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
            
            [self addSubview:boView];
        }
            break;
            
        case 2:
        {
            boView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            boView.clipsToBounds = YES;
            UIImageView *loadingImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"com_loading"]];
            
            UIView *fbgView = [[UIView alloc] init];
            loadingImg.frame = CGRectMake(70, 0, loadingImg.frame.size.width, loadingImg.frame.size.height);
            fbgView.clipsToBounds = YES;
            fbgView.backgroundColor = [UIColor grayColor];
            fbgView.frame = loadingImg.frame ;
            
            self.sbgView = [[UIView alloc] init];
            self.sbgView.backgroundColor = [UIColor colorWithRed:0.867 green:0.078 blue:0.251 alpha:1];
            self.sbgView.frame = CGRectMake(0, fbgView.frame.size.height-4, loadingImg.frame.size.width, loadingImg.frame.size.height);
            
            self.desLa = [[UILabel alloc] initWithFrame:CGRectMake(120, 8, 200, 25)];
            self.desLa.text = @"数据加载失败";
            self.desLa.font = [ConUtils boldAndSizeFont:16];
            self.desLa.backgroundColor = [UIColor clearColor];
            self.desLa.textColor = [UIColor colorWithRed:0.557 green:0.557 blue:0.557 alpha:1];
            [boView addSubview:self.desLa];
            
            [boView addSubview:fbgView];
            [fbgView addSubview:self.sbgView];
            [boView addSubview:loadingImg];
            
            //            [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
            
            [self addSubview:boView];
        }
            
            break;
        case 3:
        {
            boView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            boView.clipsToBounds = YES;
            UIImageView *loadingImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"com_loading"]];
            
            UIView *fbgView = [[UIView alloc] init];
            loadingImg.frame = CGRectMake(70, 0, loadingImg.frame.size.width, loadingImg.frame.size.height);
            fbgView.clipsToBounds = YES;
            fbgView.backgroundColor = [UIColor grayColor];
            fbgView.frame = loadingImg.frame ;
            
            self.sbgView = [[UIView alloc] init];
            self.sbgView.backgroundColor = [UIColor colorWithRed:0.867 green:0.078 blue:0.251 alpha:1];
            self.sbgView.frame = CGRectMake(0, fbgView.frame.size.height-4, loadingImg.frame.size.width, loadingImg.frame.size.height);
            
            self.desLa = [[UILabel alloc] initWithFrame:CGRectMake(120, 8, 200, 25)];
            self.desLa.text = @"下拉刷新";
            self.desLa.font = [ConUtils boldAndSizeFont:16];
            self.desLa.backgroundColor = [UIColor clearColor];
            self.desLa.textColor = [UIColor colorWithRed:0.557 green:0.557 blue:0.557 alpha:1];
            [boView addSubview:self.desLa];
            
            [boView addSubview:fbgView];
            [fbgView addSubview:self.sbgView];
            [boView addSubview:loadingImg];
            
            //            [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
            
            [self addSubview:boView];
        }
            
            break;
    }
}

-(void)updateProgress:(id) obj {
    if(self.sbgView.frame.origin.y <5){
        self.sbgView.frame = CGRectMake(0, self.sbgView.frame.size.height-4, self.sbgView.frame.size.width, self.sbgView.frame.size.height);
    }else if(self.sbgView.frame.origin.y >self.sbgView.frame.size.height){
        self.sbgView.frame = CGRectMake(0, self.sbgView.frame.size.height-4, self.sbgView.frame.size.width, self.sbgView.frame.size.height);
    }else{
        self.sbgView.frame = CGRectMake(0, self.sbgView.frame.origin.y-1, self.sbgView.frame.size.width, self.sbgView.frame.size.height);
    }
    
    if(self.pointCounts > 0 && self.pointCounts < 5){
        self.desLa.text = @"正在加载数据.";
    }else if(self.pointCounts > 5 && self.pointCounts <10){
        self.desLa.text = @"正在加载数据..";
    }else if(self.pointCounts >10 && self.pointCounts<=15) {
        self.desLa.text = @"正在加载数据...";
        if(self.pointCounts == 15)
            self.pointCounts = 0 ;
    }
    self.pointCounts ++ ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
