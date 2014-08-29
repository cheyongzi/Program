//
//  MainSprite.cpp
//  CocosDemo
//
//  Created by 1 on 14-8-18.
//
//

#include "MainSprite.h"
#include "Constant.h"
USING_NS_CC;

MainSprite::MainSprite() : row(0),col(0),imageIndex(0),isNeedRemove(false),isNeedCheck(true),isWolf(false)
{
}

MainSprite::~MainSprite()
{
}

float MainSprite::getContentWidth()
{
    static float item_width;
    if (0 == item_width)
    {
        Sprite *sprite = NULL;
        switch (CCUserDefault::getInstance()->getIntegerForKey("SelectScene", 0)) {
            case 0:
                sprite = Sprite::createWithSpriteFrameName(spriteArray1[0]);
                break;
            case 1:
                sprite = Sprite::createWithSpriteFrameName(spriteArray2[0]);
                break;
                
            default:
                break;
        }
        item_width = sprite->getContentSize().width;
    }
    return item_width;
}

MainSprite* MainSprite::createSprite(int row, int col)
{
    MainSprite* mainSprite = new MainSprite();
    mainSprite->row = row;
    mainSprite->col = col;
    switch (CCUserDefault::getInstance()->getIntegerForKey("SelectScene", 0)) {
        case 0:
            mainSprite->imageIndex = arc4random()%(sizeof(spriteArray1)/sizeof(spriteArray1[0]));
            mainSprite->initWithSpriteFrameName(spriteArray1[mainSprite->imageIndex]);
            break;
        case 1:
            mainSprite->imageIndex = arc4random()%(sizeof(spriteArray2)/sizeof(spriteArray2[0]));
            mainSprite->initWithSpriteFrameName(spriteArray2[mainSprite->imageIndex]);
            break;
        default:
            break;
    }
    mainSprite->autorelease();
    return mainSprite;
}

void MainSprite::setIsWolf(bool var)
{
    isWolf = var;
    
    imageIndex = -1;
    switch (CCUserDefault::getInstance()->getIntegerForKey("SelectScene", 0))
    {
        case 0:
        {
            SpriteFrame* spriteFrame = SpriteFrameCache::getInstance()->getSpriteFrameByName("wolf.png");
            setDisplayFrame(spriteFrame);
        }
            break;
        case 1:
            break;
        default:
            break;
    }
}




