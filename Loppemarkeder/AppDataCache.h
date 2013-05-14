#import <Foundation/Foundation.h>

@interface AppDataCache : NSObject

@property (nonatomic,strong) NSArray *marketList;

+ (AppDataCache *)shared;

@end
