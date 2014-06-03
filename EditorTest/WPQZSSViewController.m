#import "WPQZSSViewController.h"
#import "WPQZSSPickerViewController.h"
#import "WPQUtilities.h"
#import <QuartzCore/QuartzCore.h>


@interface WPQZSSViewController ()
@property (weak, nonatomic) IBOutlet UIView *lowerView;
@end

@implementation WPQZSSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO; 
    [MMStopwatchARC start:@"ZSS Init"];
    
    _lowerView.layer.zPosition = MAXFLOAT;
    
    self.title = @"ZSSRichTextEditor";
    
    // Export HTML
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Export" style:UIBarButtonItemStylePlain target:self action:@selector(exportHTML)];
	
    // HTML Content to set in the editor
    //NSString *html = @"<p>Load some content here!</p>";
    
    // Set the base URL if you would like to use relative links, such as to images.
    //self.baseURL = [NSURL URLWithString:@"http://www.zedsaid.com"];
    
    // If you want to pretty print HTML within the source view.
    //self.formatHTML = YES;
    
    // Set the toolbar item color
    //self.toolbarItemTintColor = [UIColor greenColor];
    
    // Set the toolbar selected color
    //self.toolbarItemSelectedTintColor = [UIColor brownColor];
    
    // Choose which toolbar items to show
    //self.enabledToolbarItems = ZSSRichTextEditorToolbarSuperscript | ZSSRichTextEditorToolbarUnderline | ZSSRichTextEditorToolbarH1 | ZSSRichTextEditorToolbarH3;
    
    // Set the HTML contents of the editor
    //[self setHtml:html];
    
    [self didPressMediumContent:nil];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MMStopwatchARC stop:@"ZSS Init"];
}

#pragma mark - Actions

- (IBAction)didPressShortContent:(id)sender
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content_short" ofType:@"html"];
    NSString *htmlParam = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //[MMStopwatchARC start:@"ZSS Load"];
    [self setHtml:htmlParam];
}

- (IBAction)didPressMediumContent:(id)sender
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"html"];
    NSString *htmlParam = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //[MMStopwatchARC start:@"ZSS Load"];
    [self setHtml:htmlParam];
}

- (IBAction)didPressLongContent:(id)sender
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content_long" ofType:@"html"];
    NSString *htmlParam = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //[MMStopwatchARC start:@"ZSS Load"];
    [self setHtml:htmlParam];
}

- (void)showInsertURLAlternatePicker {
    
    [self dismissAlertView];
    
    WPQZSSPickerViewController *picker = [[WPQZSSPickerViewController alloc] init];
    picker.demoView = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:picker];
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)showInsertImageAlternatePicker {
    
    [self dismissAlertView];
    
    WPQZSSPickerViewController *picker = [[WPQZSSPickerViewController alloc] init];
    picker.demoView = self;
    picker.isInsertImagePicker = YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:picker];
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)exportHTML {
    
    NSLog(@"%@", [self getHTML]);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
