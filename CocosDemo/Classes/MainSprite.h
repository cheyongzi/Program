//
//  MainSprite.h
//  CocosDemo
//
//  Created by 1 on 14-8-18.
//
//

#ifndef __CocosDemo__MainSprite__
#define __CocosDemo__MainSprite__

#include <iostream>
#include "cocos2d.h"

USING_NS_CC;

class MainSprite : public Sprite
{
public:
    MainSprite();
    ~MainSprite();
    static MainSprite* createSprite(int row, int col);
    static float getContentWidth();
    
    CC_SYNTHESIZE(int, row, Row);
    CC_SYNTHESIZE(int, col, Col);
    CC_SYNTHESIZE(int, imageIndex, ImageIndex);
    CC_SYNTHESIZE(bool, isNeedRemove, IsNeedRemove);
    CC_SYNTHESIZE(bool, isNeedCheck, IsNeedCheck);
    CC_SYNTHESIZE_READONLY(bool, isWolf, IsWolf);
    CREATE_FUNC(MainSprite);
    
    void setIsWolf(bool var);
};

#endif /* defined(__CocosDemo__MainSprite__) */
