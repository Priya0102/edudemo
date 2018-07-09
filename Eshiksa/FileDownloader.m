
#import "FileDownloader.h"

@implementation FileDownloader
@synthesize _request, downloadedData, fileUrl;
@synthesize delegate;

- (void)downloadFromURL:(NSString *)urlString
{
    [self setFileUrl:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    self._request = [NSMutableURLRequest requestWithURL:self.fileUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0f];
    NSURLConnection *cn = [NSURLConnection connectionWithRequest:self._request delegate:self];
    [cn start];
}


#pragma mark - NSURLConnection Delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if([delegate respondsToSelector:@selector(downloadingStarted)])
    {
        [delegate performSelector:@selector(downloadingStarted)];
    }
    
    totalFileSize = [response expectedContentLength];
    downloadedData = [NSMutableData dataWithCapacity:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [downloadedData appendData:data];
    
    if([delegate respondsToSelector:@selector(downloadProgres:forObject:)])
    {
        [delegate performSelector:@selector(downloadProgres:forObject:) withObject:[NSNumber numberWithFloat:([downloadedData length]/totalFileSize)] withObject:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if([delegate respondsToSelector:@selector(downloadingFailed:)])
    {
        [delegate performSelector:@selector(downloadingFailed:) withObject:self.fileUrl];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if([delegate respondsToSelector:@selector(downloadingFinishedFor:andData:)])
    {
        [delegate performSelector:@selector(downloadingFinishedFor:andData:) withObject:self.fileUrl withObject:self.downloadedData];
    }
}

@end
