

#import <Foundation/Foundation.h>
#define FUNCTION_NAME   NSLog(@"%s",__FUNCTION__)

@protocol fileDownloaderDelegate <NSObject>

@optional
- (void)downloadProgres:(NSNumber*)percent forObject:(id)object;

@required

- (void)downloadingStarted;
- (void)downloadingFinishedFor:(NSURL *)url andData:(NSData *)data;
- (void)downloadingFailed:(NSURL *)url;


@end

@interface FileDownloader : NSObject
{
    
@private
    NSMutableURLRequest *_request;
    NSMutableData *downloadedData;
    NSURL *fileUrl;
    
    id <fileDownloaderDelegate> delegate;
    
    double totalFileSize;
}

@property (nonatomic, strong) NSMutableURLRequest *_request;
@property (nonatomic, strong) NSMutableData *downloadedData;
@property (nonatomic, strong) NSURL *fileUrl;

@property (nonatomic, strong) id <fileDownloaderDelegate> delegate;

- (void)downloadFromURL:(NSString *)urlString;

@end
