//
//  AFESearchBillingCategoryView.m
//  SQLBI_AFE
//
//  Created by Anilkumar Pillai on 20/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AFESearchBillingCategoryView.h"

#define FRAME_ACTIVITY_INDICATOR_CONTAINER_VIEW CGRectMake(0,-1,951,510)

@interface AFESearchBillingCategoryView ()
{
    UIView *popOverView;
    UIPopoverController *popover;
    NSArray *sortingParameterTypeArrays;
    NSString *typeOfParameter;
    NSArray *afeInvoiceDetailArray;
    NSString *billingCategoryIDString;
    
    UIActivityIndicatorView *activityIndicView;
    UIView *activityIndicContainerView;
    UIView *activityIndicBGView;
    UILabel *messageLabel;
    NSString *detailBillingID;
    
    int currentPageShown;
    int totalNoPagesAvailable;

    NSString *currentSortParamater;
    AFESortDirection currentSortDirection;
    
    BOOL isLoading;
    BOOL isDragging;
    ReloadInTableView *reloadInTableViewForPreviousPage;
    ReloadInTableView *reloadInTableViewForNextPage;
    
    int totalPageCount_InvoiceDetailTable;
//    int totalRecordCount_InvoiceDetailTable;
    int newPageNumber_InvoiceDetailTable;
    int curntRecordNmbr;
    
}
@property(nonatomic,strong)AFESearchAPIHandler *afeSearchAPIHandlerObj;
@property(nonatomic, strong) NSMutableArray *apiRequestInfoObjectArray;
@end

@implementation AFESearchBillingCategoryView
@synthesize afeBillingCategoryTableView;
@synthesize afeBillingCategoryDetailArray;
@synthesize detailOverlayView;
@synthesize afeSearchAPIHandlerObj;
@synthesize apiRequestInfoObjectArray;
@synthesize delegate;
@synthesize noOfPagesLabel;
@synthesize totalRecordCount_InvoiceDetailTable;

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) awakeFromNib{
    UIFont *font = FONT_HEADLINE_TITLE;
    font = [font fontWithSize:font.pointSize-1];
    
    self.afeBillingCategoryTableView.layer.borderColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.75].CGColor;
    self.afeBillingCategoryTableView.layer.borderWidth = 1.0f;
    
    sortingParameterTypeArrays = [[NSArray  alloc]initWithObjects:SORTFIELD_BillingCategoryCode,SORTFIELD_BillingCategoryName,SORTFIELD_AFEEstimate_InBillingCategory,SORTFIELD_Actual,SORTFIELD_Accrual,SORTFIELD_NumberOfInvoices, nil];
    
    [billingCategoryCodeHeaderLabel setFont:font];
    [billingCategoryNameHeaderLabel setFont:font]; 
    [afeEstimateHeaderLabel setFont:font];
    [actualHeaderLabel setFont:font];
    [accrualHeaderLabel setFont:font]; 
    [noOfInvoicesHeaderLabel setFont:font];
    [billingCategoryCodeHeaderLabel setTextColor:COLOR_HEADER_TITLE];
    [billingCategoryNameHeaderLabel setTextColor:COLOR_HEADER_TITLE]; 
    [afeEstimateHeaderLabel setTextColor:COLOR_HEADER_TITLE];
    [actualHeaderLabel setTextColor:COLOR_HEADER_TITLE];
    [accrualHeaderLabel setTextColor:COLOR_HEADER_TITLE]; 
    [noOfInvoicesHeaderLabel setTextColor:COLOR_HEADER_TITLE];
    
    //Paging parameters
    currentSortParamater = SORTFIELD_Total;
    currentPageShown = 1;
    currentSortDirection = AFESortDirectionAscending;
    
    newPageNumber_InvoiceDetailTable = 1;
    totalPageCount_InvoiceDetailTable = 1;
//    totalRecordCount_InvoiceDetailTable = 1;
    
    self.noOfPagesLabel.font = [UIFont fontWithName:COMMON_FONTNAME_NORMAL size:11.5];
}

-(void) getAfeSearchBillingCategoryArray:(NSArray *)afeBillingCategoryArray forPage:(int) page ofTotalPages:(int) totalPages{
    
    currentPageShown = page;
    totalNoPagesAvailable = totalPages;
    
    if(currentPageShown == 1)
        curntRecordNmbr = 0;

    self.noOfPagesLabel.text = [NSString stringWithFormat:@"Displaying %d - %d of %d",curntRecordNmbr + 1, curntRecordNmbr + [afeBillingCategoryArray count],totalRecordCount_InvoiceDetailTable];
    
    curntRecordNmbr+=[afeBillingCategoryArray count];
    if(curntRecordNmbr >totalRecordCount_InvoiceDetailTable)
        curntRecordNmbr = [afeBillingCategoryArray count];
    
    self.afeBillingCategoryDetailArray = afeBillingCategoryArray;
    [self.afeBillingCategoryTableView reloadData];
    
    [self initializePaginationViewsInTable:afeBillingCategoryTableView];
    
    //deciding if next page view needs to be shown when pulling.
    if(currentPageShown < totalNoPagesAvailable)
    {
        [reloadInTableViewForNextPage removeFromSuperview];
        [afeBillingCategoryTableView addSubview:reloadInTableViewForNextPage];
    }
    else
        [reloadInTableViewForNextPage removeFromSuperview];
    
    
    //deciding if previous page view needs to be shown when pulling.
    if(currentPageShown > 1 )
    {
        [reloadInTableViewForPreviousPage removeFromSuperview];
        [afeBillingCategoryTableView addSubview:reloadInTableViewForPreviousPage];
    }
    else
        [reloadInTableViewForPreviousPage removeFromSuperview];
    

}

#pragma mark - TableView DataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    return [afeBillingCategoryDetailArray count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    AFESearchBillingCategoryCustomCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[AFESearchBillingCategoryCustomCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    AFEInvoiceBillingCategory *tempInvoiceObject = (AFEInvoiceBillingCategory *) [afeBillingCategoryDetailArray objectAtIndex:indexPath.row];
    if (tempInvoiceObject) 
    {
        if (tempInvoiceObject.invoiceCount == 0) 
        {
            cell.plusButton.tag = -1;
            cell.userInteractionEnabled = NO;
        }
        else 
        {
            cell.plusButton.tag = indexPath.row;
            cell.userInteractionEnabled = YES;
        }
        cell.billingCategoryCodeLabel.text  = tempInvoiceObject.code;
        cell.billingCategoryNameLabel.text  = tempInvoiceObject.billingCategoryName;
        cell.afeEstimateLabel.text          = tempInvoiceObject.budgetAmountAsStr;
        cell.actualLabel.text               = tempInvoiceObject.actualsAsStr;
        cell.accrualLabel.text              = tempInvoiceObject.fieldEstimateAsStr;
        cell.noOfInvoicesLabel.text         = [NSString stringWithFormat:@"%i", tempInvoiceObject.invoiceCount];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - TableView Delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AFEInvoiceBillingCategory *tempInvoiceObject = (AFEInvoiceBillingCategory *) [afeBillingCategoryDetailArray objectAtIndex:indexPath.row];
    billingCategoryIDString = tempInvoiceObject.billingCategoryID;
    [self showDetailOverlay:billingCategoryIDString];
}

-(void) showDetailOverlay:(NSString *)billingCategoryID{
    if (self.detailOverlayView) 
    {
        self.detailOverlayView = nil;
    }
    detailBillingID = billingCategoryID;
    self.detailOverlayView = [[AFESearchInvoiceDetailView alloc]init];
    self.detailOverlayView.delegate = self; 
    [self initializeAfeSearchAPIHandlerAndRequestArray];
    [self stopAPICallOfType:RVAPIRequestTypeGetAfeInvoice withTag:nil];
    
    RVAPIRequestInfo *tempRequestInfo = [afeSearchAPIHandlerObj getAFEInvoiceWithBillingCategoryID:billingCategoryID andWithAFEID:[[NSUserDefaults standardUserDefaults]objectForKey:@"AFESearchAFEID"] andSortBy:@"GrossExpense" withSortOrder:@"DESC" withPageNumber:1 andLimit:50];
    
    [self.apiRequestInfoObjectArray addObject:tempRequestInfo];
    
    [self.detailOverlayView showActivityIndicatorOverlayView];
    self.detailOverlayView.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        
        self.detailOverlayView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    [self.superview.superview addSubview:self.detailOverlayView];
}

#pragma mark - Invoice Detail Sorting 
-(void) getInvoiceDetailTableSort:(AFESearchInvoiceDetailView *) invoiceDetailView forPage:(int)page sortByField:(NSString *)sortField andSortOrder:(AFESortDirection)sortDirection withRecordLimit:(int)limit {
    
    newPageNumber_InvoiceDetailTable = (page>0)? page:1;
    [self.detailOverlayView showActivityIndicatorOverlayView]; 
    [self initializeAfeSearchAPIHandlerAndRequestArray];
    [self stopAPICallOfType:RVAPIRequestTypeGetAfeInvoice withTag:nil];
    
    if (sortDirection == 0) 
    {
        [afeSearchAPIHandlerObj getAFEInvoiceWithBillingCategoryID:detailBillingID andWithAFEID:[[NSUserDefaults standardUserDefaults]objectForKey:@"AFESearchAFEID"] andSortBy:sortField withSortOrder:@"ASC" withPageNumber:page andLimit:50];
    }
    else 
    {
        [afeSearchAPIHandlerObj getAFEInvoiceWithBillingCategoryID:detailBillingID andWithAFEID:[[NSUserDefaults standardUserDefaults]objectForKey:@"AFESearchAFEID"] andSortBy:sortField withSortOrder:@"DESC" withPageNumber:page andLimit:50];
    }
}

#pragma mark - API Handling for Detail Overlay View 
-(void) initializeAfeSearchAPIHandlerAndRequestArray{
    if (!self.afeSearchAPIHandlerObj) 
    {
        self.afeSearchAPIHandlerObj = [[AFESearchAPIHandler alloc] init];
        afeSearchAPIHandlerObj.delegate = self;    
    }
    
    if(!self.apiRequestInfoObjectArray)
    {
        self.apiRequestInfoObjectArray = [[NSMutableArray alloc] init];
    }
}

-(void) stopAllAPICalls
{
    NSMutableArray *tempRequestInfoArray;
    
    if(apiRequestInfoObjectArray)
    {
        tempRequestInfoArray = [apiRequestInfoObjectArray copy];
        
        for(RVAPIRequestInfo *tempRequestInfo in tempRequestInfoArray)
        {
            if(tempRequestInfo)
            {
                [tempRequestInfo cancelAPIRequest];
                [self removeRequestInfoObjectFromPool:tempRequestInfo];
            }
        }
    }
}

-(void) stopAPICallOfType:(RVAPIRequestType) requestType withTag:(id) tag
{
    BOOL shouldCancel = NO;
    NSMutableArray *tempRequestInfoArray;
    
    if(apiRequestInfoObjectArray)
    {
        tempRequestInfoArray = [apiRequestInfoObjectArray copy];
        
        for(RVAPIRequestInfo *tempRequestInfo in tempRequestInfoArray)
        {
            shouldCancel = NO;
            
            if(tempRequestInfo && tempRequestInfo.requestType == requestType)
            {
                if(!tempRequestInfo.tag || !tag)
                {
                    shouldCancel = YES;
                }
                else if([tag isKindOfClass:[NSString class]] && [tempRequestInfo.tag isKindOfClass:[NSString class]])
                {
                    NSString *orginalTag = (NSString*) tempRequestInfo.tag;
                    NSString *tagToCompare = (NSString*) tag;
                    
                    if([orginalTag caseInsensitiveCompare:tagToCompare] == NSOrderedSame)
                        shouldCancel = YES;
                }
                else if(tag == tempRequestInfo.tag)
                {
                    shouldCancel = YES;
                }
                
                if(shouldCancel)
                {
                    [tempRequestInfo cancelAPIRequest];
                    [self removeRequestInfoObjectFromPool:tempRequestInfo];
                }
                
            }
        }
    }
    
}

-(void) removeRequestInfoObjectFromPool:(RVAPIRequestInfo*) requestinfoObj{
    if(apiRequestInfoObjectArray){
        [apiRequestInfoObjectArray removeObject:requestinfoObj];
    }
}

-(void) rvAPIRequestCompletedSuccessfullyForRequest:(RVAPIRequestInfo *)requestInfoObj{
    
    [self removeRequestInfoObjectFromPool:requestInfoObj];
    
    switch (requestInfoObj.requestType) 
    {
        case RVAPIRequestTypeGetAfeInvoice:
        {
            NSDictionary *resultDict = requestInfoObj.resultObject;
            NSArray *resultArray = [resultDict objectForKey:@"AFEInvoiceArray"]? [[NSMutableArray alloc] initWithArray:[resultDict objectForKey:@"AFEInvoiceArray"]]:[[NSMutableArray alloc] init];
            int recordCount = [resultDict objectForKey:@"totrcnt"]? [[resultDict objectForKey:@"totrcnt"] intValue]:[resultArray count];
            int pageCount = [resultDict objectForKey:@"totpgcnt"]?[[resultDict objectForKey:@"totpgcnt"] intValue]:1;
            
            totalPageCount_InvoiceDetailTable = pageCount;
            totalRecordCount_InvoiceDetailTable = recordCount;
        self.detailOverlayView.totalRecords = recordCount;
            [self.detailOverlayView getAfeSearchInvoiceDetailArray:resultArray forPage:newPageNumber_InvoiceDetailTable ofTotalPages:totalPageCount_InvoiceDetailTable];
            [self.detailOverlayView removeActivityIndicatorOverlayView];
        
        }
            break;
            
        default:
            break;
    }
    
    
    
}

-(void) rvAPIRequestCompletedWithErrorForRequest:(RVAPIRequestInfo *)requestInfoObj{
    
    NSLog(@"Failure Reason: %@", requestInfoObj.statusMessage);
    
    [self removeRequestInfoObjectFromPool:requestInfoObj];
    
}

-(BOOL) checkIfAPIRequestTypeAlive:(RVAPIRequestType) requestType withTag:(id) tag{
    BOOL result = NO;
    
    if(self.apiRequestInfoObjectArray)
    {
        for(RVAPIRequestInfo *tempRequestInfo in self.apiRequestInfoObjectArray)
        {
            if(tempRequestInfo.requestType == requestType)
            {
                if(!tempRequestInfo.tag || !tag)
                {
                    result = YES;
                }
                else if([tag isKindOfClass:[NSString class]] && [tempRequestInfo.tag isKindOfClass:[NSString class]])
                {
                    NSString *orginalTag = (NSString*) tempRequestInfo.tag;
                    NSString *tagToCompare = (NSString*) tag;
                    
                    if([orginalTag caseInsensitiveCompare:tagToCompare] == NSOrderedSame)
                        result = YES;
                }
                else if(tag == tempRequestInfo.tag)
                {
                    result = YES;
                }
                
                if(result)
                {
                    break;     
                }              
            }
            
        }
    }
    
    return result;
}

#pragma mark - Sort View
-(IBAction) dropDownButtonClick:(id)sender{
    UIButton *button = (UIButton *)sender;
    
    [self showPopOverWithXAxis:button.frame.origin.x andWithWidth:button.frame.size.width withSortingParameter:[sortingParameterTypeArrays objectAtIndex:button.tag-12] withType:0];
    
}

-(void) showPopOverWithXAxis:(int)xAxis andWithWidth:(int)width withSortingParameter:(NSString *)parameter withType:(AFESortDirection)type{   
    if(popover){
        [popover dismissPopoverAnimated:YES];
        popover = nil;
    }
    SortingView * sortView = [[SortingView alloc] initWithNibName:@"SortingView" bundle:nil];
    popover = [[UIPopoverController alloc] initWithContentViewController:sortView];    
    popover.popoverContentSize =CGSizeMake(165.0, 106.0);
    [popover setDelegate:self];    
    sortView.delegate = self;
    sortView.sortingParameter =parameter;
    sortView.sortType = type;
    [popover presentPopoverFromRect:CGRectMake(xAxis, 9, width, 32) inView:self permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES]; 
}

-(void) sortClicked:(BOOL)descending withSortingParameter:(NSString *)parameter withType:(AFESortDirection)type{
    currentSortDirection = type;
    currentSortParamater = parameter;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(getBillingCategoryTableSort:forPage:sortByField:andSortOrder:withRecordLimit:)])
    {
        [self.delegate getBillingCategoryTableSort:self forPage:1 sortByField:currentSortParamater andSortOrder:type withRecordLimit:50];
    }

    [popover dismissPopoverAnimated:YES];
}

#pragma mark - Activity Indicator View
-(void) showActivityIndicatorOverlayView{
    [self removeActivityIndicatorOverlayView];
    
    if(!activityIndicView)
    {
        activityIndicView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    else
        [activityIndicView removeFromSuperview];
    
    if(!activityIndicContainerView)
        activityIndicContainerView = [[UIView alloc] initWithFrame:FRAME_ACTIVITY_INDICATOR_CONTAINER_VIEW];
    else
    {
        [activityIndicContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [activityIndicContainerView removeFromSuperview];
        
    }
    
    if(!activityIndicBGView)
        activityIndicBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, activityIndicContainerView.frame.size.width, activityIndicContainerView.frame.size.height)];
    else
        [activityIndicBGView removeFromSuperview];
    
    //Set Styling for all Views
    activityIndicContainerView.backgroundColor = [UIColor clearColor];
    activityIndicBGView.backgroundColor = [UIColor blackColor];
    activityIndicBGView.alpha = 0.1;
    activityIndicBGView.layer.cornerRadius = 5;
    activityIndicView.frame = CGRectMake((activityIndicContainerView.frame.size.width-50)/2, (activityIndicContainerView.frame.size.height-50)/2, 50, 50);
    activityIndicView.color = [UIColor darkGrayColor];
    
    [activityIndicContainerView addSubview:activityIndicBGView];
    [activityIndicContainerView addSubview:activityIndicView];
    [self addSubview:activityIndicContainerView];
    
    [activityIndicView startAnimating];
    
}

-(void) removeActivityIndicatorOverlayView{
    if(activityIndicContainerView)
        [activityIndicContainerView removeFromSuperview];
    
    if(activityIndicView)
        [activityIndicView stopAnimating];
    
}

-(void) showMessageOnView:(NSString*) message{
    if(!activityIndicContainerView)
        activityIndicContainerView = [[UIView alloc] initWithFrame:FRAME_ACTIVITY_INDICATOR_CONTAINER_VIEW];
    else
    {
        [activityIndicContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [activityIndicContainerView removeFromSuperview];
        
    }
    
    if(!messageLabel)
    {
        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (activityIndicContainerView.frame.size.height-15)/2, activityIndicContainerView.frame.size.width, 15)];
    }
    
    if(!activityIndicBGView)
        activityIndicBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, activityIndicContainerView.frame.size.width, activityIndicContainerView.frame.size.height)];
    else
        [activityIndicBGView removeFromSuperview];
    
    //Set Styling for all Views
    activityIndicContainerView.backgroundColor = [UIColor clearColor];
    activityIndicBGView.backgroundColor = [UIColor blackColor];
    activityIndicBGView.alpha = 0.1;
    activityIndicBGView.layer.cornerRadius = 5;
    
    messageLabel.font = [UIFont fontWithName:COMMON_FONTNAME_BOLD size:15];
    messageLabel.textColor = [UIColor redColor];
    messageLabel.backgroundColor= [UIColor clearColor];
    messageLabel.text = message? message:@"";
    messageLabel.textAlignment = UITextAlignmentCenter;
    
    [activityIndicContainerView addSubview:activityIndicBGView];
    [activityIndicContainerView addSubview:messageLabel];
    [self addSubview:activityIndicContainerView];
    
}

-(void) hideMessageOnView{
    if(activityIndicContainerView)
        [activityIndicContainerView removeFromSuperview];
    
    if(messageLabel)
        messageLabel.text = @"";
}

#pragma mark - Table Pagination methods
-(void) initializePaginationViewsInTable:(UITableView*) tableView{
    if(!reloadInTableViewForPreviousPage)
        reloadInTableViewForPreviousPage = [[ReloadInTableView alloc] init];
    else
        [reloadInTableViewForPreviousPage removeFromSuperview];
    
    if(!reloadInTableViewForNextPage)
        reloadInTableViewForNextPage = [[ReloadInTableView alloc] init];
    else
        [reloadInTableViewForNextPage removeFromSuperview];
    
    reloadInTableViewForNextPage.textPull = @"Pull to refresh..";
    reloadInTableViewForNextPage.textRelease = @"Release to load next page...";
    
    reloadInTableViewForPreviousPage.textPull = @"Pull to refresh..";
    reloadInTableViewForPreviousPage.textRelease = @"Release to load previous page...";
    
    [tableView addSubview:reloadInTableViewForPreviousPage];
    [tableView addSubview:reloadInTableViewForNextPage];
    reloadInTableViewForNextPage.frame = CGRectMake(0, tableView.contentSize.height, tableView.frame.size.width, 50);
}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (isLoading) return;
    
    isDragging = YES;
    
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"test %@",NSStringFromCGPoint(scrollView.contentOffset));
    
    NSLog(@"SIDE %@",NSStringFromCGSize(scrollView.contentSize));
    
    if (isLoading) {
        
        
    } else if (isDragging ) {
        
        [UIView beginAnimations:nil context:NULL];
        
        if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
            
            
            
            //[reloadInTableView setState:RefreshPulling];
            
            [self setRefreshLoading:RefreshPulling];
            
            
            
        } else {
            
            //[reloadInTableView setState:RefreshNormal];
            
            [self setRefreshLoading:RefreshNormal];
            
        }
        
        
        if (scrollView.contentOffset.y > REFRESH_HEADER_HEIGHT+75) {
            
            
            [self setRefreshLoadingBottom:RefreshPulling];
            
            
            
        } else {
            
            [self setRefreshLoadingBottom:RefreshNormal];
            
        }
        
        [UIView commitAnimations];
        
    }
    
}

-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    
    if (isLoading) return;
    
    isDragging = NO;
    
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {        
        
        [self setRefreshLoading:RefreshStop];
        
        [self getPreviousPageFromService];
        
    }
    
    
    if (scrollView.contentOffset.y > (scrollView.contentSize.height - afeBillingCategoryTableView.frame.size.height)+ REFRESH_HEADER_HEIGHT) {
        
        [self setRefreshLoadingBottom:RefreshStop];
        
        [self getNextPageFromService];
        
    } 
    
}

-(void) setRefreshLoading:(RefreshState)refreshState{
    
    if(RefreshLoading== refreshState){
        
        isLoading=YES;
        
        afeBillingCategoryTableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        
    }
    
    else if(refreshState == RefreshStop){
        
        isLoading=NO;
        
        afeBillingCategoryTableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    }
    
    [reloadInTableViewForPreviousPage setState:refreshState];
    
}

-(void) setRefreshLoadingBottom:(RefreshState)refreshState{
    
    if(RefreshLoading== refreshState){
        
        isLoading=YES;
        
        afeBillingCategoryTableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        
    }
    
    else if(refreshState == RefreshStop){
        
        isLoading=NO;
        
        afeBillingCategoryTableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    }
    
    [reloadInTableViewForNextPage setState:refreshState];
    
}

-(void) getPreviousPageFromService{
    if(currentPageShown > 1)
    {
        if(self.delegate && [self.delegate respondsToSelector:@selector(getBillingCategoryTableSort:forPage:sortByField:andSortOrder:withRecordLimit:)])
        {
            [self.delegate getBillingCategoryTableSort:self forPage:currentPageShown-1 sortByField:currentSortParamater andSortOrder:currentSortDirection withRecordLimit:50];
        }
        
    }
    else
    {
        NSLog(@"You are on first page");
    }
    
}

-(void) getNextPageFromService{
    if(currentPageShown < totalNoPagesAvailable)
    {
        if(self.delegate && [self.delegate respondsToSelector:@selector(getBillingCategoryTableSort:forPage:sortByField:andSortOrder:withRecordLimit:)])
        {
            [self.delegate getBillingCategoryTableSort:self forPage:currentPageShown+1 sortByField:currentSortParamater andSortOrder:currentSortDirection withRecordLimit:50];
        } 
    }
    else
    {
        NSLog(@"You are on last Page.");
    }
}

@end