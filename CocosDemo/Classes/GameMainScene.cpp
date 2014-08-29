//
//  GameMainScene.cpp
//  CocosDemo
//
//  Created by 1 on 14-8-18.
//
//

#include "GameMainScene.h"
#include "Constant.h"

#define SPRITE_WIDTH (7)
#define SPRITE_HEIGHT (9)

#define SPRITE_GAP (1)

GameMainScene::GameMainScene()
: isTouchEnable(true)
,isSpriteAnimation(true)
,isSpriteNeedAdd(false)
,spriteArray(NULL)
,spriteBatchNode(NULL)
,selectSprite(NULL)
,changeSprite(NULL)
,spriteLeftBottomX(0)
,spriteLeftBottomY(0)
,spriteRemoveCount(0)
,time(100)
{
}
/**
 *  析构函数，用于清理数据
 *
 *  @since 1.0.0
 */
GameMainScene::~GameMainScene()
{
    if (spriteArray)
    {
        free(spriteArray);
    }
}

Scene* GameMainScene::createScene()
{
    auto scene = Scene::create();
    
    auto layer = GameMainScene::create();
    
    scene->addChild(layer);
    
    return scene;
}

bool GameMainScene::init()
{
    if (!Layer::init()) {
        return false;
    }
    
    int selectScene = CCUserDefault::getInstance()->getIntegerForKey("SelectScene", 0);
    
    visibleSize = Director::getInstance()->getVisibleSize();
    
    Director::getInstance()->getOpenGLView()->setFrameSize(640, 1136);
    
    backgroundSprite = Sprite::create(backImg_array[selectScene]);
    backgroundSprite->setPosition(Vec2(visibleSize.width/2,visibleSize.height/2));
    addChild(backgroundSprite);
    
    SpriteFrameCache::getInstance()->addSpriteFramesWithFile(plist_array[selectScene]);
    spriteBatchNode = SpriteBatchNode::create(pvr_array[selectScene]);
    addChild(spriteBatchNode);
    
    MenuItemImage *back_item = NULL;
    switch (selectScene) {
        case 0:
            back_item = MenuItemImage::create("sheep4.png", "sheep4.png", CC_CALLBACK_1(GameMainScene::backItemAction, this));
            break;
        case 1:
            back_item = MenuItemImage::create("country1.png", "country1.png", CC_CALLBACK_1(GameMainScene::backItemAction, this));
            break;
            
        default:
            break;
    }
    auto contry_menu = Menu::create(back_item, NULL);
    contry_menu->setPosition(Vec2(visibleSize.width/2, 100));
    addChild(contry_menu);
    
    TTFConfig config("American Typewriter.ttf",20);
    timeLabel = Label::createWithTTF(config, "Time:100");
    timeLabel->setColor(Color3B(0, 255, 0));
    timeLabel->setPosition(Vec2(100, 100));
    addChild(timeLabel);
    
    scoreLabel = Label::createWithTTF(config, "Score:0");
    scoreLabel->setPosition(Vec2(visibleSize.width-100,100));
    scoreLabel->setColor(Color3B(0, 0, 255));
    addChild(scoreLabel);
    
    spriteItemContentWidth = MainSprite::getContentWidth();
    spriteLeftBottomX = (visibleSize.width - spriteItemContentWidth*SPRITE_WIDTH - SPRITE_GAP*(SPRITE_WIDTH-1))/2;
    spriteLeftBottomY = (visibleSize.height - spriteItemContentWidth*SPRITE_HEIGHT - SPRITE_GAP*(SPRITE_HEIGHT-1))/2;
    
    int arraySize = sizeof(MainSprite) * SPRITE_HEIGHT * SPRITE_WIDTH;
    spriteArray   = (MainSprite**)malloc(arraySize);
    memset((void *)spriteArray, 0, arraySize);
    
    initSprite();
    scheduleUpdate();
    schedule(schedule_selector(GameMainScene::timeCountAction), 1, 100, 0);
    
    auto touchListener = EventListenerTouchOneByOne::create();
    touchListener->onTouchBegan = CC_CALLBACK_2(GameMainScene::onTouchBegan, this);
    touchListener->onTouchMoved = CC_CALLBACK_2(GameMainScene::onTouchMoved, this);
    Director::getInstance()->getEventDispatcher()->addEventListenerWithSceneGraphPriority(touchListener, this);
    
    return true;
}
/**
 *  初始化精灵数据
 *
 *  @since 1.0.0
 */
void GameMainScene::initSprite()
{
    for (int row = 0; row<SPRITE_HEIGHT; row++)
    {
        for (int col = 0; col<SPRITE_WIDTH; col++)
        {
            MainSprite *mainSprite = MainSprite::createSprite(row, col);
            Vec2 endPosition   = postionWithSprite(row, col);
            Vec2 startPosition = Vec2(endPosition.x, endPosition.y+visibleSize.height/2);
            mainSprite->setPosition(startPosition);
            mainSprite->runAction(MoveTo::create(0.5, endPosition));
            spriteBatchNode->addChild(mainSprite);
            
            spriteArray[row*SPRITE_WIDTH + col] = mainSprite;
        }
    }
}

/**
 *  根据row与col确定精灵的位置
 *
 *  @param row 精灵所在的行
 *  @param col 精灵所在的列
 *
 *  @return 精灵的位置
 *
 *  @since 1.0.0
 */
Vec2 GameMainScene::postionWithSprite(int row, int col)
{
    float spriteX = spriteLeftBottomX + (spriteItemContentWidth + SPRITE_GAP)*col + spriteItemContentWidth/2;
    float spriteY = spriteLeftBottomY + (spriteItemContentWidth + SPRITE_GAP)*row + spriteItemContentWidth/2;
    return Vec2(spriteX, spriteY);
}

void GameMainScene::update(float dt)
{
    if (isSpriteAnimation)
    {
        isSpriteAnimation = false;
        for (int i=0; i<SPRITE_WIDTH*SPRITE_HEIGHT; i++)
        {
            MainSprite* mainSprite = spriteArray[i];
            if (mainSprite&&mainSprite->getNumberOfRunningActions()>0)
            {
                isSpriteAnimation = true;
                break;
            }
        }
    }
    isTouchEnable = !isSpriteAnimation;
    
    if (!isSpriteAnimation) {
        if (isSpriteNeedAdd)
        {
            string scoreStr(CCString::createWithFormat("%d",spriteRemoveCount*100)->getCString());
            scoreLabel->setString("Score:"+scoreStr);
            checkAndAddSprite();
            isSpriteNeedAdd = false;
        }
        else
        {
            checkAndRemoveSprite();
        }
    }
}

bool GameMainScene::onTouchBegan(cocos2d::Touch *touch, cocos2d::Event *event)
{
    selectSprite = NULL;
    changeSprite = NULL;
    if (isTouchEnable)
    {
        Vec2 location = touch->getLocation();
        selectSprite = spriteWithLocation(location);
        if (selectSprite->getIsWolf())
        {
            checkWolfAndMark(selectSprite);
        }
    }
    return isTouchEnable;
}

void GameMainScene::onTouchMoved(cocos2d::Touch *touch, cocos2d::Event *event)
{
    if (!selectSprite || !isTouchEnable)
    {
        return;
    }
    
    int row = selectSprite->getRow();
    int col = selectSprite->getCol();
    
    auto halfSpriteContentWidth  = selectSprite->getContentSize().width/2;
    auto halfSpriteContentHegith = selectSprite->getContentSize().height/2;
    
    auto spritePositionX         = selectSprite->getPositionX();
    auto spritePositionY         = selectSprite->getPositionY();
    
    auto spriteContentWidth      = selectSprite->getContentSize().width;
    auto spriteContentHeight     = selectSprite->getContentSize().height;
    
    Vec2 location = touch->getLocation();
    //判断滑动的位置是否在selectSprite上方的精灵区域
    Rect upRect = Rect(spritePositionX-halfSpriteContentWidth, spritePositionY+halfSpriteContentHegith, spriteContentWidth, spriteContentHeight);
    if (upRect.containsPoint(location))
    {
        row++;
        if (row<SPRITE_HEIGHT)
        {
            changeSprite = spriteArray[row*SPRITE_WIDTH+col];
        }
        swapSprite();
        return;
    }
    //左方
    Rect leftRect = Rect(spritePositionX-3*halfSpriteContentWidth, spritePositionY-halfSpriteContentHegith, spriteContentWidth, spriteContentHeight);
    if (leftRect.containsPoint(location))
    {
        col--;
        if (col>=0)
        {
            changeSprite = spriteArray[row*SPRITE_WIDTH+col];
        }
        swapSprite();
        return;
    }
    //右方
    Rect rightRect = Rect(spritePositionX+halfSpriteContentWidth, spritePositionY-halfSpriteContentHegith, spriteContentWidth, spriteContentHeight);
    if (rightRect.containsPoint(location))
    {
        col++;
        if (col<SPRITE_WIDTH)
        {
            changeSprite = spriteArray[row*SPRITE_WIDTH+col];
        }
        swapSprite();
        return;
    }
    //下方
    Rect downRect = Rect(spritePositionX-halfSpriteContentWidth, spritePositionY-3*halfSpriteContentHegith, spriteContentWidth, spriteContentHeight);
    if (downRect.containsPoint(location))
    {
        row--;
        if (row>=0)
        {
            changeSprite = spriteArray[row*SPRITE_WIDTH+col];
        }
        swapSprite();
        return;
    }
}
/**
 *  根据点击的位置，获得精灵
 *
 *  @param point touch location
 *
 *  @return 点击选中的精灵
 *
 *  @since 1.0.0
 */
MainSprite* GameMainScene::spriteWithLocation(cocos2d::Vec2 point)
{
    MainSprite *mainSprite = NULL;
    Rect rect = Rect(0, 0, 0, 0);
    for (int i=0; i<SPRITE_WIDTH*SPRITE_HEIGHT; i++)
    {
        mainSprite = spriteArray[i];
        if (mainSprite)
        {
            rect.origin.x = mainSprite->getPositionX() - mainSprite->getContentSize().width/2;
            rect.origin.y = mainSprite->getPositionY() - mainSprite->getContentSize().height/2;
            rect.size     = mainSprite->getContentSize();
            if (rect.containsPoint(point)) {
                return mainSprite;
            }
        }
    }
    return mainSprite;
}
/**
 *  用于两个选中的精灵交换位置
 *
 *  @since 1.0.0
 */
void GameMainScene::swapSprite()
{
    isTouchEnable     = false;
    isSpriteAnimation = true;
    if (!selectSprite || !changeSprite) {
        return;
    }
    Vec2 selectPosition = selectSprite->getPosition();
    Vec2 changePosition = changeSprite->getPosition();
    
    spriteArray[selectSprite->getRow()*SPRITE_WIDTH+selectSprite->getCol()] = changeSprite;
    spriteArray[changeSprite->getRow()*SPRITE_WIDTH+changeSprite->getCol()] = selectSprite;
    int selectRow = selectSprite->getRow();
    int selectCol = selectSprite->getCol();
    selectSprite->setRow(changeSprite->getRow());
    selectSprite->setCol(changeSprite->getCol());
    changeSprite->setRow(selectRow);
    changeSprite->setCol(selectCol);
    
    list<MainSprite*> selectSpriteRowList;
    checkRowChain(selectSprite, selectSpriteRowList);
    
    list<MainSprite*> selectSpriteColList;
    checkColChain(selectSprite, selectSpriteColList);
    
    list<MainSprite*> changeSpriteRowList;
    checkRowChain(changeSprite, changeSpriteRowList);
    
    list<MainSprite*> changeSpriteColList;
    checkColChain(changeSprite, changeSpriteColList);
    
    if (selectSpriteRowList.size()>=2||
        selectSpriteColList.size()>=2||
        changeSpriteRowList.size()>=2||
        changeSpriteColList.size()>=2)
    {
        selectSprite->runAction(MoveTo::create(0.2, changePosition));
        changeSprite->runAction(MoveTo::create(0.2, selectPosition));
        return;
    }
    
    spriteArray[selectSprite->getRow()*SPRITE_WIDTH+selectSprite->getCol()] = changeSprite;
    spriteArray[changeSprite->getRow()*SPRITE_WIDTH+changeSprite->getCol()] = selectSprite;
    int selectRow2 = selectSprite->getRow();
    int selectCol2 = selectSprite->getCol();
    selectSprite->setRow(changeSprite->getRow());
    selectSprite->setCol(changeSprite->getCol());
    changeSprite->setRow(selectRow2);
    changeSprite->setCol(selectCol2);
    
    selectSprite->runAction(Sequence::create(MoveTo::create(0.2, changePosition),MoveTo::create(0.2, selectPosition), NULL));
    changeSprite->runAction(Sequence::create(MoveTo::create(0.2, selectPosition),MoveTo::create(0.2, changePosition), NULL));
}
/**
 *  判断当前某个精灵所在的行是否存在三个相同的精灵
 *
 *  @param mainSprite 精灵
 *  @param spriteList 存储精灵的队列
 *
 *  @since 1.0.0
 */
void GameMainScene::checkRowChain(MainSprite *mainSprite, list<MainSprite *> &spriteList)
{
    //向左遍历精灵是否与当前精灵相同，如果不相同则退出循环
    int spriteCol = mainSprite->getCol() - 1;
    while (spriteCol>=0) {
        MainSprite *sprite = spriteArray[mainSprite->getRow()*SPRITE_WIDTH + spriteCol];
        if (!sprite) {
            break;
        }
        if (sprite&&sprite->getImageIndex() == mainSprite->getImageIndex())
        {
            spriteList.push_back(sprite);
            spriteCol--;
        }
        else
        {
            break;
        }
    }
    //向右遍历
    spriteCol = mainSprite->getCol() + 1;
    while (spriteCol<SPRITE_WIDTH)
    {
        MainSprite *sprite = spriteArray[mainSprite->getRow()*SPRITE_WIDTH + spriteCol];
        if (!sprite) {
            break;
        }
        if (sprite&&sprite->getImageIndex() == mainSprite->getImageIndex())
        {
            spriteList.push_back(sprite);
            spriteCol++;
        }
        else
        {
            break;
        }
    }
}

/**
 *  判断当前某个精灵所在的列是否存在三个相同的精灵
 *
 *  @param mainSprite 精灵
 *  @param spriteList 存储精灵的队列
 *
 *  @since 1.0.0
 */
void GameMainScene::checkColChain(MainSprite *mainSprite, list<MainSprite *> &spriteList)
{
    int spriteRow = mainSprite->getRow() - 1;
    while (spriteRow>=0)
    {
        MainSprite *sprite = spriteArray[spriteRow*SPRITE_WIDTH + mainSprite->getCol()];
        if (!sprite) {
            break;
        }
        if (sprite&&sprite->getImageIndex() == mainSprite->getImageIndex())
        {
            spriteList.push_back(sprite);
            spriteRow--;
        }
        else
        {
            break;
        }
    }
    
    spriteRow = mainSprite->getRow() + 1;
    while (spriteRow<SPRITE_HEIGHT)
    {
        MainSprite *sprite = spriteArray[spriteRow*SPRITE_WIDTH + mainSprite->getCol()];
        if (!sprite) {
            break;
        }
        if (sprite&&sprite->getImageIndex() == mainSprite->getImageIndex())
        {
            spriteList.push_back(sprite);
            spriteRow++;
        }
        else
        {
            break;
        }
    }
}
/**
 *  检测每行或列是否存在3个以上相同的精灵，并删除
 *
 *  @since 1.0.0
 */
void GameMainScene::checkAndRemoveSprite()
{
    MainSprite* mainSprite;
    for (int i = 0; i<SPRITE_WIDTH*SPRITE_HEIGHT; i++)
    {
        mainSprite = spriteArray[i];
        if (!mainSprite)
        {
            continue;
        }
        
        if (!mainSprite->getIsNeedCheck()) {
            continue;
        }
        
        list<MainSprite*> rowList;
        checkRowChain(mainSprite, rowList);
        
        list<MainSprite*> colList;
        checkColChain(mainSprite, colList);
        
        list<MainSprite*> totalList;
        if (rowList.size()>=2)
        {
            list<MainSprite*>::iterator rowIterator;
            for (rowIterator = rowList.begin(); rowIterator!=rowList.end(); rowIterator++)
            {
                totalList.push_back((MainSprite*)*rowIterator);
            }
        }
        
        if (colList.size()>=2)
        {
            list<MainSprite*>::iterator colIterator;
            for (colIterator = colList.begin(); colIterator!=colList.end(); colIterator++)
            {
                totalList.push_back((MainSprite*)*colIterator);
            }
        }
        
        if (totalList.size()<2)
        {
            continue;
        }
        if (totalList.size()>=3) {
            mainSprite->setIsWolf(true);
        }
        totalList.push_back(mainSprite);
        
        list<MainSprite*>::iterator spriteIterator;
        for (spriteIterator=totalList.begin(); spriteIterator!=totalList.end(); spriteIterator++)
        {
            mainSprite = (MainSprite*)*spriteIterator;
            if (!mainSprite)
            {
                continue;
            }
            if (mainSprite->getIsWolf())
            {
                mainSprite->setIsNeedCheck(false);
                mainSprite->setIsNeedRemove(false);
            }
            else
            {
                markSprite(mainSprite);
            }
        }
    }
    removeSprite();
}
/**
 *  检查是否需要添加精灵
 *
 *  @since 1.0.0
 */
void GameMainScene::checkAndAddSprite()
{
    isSpriteAnimation = true;
    
    int *colEmptyArray = (int *)malloc(sizeof(int)*SPRITE_WIDTH);
    memset((void*)colEmptyArray, 0, sizeof(int)*SPRITE_WIDTH);
    
    MainSprite* mainSprite = NULL;
    for (int col=0; col<SPRITE_WIDTH; col++)
    {
        int removeSpriteCount = 0;
        for (int row=0; row<SPRITE_HEIGHT; row++)
        {
            mainSprite = spriteArray[row*SPRITE_WIDTH+col];
            if (NULL == mainSprite)
            {
                removeSpriteCount++;
            }
            else
            {
                if (removeSpriteCount>0)
                {
                    int newRow = row - removeSpriteCount;
                    spriteArray[newRow*SPRITE_WIDTH+col] = mainSprite;
                    spriteArray[row*SPRITE_WIDTH+col] = NULL;
                    Vec2 startPosition = mainSprite->getPosition();
                    Vec2 endPosition   = postionWithSprite(newRow, col);
                    mainSprite->stopAllActions();
                    mainSprite->runAction(MoveTo::create(0.2, endPosition));
                    mainSprite->setRow(newRow);
                }
            }
        }
        colEmptyArray[col] = removeSpriteCount;
    }
    
    for (int col = 0; col<SPRITE_WIDTH; col++)
    {
        for (int row = SPRITE_HEIGHT-colEmptyArray[col]; row<SPRITE_HEIGHT; row++)
        {
            MainSprite *mainSprite = MainSprite::createSprite(row, col);
            Vec2 endPosition   = postionWithSprite(row, col);
            Vec2 startPosition = Vec2(endPosition.x, endPosition.y+visibleSize.height/2);
            mainSprite->setPosition(startPosition);
            mainSprite->runAction(MoveTo::create(0.5, endPosition));
            spriteBatchNode->addChild(mainSprite);
            
            spriteArray[row*SPRITE_WIDTH + col] = mainSprite;
        }
    }
    free(colEmptyArray);
}
/**
 *  删除精灵
 *
 *  @since 1.0.0
 */
void GameMainScene::removeSprite()
{
    isSpriteAnimation = true;
    
    MainSprite* mainSprite;
    for (int i=0; i<SPRITE_WIDTH*SPRITE_HEIGHT; i++)
    {
        mainSprite = spriteArray[i];
        if (!mainSprite) {
            continue;
        }
        if (mainSprite->getIsNeedRemove())
        {
            isSpriteNeedAdd = true;
            spriteRemoveCount+=1;
            //mainSprite->removeFromParentAndCleanup(true);
            mainSprite->runAction(Sequence::create(ScaleTo::create(0.2, 0.0), CallFuncN::create(CC_CALLBACK_1(GameMainScene::removeCallBack, this)), NULL));
            
            auto starAnimation = ParticleSystemQuad::create("stars.plist");
            starAnimation->setAutoRemoveOnFinish(true);
            starAnimation->setBlendAdditive(false);
            starAnimation->setPosition(mainSprite->getPosition());
            starAnimation->setScale(0.6);
            addChild(starAnimation);
        }
    }
}
/**
 *  删除精灵调用的方法
 *
 *  @param node 需要删除的精灵
 *
 *  @since 1.0.0
 */
void GameMainScene::removeCallBack(Node *node)
{
    MainSprite *sprite = (MainSprite*)node;
    spriteArray[sprite->getRow()*SPRITE_WIDTH+sprite->getCol()] = NULL;
    sprite->removeFromParent();
}
/**
 *  标记精灵是否需要删除
 *
 *  @since 1.0.0
 */
void GameMainScene::markSprite(MainSprite* sprite)
{
    if (sprite->getIsNeedRemove())
    {
        return;
    }
    if (!sprite->getIsNeedCheck())
    {
        return;
    }
    sprite->setIsNeedRemove(true);
    sprite->setIsNeedCheck(false);
}

/**
 *  当用户点击精灵为灰太狼时，标记周围的图标
 *
 *  @param sender 精灵
 *
 *  @since 1.0.0
 */
void GameMainScene::checkWolfAndMark(MainSprite *sprite)
{
    int selectRow = sprite->getRow();
    int selectCol = sprite->getCol();
    sprite->setIsNeedRemove(true);
    sprite->setIsNeedCheck(false);
    
    int minRow = selectRow - 2>=0?selectRow-2:0;
    int maxRow = selectRow + 2<=SPRITE_HEIGHT-1?selectRow+2:SPRITE_HEIGHT-1;
    
    int minCol = selectCol - 2>=0?selectCol-2:0;
    int maxCol = selectCol + 2<=SPRITE_WIDTH-1?selectCol+2:SPRITE_WIDTH-1;
    for (int i = minRow; i<=maxRow; i++)
    {
        for (int j = minCol; j<=maxCol; j++)
        {
            MainSprite *mainSprite = spriteArray[i*SPRITE_WIDTH+j];
            mainSprite->setIsNeedRemove(true);
            mainSprite->setIsNeedCheck(false);
        }
    }
    removeSprite();
}

/**
 *  计算游戏时间是否到期
 *
 *  @param dt
 *
 *  @since 1.0.0
 */
void GameMainScene::timeCountAction(float dt)
{
    if (time>0) {
        time--;
        const char* timeChar = CCString::createWithFormat("%d",time)->getCString();
        string timeStr(timeChar);
        timeLabel->setString("Time:"+timeStr);
        if (time==0) {
            isTouchEnable = false;
            unscheduleAllSelectors();
            auto gameOverSprite = Sprite::create("HelloWorld.png");
            gameOverSprite->setPosition(Vec2(visibleSize.width/2, visibleSize.height*3/2));
            gameOverSprite->runAction(MoveTo::create(1.0, Vec2(visibleSize.width/2, visibleSize.height/2)));
            addChild(gameOverSprite);
        }
    }
}

/**
 *  返回主页面的方法
 *
 *  @param sender sender
 *
 *  @since 1.0.0
 */
void GameMainScene::backItemAction(cocos2d::Ref *sender)
{
    Director::getInstance()->popScene();
}



