//
//  GameMainScene.h
//  CocosDemo
//
//  Created by 1 on 14-8-18.
//
//

#ifndef __CocosDemo__GameMainScene__
#define __CocosDemo__GameMainScene__

#include <iostream>
#include "cocos2d.h"
#include "MainSprite.h"

USING_NS_CC;
using namespace std;

class GameMainScene : public Layer
{
public:
    GameMainScene();
    ~GameMainScene();
    static Scene* createScene();
    
    virtual bool init() override;
    virtual void update(float dt) override;
    virtual bool onTouchBegan(Touch* touch, Event* event) override;
    virtual void onTouchMoved(Touch* touch, Event* event) override;
    
    CREATE_FUNC(GameMainScene);
private:
    Sprite          *backgroundSprite;
    SpriteBatchNode *spriteBatchNode;
    MainSprite      **spriteArray;
    MainSprite      *selectSprite;
    MainSprite      *changeSprite;
    Label           *timeLabel;
    Label           *scoreLabel;
    //基本类型
    Size        visibleSize;
    float       spriteItemContentWidth;
    float       spriteLeftBottomX;
    float       spriteLeftBottomY;
    bool        isTouchEnable;
    bool        isSpriteAnimation;
    bool        isSpriteNeedAdd;
    int         time;
    int         spriteRemoveCount;
    // method
    void        initSprite();
    Vec2        postionWithSprite(int row, int col);
    MainSprite* spriteWithLocation(Vec2 point);
    void        swapSprite();
    void        checkRowChain(MainSprite* mainSprite, list<MainSprite*> &spriteList);
    void        checkColChain(MainSprite* mainSprite, list<MainSprite*> &spriteList);
    void        checkAndAddSprite();
    void        checkAndRemoveSprite();
    void        removeSprite();
    void        markSprite(MainSprite* sprite);
    void        removeCallBack(Node* node);
    
    void        backItemAction(Ref* sender);
    void        checkWolfAndMark(MainSprite* sprite);
    
    void        timeCountAction(float dt);
};

#endif /* defined(__CocosDemo__GameMainScene__) */
