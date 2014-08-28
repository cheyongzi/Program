//
//  UserMessageViewController.h
//  Booking
//
//  Created by 1 on 14-7-2.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "MessageResponse.h"
#import "MessageView.h"
#import "DataNilStatuView.h"

@interface UserMessageViewController : BaseViewController<MessageViewDelegate,UIScrollViewDelegate>
{
    UserElement *userElement;
    
    UITableView *myTableView;
    
    MessageResponse *messageResponse;
    
    NSMutableArray *mulArr;
    
    MessageView *messageView;
    
    UIScrollView *myScrollView;
    
    DataNilStatuView *nilStatuView;
    
    int currentIndex;
}
@end
