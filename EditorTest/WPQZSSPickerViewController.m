#import "WPQZSSPickerViewController.h"
#import "WPQZSSViewController.h"

@interface WPQZSSPickerViewController ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation WPQZSSPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"Picker";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveURL)];
    self.navigationItem.rightBarButtonItem = save;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 40, 40)];
    self.textField.text = !self.isInsertImagePicker ? @"http://www.wordpress.com" : @"http://freshtakeoncontent.com/wp-content/uploads/Wordpress_256.png";
    self.textField.layer.borderColor = [UIColor grayColor].CGColor;
    self.textField.layer.borderWidth = 0.5f;
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.textField];    
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveURL {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    WPQZSSViewController *vc = self.demoView;
    if (!self.isInsertImagePicker) {
        [vc showInsertLinkDialogWithLink:self.textField.text title:nil];
    } else {
        [vc showInsertImageDialogWithLink:self.textField.text alt:nil];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
