#import <Foundation/Foundation.h>

#ifndef MoneroPendingTransactionAdapter_h
#define MoneroPendingTransactionAdapter_h

struct MoneroPendingTransactionMember;


@interface MoneroPendingTransactionAdapter: NSObject
{
    struct MoneroPendingTransactionMember* member;
};

//- (id) initWithMember: (MoneroPendingTransactionMember *) member;
- (int) status;
- (NSString *) errorString;
- (uint64_t) amount;
- (uint64_t) fee;
- (uint64_t) dust;
- (NSArray *) txid;
- (uint64_t) txCount;
- (BOOL) commit: (NSError **) error;
//- (NSString *) hash;
@end

#endif /* MoneroPendingTransactionAdapter_h */
