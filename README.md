# KMSelectionView
Provide a selectable list show and hide with animation

## Demo

![demogif](https://github.com/Mioke/KMSelectionView/blob/master/gifdemo/KMSelectionView4.gif)

## Usage

1. Download the zip and copy the folder `KMSelectionView` into your project
2. Initialization:
  1. Use default options:
  
    ```objc
    KMSelectionView *view =
        [[KMSelectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)
                                          type:KMSelectionViewTypeDefault
                                        titles:@[@"row 1", @"row 2", @"row 3"]
                                       options:nil];
    ```
    Default style looks like:
    ![defaultType]()
  2. Change basic options:
  
     ```objc
      NSDictionary *options = @{KMSV_Selected_image: [UIImage imageNamed:@"image_selected"], KMSV_Unselected_image: [UIImage imageNamed:@"image_unselected"], KMSV_Text_alignment: @(NSTextAlignmentCenter)};
      KMSelectionView *view =
        [[KMSelectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)
                                          type:KMSelectionViewTypeDefault
                                        titles:@[@"row 1", @"row 2", @"row 3"]
                                       options:options];
                                       
      // or use these method instead
      - (void)setSelectedImage:(UIImage *)selectedImage unselectedImage:(UIImage *)unselectedImage;
      - (void)setCellTextAlignment:(NSTextAlignment)alignment;
      ```
  
  3. Customized your own cell by setting `view.datasource`  to your view controller or anything else, conform to the protocols of `UITableViewDelegate` and `UITableViewDatasource`. Return the cell you want to, and all finished.
    ```objc
    KMSelectionView *view =
        [[KMSelectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)
                                          type:KMSelectionViewTypeCustomCell
                                        titles:@[@"row 1", @"row 2", @"row 3"]
                                       options:options];
    view.datasource = (id<UITableViewDataSource, UITableViewDelegate>)self; 
    ```

  4. To show the view, using 

    ```objc
    - (void)doAnimationToPoint:(CGPoint)to inView:(UIView *)view fromDirection:(KMDirection)direction;
    ```
  5. Set delegate of selection view, for capturing click actions:

    ```objc
    - (void)KMSelectionView:(KMSelectionView *)view didSelectIndex:(NSInteger)index {
      NSLog(@"select line %ld", index);
    }

    - (void)KMSelectionViewDidCancel:(KMSelectionView *)view {
      NSLog(@"cancel");
    }
    ```
    If you define custom cells, then write your code in UITableView's delegate.
  
## Contact

Any further ideas or bugs, please open an issue or pull a request

# Licence
All the source code is under the MIT Licence, please see the LICENCE file for details.
