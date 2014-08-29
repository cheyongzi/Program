//
//  SelectScene.h
//  CocosDemo
//
//  Created by 1 on 14-8-19.
//
//

#ifndef __CocosDemo__SelectScene__
#define __CocosDemo__SelectScene__

#include <iostream>
#include "cocos2d.h"
#include "CocosGUI.h"

USING_NS_CC;

using namespace ui;

class SelectScene : public Layer
{
public:
    static Scene* createScene();
    
    virtual bool init();
    
    void startGameAction(Ref* sender);
    void actionCallBack(Node* node);
    
    CREATE_FUNC(SelectScene);
private:
    ScrollView* scrollView;
    
    Size        visibleSize;
    
    Menu*       sheep_menu;
    Menu*       contry_menu;
};

#endif /* defined(__CocosDemo__SelectScene__) */
