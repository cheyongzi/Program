//
//  BMKMapViewEx.m
//  Park
//
//  Created by xw on 13-5-27.
//  Copyright (c) 2013年 Wang Dean. All rights reserved.
//

#import "BMKMapViewEx.h"
#import "BMKPinAnnotationView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

static CGFloat kTransitionDuration = 0.45f;



@interface BMKMapViewEx()

@property (nonatomic, retain) UIView* bubbleView;
@property (nonatomic, retain) UIView* selectView;

- (void)changeBubblePosition;

@end

@interface BMKMapViewEx()

//@property (nonatomic, assign) BOOL evade; //规避数字，由于使用

@end

@implementation BMKMapViewEx

#pragma mark show bubble animation
- (void)bounce4AnimationStopped{
    //CGPoint point = [_mapView convertCoordinate:selectedAV.annotation.coordinate toPointToView:selectedAV.superview];
    //DLog(@"annotationPoint4:x=%.1f, y= %.1f", point.x, point.y);
    //[self changeBubblePosition];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kTransitionDuration/6];
	//[UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(bounce5AnimationStopped)];
	self.bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
	[UIView commitAnimations];
}

- (void)bounce3AnimationStopped{
    //CGPoint point = [_mapView convertCoordinate:selectedAV.annotation.coordinate toPointToView:selectedAV.superview];
    //DLog(@"annotationPoint3:x=%.1f, y= %.1f", point.x, point.y);
    //[self changeBubblePosition];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kTransitionDuration/6];
	[UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce4AnimationStopped)];
	self.bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);
	[UIView commitAnimations];
}

- (void)bounce2AnimationStopped{
    //CGPoint point = [_mapView convertCoordinate:selectedAV.annotation.coordinate toPointToView:selectedAV.superview];
    //DLog(@"annotationPoint2:x=%.1f, y= %.1f", point.x, point.y);
    //[self changeBubblePosition];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kTransitionDuration/6];
	[UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce3AnimationStopped)];
	self.bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.05, 1.05);
	[UIView commitAnimations];
}

- (void)bounce1AnimationStopped{
    //CGPoint point = [_mapView convertCoordinate:selectedAV.annotation.coordinate toPointToView:selectedAV.superview];
    //DLog(@"annotationPoint1:x=%.1f, y= %.1f", point.x, point.y);
    //[self changeBubblePosition];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kTransitionDuration/6];
	[UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
	self.bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
	[UIView commitAnimations];
}

- (void)showBubble:(BOOL)show {
    if (show) {
        //[self changeBubblePosition];
        
        if (!self.bubbleView.hidden) {
            return;
        }
        
        self.bubbleView.hidden = NO;
        self.bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kTransitionDuration/3];
        //[UIView setAnimationDelegate:self];
        //[UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
//        self.bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        self.bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        [UIView commitAnimations];
        
    }
    else {
        [self.bubbleView removeFromSuperview];
        self.bubbleView = nil;
        [self.selectView removeObserver:self forKeyPath:@"frame"];
        self.selectView = nil;
       //  self.bubbleView.hidden = YES;
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqual:@"frame"]) {
        [self changeBubblePosition];
	}
}

- (void)changeBubblePosition {
    if (self.selectView) {
        CGRect rect = self.selectView.frame;
        CGPoint center;
        center.x = rect.origin.x + rect.size.width/2;
        center.y = rect.origin.y - self.bubbleView.frame.size.height/2 + 8;
        self.bubbleView.center = center;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)dealloc {

    self.bubbleView = nil;
    self.selectView  = nil;
}

/**
 *地图区域即将改变时会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {

    
    if ([self.mapDelegate respondsToSelector:@selector(mapView:regionWillChangeAnimated:)]){
    [self.mapDelegate mapView:mapView regionWillChangeAnimated:animated];
    }
}

/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    if (self.selectView) {
        [self changeBubblePosition];
        [self showBubble:YES];
    }

    if([self.mapDelegate respondsToSelector:@selector(mapView: regionDidChangeAnimated:)]){
    [self.mapDelegate mapView:mapView regionDidChangeAnimated:animated];
    }
}

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    
    if([self.mapDelegate respondsToSelector:@selector(mapView:viewForAnnotation:)]) {
    
        return [self.mapDelegate mapView:mapView viewForAnnotation:annotation];
        
    }
    return nil;
}

/**
 *当mapView新添加annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 新添加的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    if ([self.mapDelegate respondsToSelector:@selector(mapView:didAddAnnotationViews:)]) {
        [self.mapDelegate mapView:mapView didAddAnnotationViews:views];
    }
}


#define EQUAL(x, y)  (((x)-(y))< 0.001 && ((x)-(y))> -0.001)
/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    
    
    if ([view.annotation isKindOfClass:[KTVPointAnnotation class]]) {
        
        UIView* bview = [self.bubbleDelegate customBubbleForAnnotation:(KTVPointAnnotation *)view.annotation];
        
        if (bview == nil) {
            [self.selectView removeObserver:self forKeyPath:@"frame"];
            self.selectView = nil;
            [self.bubbleView removeFromSuperview];
            self.bubbleView = nil;
            
            if ([self.mapDelegate respondsToSelector:@selector(mapView: didSelectAnnotationView:)]) {
                [self.mapDelegate mapView:mapView didSelectAnnotationView:view];
            }
            return;
        }
        
        [self.bubbleView removeFromSuperview];
        self.bubbleView = bview;
        
        
        //由于百度地图不支持自定义弹出泡泡，所以我们就在百度API弹出的固定泡泡上增加了一个泡泡视图
        [view.superview addSubview:self.bubbleView];
        self.bubbleView.layer.zPosition = 1.1;
        
        
        if (self.selectView != view) {
            [self.selectView removeObserver:self forKeyPath:@"frame"];
            self.selectView = view;
            [self.selectView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
            self.bubbleView.hidden = YES;
        }
        else {
            self.bubbleView.hidden = NO;
        }
        
        [self showBubble:YES];
    }
    else {
        [self.selectView removeObserver:self forKeyPath:@"frame"];
        self.selectView = nil;
        [self.bubbleView removeFromSuperview];
        self.bubbleView = nil;
    }
    
//    if (self.selectView) {
//        NSLog(@"%f %f %f %f ",mapView.centerCoordinate.latitude, view.annotation.coordinate.latitude,
//              mapView.centerCoordinate.longitude, view.annotation.coordinate.longitude);
//    
//    
//        if (EQUAL(mapView.centerCoordinate.latitude,view.annotation.coordinate.latitude) &&
//            EQUAL(mapView.centerCoordinate.longitude,view.annotation.coordinate.longitude)) {
//            
//            if (!self.evade) {
//                CLLocationCoordinate2D evadeLocation = (CLLocationCoordinate2D){
//                    view.annotation.coordinate.latitude + 0.004,
//                    view.annotation.coordinate.longitude
//                };
//                [mapView setCenterCoordinate:evadeLocation animated:YES];
//            }
//            else{
//                
//            }
//        
//            self.evade = YES;
//            
//            if ([self.mapDelegate respondsToSelector:@selector(mapView: didSelectAnnotationView:)]) {
//                [self.mapDelegate mapView:mapView didSelectAnnotationView:view];
//            }
//            return;
//        }
//    }
    

    [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
    //self.evade = YES;
    if ([self.mapDelegate respondsToSelector:@selector(mapView: didSelectAnnotationView:)]) {
        
        [self.mapDelegate mapView:mapView didSelectAnnotationView:view];
    }
    
}

/**
 *当取消选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 取消选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view {
    
    if ([view isKindOfClass:[BMKPinAnnotationView class]]) {
        [self showBubble:NO];
    }
    
    if ([self.mapDelegate respondsToSelector:@selector(mapView:didDeselectAnnotationView:)]){
        
        [self.mapDelegate mapView:mapView didDeselectAnnotationView:view];
    }
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView {
    
    
    if ([self.mapDelegate respondsToSelector:@selector(mapViewWillStartLocatingUser:)]){
        
//        [self.mapDelegate mapViewWillStartLocatingUser:mapView];
    }
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView {
    
        
    if ([self.mapDelegate respondsToSelector:@selector(mapViewDidStopLocatingUser:)]){
        
//        [self.mapDelegate mapViewDidStopLocatingUser:mapView];

    }
}

/**
 *用户位置更新后，会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation {

    if ([self.mapDelegate respondsToSelector:@selector(mapView:didUpdateUserLocation:)]){
        
//         [self.mapDelegate mapView:mapView didUpdateUserLocation:userLocation];
        
    }
    
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    
 
    if ([self.mapDelegate respondsToSelector:@selector(mapView:didFailToLocateUserWithError:)]){
        
//        [self.mapDelegate mapView:mapView didFailToLocateUserWithError:error];
        
    }
}

/**
 *拖动annotation view时view的状态变化，ios3.2以后支持
 *@param mapView 地图View
 *@param view annotation view
 *@param newState 新状态
 *@param oldState 旧状态
 */
- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState {
    

    
    if ([self.mapDelegate respondsToSelector:@selector(mapView:annotationView:didChangeDragState:fromOldState:)]){
        
        [self.mapDelegate mapView:mapView annotationView:view didChangeDragState:newState fromOldState:oldState];
        
    }
}

/**
 *当点击annotation view弹出的泡泡时，调用此接口
 *@param mapView 地图View
 *@param view 泡泡所属的annotation view
 */
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view {
    

    if ([self.mapDelegate respondsToSelector:@selector(mapView:annotationViewForBubble:)]){
        [self.mapDelegate mapView:mapView annotationViewForBubble:view];
    }
}

/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay {
    

    if ([self.mapDelegate respondsToSelector:@selector(mapView:viewForOverlay:)]){
        return [self.mapDelegate mapView:mapView viewForOverlay:overlay];
    }
    
    return nil;
}

/**
 *当mapView新添加overlay views时，调用此接口
 *@param mapView 地图View
 *@param overlayViews 新添加的overlay views
 */
- (void)mapView:(BMKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews {
    
    if ([self.mapDelegate respondsToSelector:@selector(mapView:didAddOverlayViews:)]){
        [self.mapDelegate mapView:mapView didAddOverlayViews:overlayViews];
    }
}


- (void)setShowsUserLocation:(BOOL)isShow {


    [super setShowsUserLocation:isShow];
}
@end
