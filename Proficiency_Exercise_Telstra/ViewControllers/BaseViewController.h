//
//  BaseViewController.h
//  Proficiency_Exercise_Telstra
//
//  Created by Haresh Ghatala on 21/01/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FactDetails.h"

@interface BaseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *tblView;
    UIActivityIndicatorView *progressView;
    UIRefreshControl *refreshControl;
    
    FactDetails *factData;
}

@end
