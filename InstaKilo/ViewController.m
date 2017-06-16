//
//  ViewController.m
//  InstaKilo
//
//  Created by Noor Alhoussari on 2017-06-14.
//  Copyright © 2017 Noor Alhoussari. All rights reserved.


#import "ViewController.h"
#import "CollectionCellCollectionViewCell.h"
#import "Header.h"
#import "Photos.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//@property (nonatomic) UICollectionViewFlowLayout *flowLayout;

//@property (nonatomic) NSMutableDictionary *location;
//@property (nonatomic) NSMutableDictionary *subject;

@property (nonatomic) NSMutableArray *images;
@property (nonatomic) NSMutableArray *locations;
@property (nonatomic) NSMutableArray *subjects;

//@property (nonatomic) NSMutableArray *sectionPartitionar;
//@property (nonatomic) NSMutableArray *warmPhotos;
//@property (nonatomic) NSMutableArray *coldPhotos;

@property (nonatomic) BOOL segmentPress;

//@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentTag;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    //creating images and initializing the photos array
    Photos *lightsPhoto = [[Photos alloc] initWithPhoto:[UIImage imageNamed:@"lights"] andLocation:@"Toronto" andSubject:@"Warm"];
    Photos *cloudPhoto = [[Photos alloc] initWithPhoto:[UIImage imageNamed:@"cloud"] andLocation:@"Vancouver" andSubject:@"Cold"];
    Photos *coffeePhoto = [[Photos alloc] initWithPhoto:[UIImage imageNamed:@"coffee"] andLocation:@"Toronto" andSubject:@"Warm"];
    Photos *colorsPhoto = [[Photos alloc] initWithPhoto:[UIImage imageNamed:@"colors"] andLocation:@"Toronto" andSubject:@"Warm"];
    Photos *flyingPhoto = [[Photos alloc] initWithPhoto:[UIImage imageNamed:@"flying"] andLocation:@"Vancouver" andSubject:@"Cold"];
    Photos *windowPhoto = [[Photos alloc] initWithPhoto:[UIImage imageNamed:@"window"] andLocation:@"Vancouver" andSubject:@"Cold"];
    Photos *winterPhoto = [[Photos alloc] initWithPhoto:[UIImage imageNamed:@"winter"] andLocation:@"Toronto" andSubject:@"Cold"];
    Photos *butterFlyPhoto = [[Photos alloc] initWithPhoto:[UIImage imageNamed:@"butterFly"] andLocation:@"Vancouver" andSubject:@"Warm"];
    
    self.images = [[NSMutableArray alloc] initWithObjects: lightsPhoto, cloudPhoto, coffeePhoto, colorsPhoto, flyingPhoto, windowPhoto, winterPhoto, butterFlyPhoto, nil];
    
//    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    self.flowLayout.itemSize = CGSizeMake(100, 100);
//    self.flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    self.flowLayout.minimumInteritemSpacing = 15;
//    self.flowLayout.minimumLineSpacing = 10;
//    self.flowLayout.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 50);
//
//    self.collectionView.collectionViewLayout = self.flowLayout;
    
    //location array
    self.locations = [[NSMutableArray alloc] init];
    for (Photos *temPhoto in self.images){
        [self.locations addObject:temPhoto.location];
    }
    
    //subject array
    self.subjects = [[NSMutableArray alloc] init];
    for (Photos *temPhoto in self.images){
        [self.subjects addObject:temPhoto.subject];
    }
    
//    self.sectionPartitionar = [[NSMutableArray alloc] initWithObjects:@"Warm", @"Cold", nil];
    
    //looping through locations and deleting repeated ones
    NSMutableSet *tempSetLocation = [[NSMutableSet alloc] init];
    if(self.locations){
        for(NSString *stringLocation in self.locations){
            if(![tempSetLocation containsObject:stringLocation]){
                [tempSetLocation addObject:stringLocation];
            }
        }
    }
    self.locations = [NSMutableArray arrayWithArray: tempSetLocation.allObjects];

    //looping through subjects and deleting repeated ones
    NSMutableSet *tempSetSubject = [[NSMutableSet alloc] init];
    if(self.subjects){
        for(NSString *stringSubject in self.subjects){
            if(![tempSetSubject containsObject:stringSubject]){
                [tempSetSubject addObject:stringSubject];
            }
        }
    }
    self.subjects = [NSMutableArray arrayWithArray: tempSetSubject.allObjects];

}
- (IBAction)segmentPressed:(UISegmentedControl *)sender {
    
    if(sender.selectedSegmentIndex == 0){
        self.segmentPress = YES;
    } else {
        self.segmentPress = NO;
    }
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(self.segmentPress == YES){
        for (NSString *string in self.locations){
            int numberOfItemsInSectionLocation = 0;
            for(Photos *imagesString in self.images){
                if([string isEqualToString: imagesString.location]){
                    numberOfItemsInSectionLocation++;
                }
            }
            return numberOfItemsInSectionLocation;
        }
    } else {
        for (NSString *string in self.subjects){
            int numberOfItemsInSectionSubject = 0;
            for(Photos *imagesString in self.images){
                if([string isEqualToString: imagesString.subject]){
                    numberOfItemsInSectionSubject++;
                }
            }
            return numberOfItemsInSectionSubject;
        }
    }
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if(self.segmentPress == YES){
        return self.locations.count;
    } else {
        return self.subjects.count;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //getting a cell instance of the cellClass
    CollectionCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    Photos *imageExample;
    
    if(self.segmentPress == YES){
        NSString *string = [self.locations objectAtIndex:indexPath.section];
            
            //temporary array to hold images in certain location
            NSMutableArray *sectionImages = [[NSMutableArray alloc]init];
            for(Photos *imagesString in self.images){
                if([string isEqualToString:imagesString.location]){
                    [sectionImages addObject:imagesString];
                }
            }
            imageExample = sectionImages[indexPath.item];
            cell.photoImage.image = imageExample.photo;
            return cell;
        
    } else {
//        for (NSString *string in self.subjects){
            NSString *string = [self.subjects objectAtIndex:indexPath.section];

            //temporary array to hold images in certain subject
            NSMutableArray *sectionImages = [[NSMutableArray alloc]init];
            for(Photos *imagesString in self.images){
                if([string isEqualToString:imagesString.subject]){
                    [sectionImages addObject:imagesString];
                }
            }
            imageExample = sectionImages[indexPath.item];
            cell.photoImage.image = imageExample.photo;
            return cell;
    }
    return nil;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        Header *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        
        //assigning the label of the section
        if(self.segmentPress == YES){
            NSString *sectionLabelString = [self.locations objectAtIndex:indexPath.section];
            header.sectionLabel.text = sectionLabelString;
            return header;
            
        } else {
            NSString *sectionLabelString = [self.subjects objectAtIndex:indexPath.section];
            header.sectionLabel.text = sectionLabelString;
            return header;
        }
    }
        
//        NSString *sectionLabelString = self.sectionPartitionar[indexPath.section];
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
