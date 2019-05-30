//
//  BookModel.h
//  JsonDataParse
//
//  Created by Civet on 2019/5/24.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModel : NSObject

@property (nonatomic,strong) NSString *mBookName;
@property (nonatomic,strong) NSString *mPublisher;
@property (nonatomic,strong) NSString *mPrice;
@property (nonatomic,strong) NSMutableArray *mAuthorArray;

@end
