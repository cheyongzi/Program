#include "AppDelegate.h"
#include "GameMainScene.h"
#include "SelectScene.h"
#include "AppMacros.h"

USING_NS_CC;

AppDelegate::AppDelegate() {

}

AppDelegate::~AppDelegate() 
{
}

bool AppDelegate::applicationDidFinishLaunching() {
    // initialize director
    auto director = Director::getInstance();
    auto glview = director->getOpenGLView();
    if(!glview) {
        glview = GLView::create("My Game");
        director->setOpenGLView(glview);
    }
    
//#if (CC_TARGET_PLATFORM == CC_PLATFORM_WP8)
//    // a bug in DirectX 11 level9-x on the device prevents ResolutionPolicy::NO_BORDER from working correctly
//    glview->setDesignResolutionSize(designResolutionSize.width, designResolutionSize.height, ResolutionPolicy::SHOW_ALL);
//#else
//    glview->setDesignResolutionSize(designResolutionSize.width, designResolutionSize.height, ResolutionPolicy::EXACT_FIT);
//#endif
//    
//	Size frameSize = glview->getFrameSize();
//    
//    // In this demo, we select resource according to the frame's height.
//    // If the resource size is different from design resolution size, you need to set contentScaleFactor.
//    // We use the ratio of resource's height to the height of design resolution,
//    // this can make sure that the resource's height could fit for the height of design resolution.
//    
//    // if the frame's height is larger than the height of medium resource size, select large resource.
//	if (frameSize.height > mediumResource.size.height)
//	{
//        director->setContentScaleFactor(MIN(largeResource.size.height/designResolutionSize.height, largeResource.size.width/designResolutionSize.width));
//	}
//    // if the frame's height is larger than the height of small resource size, select medium resource.
//    else if (frameSize.height > smallResource.size.height)
//    {
//        director->setContentScaleFactor(MIN(mediumResource.size.height/designResolutionSize.height, mediumResource.size.width/designResolutionSize.width));
//    }
//    // if the frame's height is smaller than the height of medium resource size, select small resource.
//	else
//    {
//        director->setContentScaleFactor(MIN(smallResource.size.height/designResolutionSize.height, smallResource.size.width/designResolutionSize.width));
//    }

    // turn on display FPS
    //director->setDisplayStats(true);

    // set FPS. the default value is 1.0/60 if you don't call this
    director->setAnimationInterval(1.0 / 60);

    // create a scene. it's an autorelease object
    //auto scene = GameMainScene::createScene();
    auto scene = SelectScene::createScene();
    // run
    director->runWithScene(scene);

    return true;
}

// This function will be called when the app is inactive. When comes a phone call,it's be invoked too
void AppDelegate::applicationDidEnterBackground() {
    Director::getInstance()->stopAnimation();

    // if you use SimpleAudioEngine, it must be pause
    // SimpleAudioEngine::getInstance()->pauseBackgroundMusic();
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground() {
    Director::getInstance()->startAnimation();

    // if you use SimpleAudioEngine, it must resume here
    // SimpleAudioEngine::getInstance()->resumeBackgroundMusic();
}
