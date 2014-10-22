//
//  CustomTableViewCell.h
//  LostCharacters
//
//  Created by Wade Sellers on 10/21/14.
//  Copyright (c) 2014 Wade Sellers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *actorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passengerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *seatNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *hairColorLabel;
@end
