#import <Foundation/Foundation.h>

@interface AppDataCache : NSObject

@property (nonatomic,strong) NSMutableArray *marketList;

+ (AppDataCache *)shared;

@end
