#import "WPQNativeQuillViewController.h"
#import "WPKeyboardToolbarBase.h"
#import "WPQUtilities.h"

@interface WPQNativeQuillViewController () <UIWebViewDelegate, WPKeyboardToolbarDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) WPKeyboardToolbarBase *editorToolbar;
@property (nonatomic) BOOL didFinishLoadingEditor;
@property (nonatomic) BOOL isShowingKeyboard;
@property (nonatomic, strong) UIWindow *keyboardWindow;

- (void)keyboardWillShow:(NSNotification *)note;
- (void)keyboardDidShow:(NSNotification *)note;
- (void)keyboardWillHide:(NSNotification *)note;

@end

@implementation WPQNativeQuillViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_webView setDelegate:self];
    [MMStopwatchARC start:@"Quill Init"];
	[_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"quill_native_index" ofType:@"html"]isDirectory:NO]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [self.navigationController setToolbarHidden:YES animated:animated];
	[_webView resignFirstResponder];
}

#pragma mark - UIWebViewDelegate Delegate Methods

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MMStopwatchARC stop:@"Quill Init"];
    _didFinishLoadingEditor = YES;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"load request %@",[request URL]);
    if([[[request URL] absoluteString] isEqualToString:@"app://api-triggered-text-change"]) {
        [MMStopwatchARC stop:@"Quill Load"];
        return false;
    }
    return true;
}

#pragma mark - UIAlertView Delegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *urlString = [[alertView textFieldAtIndex:0] text];
    NSLog(@"Entered: %@",urlString);
    [WPQUtilities clenseHTML:&urlString];
    NSString *jsCommand = [NSString stringWithFormat:@"linkSelection(\"%@\")", urlString];
    [_webView stringByEvaluatingJavaScriptFromString:jsCommand];
}

#pragma mark - WPKeyboardToolbar Delegate Methods

- (void)keyboardToolbarButtonItemPressed:(WPKeyboardToolbarButtonItem *)buttonItem {
    NSString *jsCommand;
    if ([buttonItem.actionTag isEqualToString:@"strong"]) {
        jsCommand = @"boldSelection();";
        [_webView stringByEvaluatingJavaScriptFromString:jsCommand];
    } else if ([buttonItem.actionTag isEqualToString:@"em"]) {
        jsCommand= @"italicizeSelection();";
        [_webView stringByEvaluatingJavaScriptFromString:jsCommand];
    } else if ([buttonItem.actionTag isEqualToString:@"u"]) {
        jsCommand = @"underlineSelection();";
        [_webView stringByEvaluatingJavaScriptFromString:jsCommand];
    } else if ([buttonItem.actionTag isEqualToString:@"del"]) {
        jsCommand = @"deleteSelection();";
        [_webView stringByEvaluatingJavaScriptFromString:jsCommand];
    } else if ([buttonItem.actionTag isEqualToString:@"link"]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Add URL" message:@"Gimme a link:" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField * alertTextField = [alert textFieldAtIndex:0];
        alertTextField.keyboardType = UIKeyboardTypeURL;
        alertTextField.placeholder = @"URL";
        [alert show];
    } else if ([buttonItem.actionTag isEqualToString:@"image"]) {
        NSString *urlString = @"http://freshtakeoncontent.com/wp-content/uploads/Wordpress_256.png";
        [WPQUtilities clenseHTML:&urlString];
        jsCommand = [NSString stringWithFormat:@"insertImage(\"%@\")", urlString];
        [_webView stringByEvaluatingJavaScriptFromString:jsCommand];
    } else if ([buttonItem.actionTag isEqualToString:@"more"]) {
        jsCommand= @"insertMore();";
        [_webView stringByEvaluatingJavaScriptFromString:jsCommand];
    } else if ([buttonItem.actionTag isEqualToString:@"done"]) {
        if ([_webView isFirstResponder]) {
            [_webView resignFirstResponder];
        }
        [self.view endEditing:YES];
    } else {
    
    }
}

#pragma mark - Actions

- (IBAction)didPressShortContent:(id)sender
{
    if (_didFinishLoadingEditor) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"content_short" ofType:@"html"];
        NSString *htmlParam = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [WPQUtilities clenseHTML:&htmlParam];
        NSString *setEditorContentCommand = [NSString stringWithFormat:@"setEditorHTML(\"%@\")", htmlParam];
        [MMStopwatchARC start:@"Quill Load"];
        [_webView stringByEvaluatingJavaScriptFromString:setEditorContentCommand];
    }
}

- (IBAction)didPressMediumContent:(id)sender
{
    if (_didFinishLoadingEditor) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"html"];
        NSString *htmlParam = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [WPQUtilities clenseHTML:&htmlParam];
        NSString *setEditorContentCommand = [NSString stringWithFormat:@"setEditorHTML(\"%@\")", htmlParam];
        [MMStopwatchARC start:@"Quill Load"];
        [_webView stringByEvaluatingJavaScriptFromString:setEditorContentCommand];
    }
}

- (IBAction)didPressLongContent:(id)sender
{
    if (_didFinishLoadingEditor) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"content_long" ofType:@"html"];
        NSString *htmlParam = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [WPQUtilities clenseHTML:&htmlParam];
        NSString *setEditorContentCommand = [NSString stringWithFormat:@"setEditorHTML(\"%@\")", htmlParam];
        [MMStopwatchARC start:@"Quill Load"];
        [_webView stringByEvaluatingJavaScriptFromString:setEditorContentCommand];
    }
}

#pragma mark - Privates

- (void)keyboardWillShow:(NSNotification *)note
{
    for (UIWindow *testWindow in [[UIApplication sharedApplication] windows]) {
        if (![[testWindow class] isEqual:[UIWindow class]]) {
            _keyboardWindow = testWindow;
            break;
        }
    }
    
    CGRect frm = _keyboardWindow.frame;
    CGRect toolbarFrame = CGRectMake(0.0f, frm.size.height, frm.size.width, 44.0f);
    if (_editorToolbar == nil) {
        _editorToolbar = [[WPKeyboardToolbarBase alloc] initWithFrame:toolbarFrame];
        _editorToolbar.backgroundColor = [WPStyleGuide keyboardColor];
        _editorToolbar.delegate = self;
    }
    
    [_keyboardWindow addSubview:_editorToolbar];
    
    [UIView animateWithDuration:0.30 animations:^{
        _editorToolbar.frame = CGRectMake(0.0f, 308.0f, toolbarFrame.size.width, toolbarFrame.size.height);
    }];
    
    _editorToolbar.frame = CGRectMake(0.0f, 308.0f, toolbarFrame.size.width, toolbarFrame.size.height);
    _isShowingKeyboard = YES;
}

- (void)keyboardDidShow:(NSNotification *)note
{
    
}

- (void)keyboardWillHide:(NSNotification *)note
{
    CGRect frm = _keyboardWindow.frame;
    CGRect toolbarFrame = CGRectMake(0.0f, frm.size.height, frm.size.width, 44.0f);
    [UIView animateWithDuration:0.33 animations:^{
        _editorToolbar.frame = CGRectMake(0.0f, 800.0f, toolbarFrame.size.width, toolbarFrame.size.height);
    }];
    self.keyboardWindow = nil;
    _isShowingKeyboard = NO;
}

@end
