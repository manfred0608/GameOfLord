#import "MainScene.h"
#import "NodeController.h"
@implementation MainScene

- (void)play {
    NSMutableDictionary *nodes = [[NSMutableDictionary alloc] init];
    [NodeController setNodes:nodes];
    [[NodeController getAllNodes] setValue:self forKey:@"MainScene"];
    
    CCScene *gameplayScene = [CCBReader loadAsScene:@"GamePlay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
