//
//  SelectScene.cpp
//  CocosDemo
//
//  Created by 1 on 14-8-19.
//
//

#include "SelectScene.h"
#include "Constant.h"
#include "GameMainScene.h"

Scene* SelectScene::createScene()
{
    auto scene = Scene::create();
    
    auto layer = SelectScene::create();
    
    scene->addChild(layer);
    
    return scene;
}

bool SelectScene::init()
{
    if (!Layer::init())
    {
        return false;
    }
    
    visibleSize = Director::getInstance()->getVisibleSize();
    
    scrollView = ScrollView::create();
    scrollView->setPosition(Vec2(0, 0));
    scrollView->setSize(Size(640, 1136));
    scrollView->setInnerContainerSize(Size(1280, 1136));
    scrollView->setDirection(ScrollView::Direction::HORIZONTAL);
    addChild(scrollView);
    
    auto backSprite1 = Sprite::create("gameScene1.png");
    //backSprite->setContentSize(Size(visibleSize.width, visibleSize.height));
    backSprite1->setPosition(visibleSize.width/2,visibleSize.height/2);
    scrollView->addChild(backSprite1);
    
    auto backSprite2 = Sprite::create("selectScene2.png");
    backSprite2->setPosition(visibleSize.width*3/2,visibleSize.height/2);
    scrollView->addChild(backSprite2);
    
    auto sheep_item = MenuItemImage::create("sheep4.png", "sheep4.png", CC_CALLBACK_1(SelectScene::startGameAction, this));
    sheep_item->setTag(0);
    sheep_menu = Menu::create(sheep_item, NULL);
    sheep_menu->setPosition(Vec2(visibleSize.width/2, 100));
    backSprite1->addChild(sheep_menu);
    
    auto contry_item = MenuItemImage::create("country1.png", "country1.png", CC_CALLBACK_1(SelectScene::startGameAction, this));
    contry_item->setTag(1);
    contry_menu = Menu::create(contry_item, NULL);
    contry_menu->setPosition(Vec2(visibleSize.width/2, 100));
    backSprite2->addChild(contry_menu);
    
    return true;
}

void SelectScene::startGameAction(cocos2d::Ref *sender)
{
    MenuItemImage *item = (MenuItemImage*)sender;
    int selectScene = item->getTag();
    CCUserDefault::getInstance()->setIntegerForKey("SelectScene", selectScene);
    switch (selectScene) {
        case 0:
            sheep_menu->runAction(Sequence::create(MoveTo::create(1, Vec2(visibleSize.width-45, 100)),CallFuncN::create(CC_CALLBACK_1(SelectScene::actionCallBack, this)), NULL));
            break;
        case 1:
            contry_menu->runAction(Sequence::create(MoveTo::create(1, Vec2(visibleSize.width-45, 100)),CallFuncN::create(CC_CALLBACK_1(SelectScene::actionCallBack, this)), NULL));
            break;
            
        default:
            break;
    }
}

void SelectScene::actionCallBack(cocos2d::Node *node)
{
    auto main_scene = GameMainScene::createScene();
    
    Director::getInstance()->pushScene(main_scene);
    
    node->setPosition(Vec2(visibleSize.width/2, 100));
}


