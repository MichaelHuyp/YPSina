一、为什么要自定义UITabBarController
1.想把UITabBarController内部的子控制器细节屏蔽起来，不让外界了解
2.另外一个目的：每一段代码都应该放在最合适的地方

二、重复代码抽取
很多重复代码 ---> 将重复代码抽取到一个方法中
1.相同的代码放到一个方法中
2.不同的东西变成参数
3.在使用到这段代码的这个地方调用方法，传递参数

三、分类只能扩充方法
给分类写@property属性只能生成方法的声明需要自己实现

四、统一所有控制器导航栏左上角和右上角的内容
1.让所有push进来的控制器，它导航栏左上角和右上角的内容都一样
2."拦截"所有push进来的控制器
3.方案：自定义导航控制器，重写push方法，就可以得到传进来的控制器参数
// 百分之90的拦截都是通过自定义类，重写自带的方法实现的

五、"duplicate symbol _OBJC_CLASS_$_YPTest1ViewController in:"错误
1.百分之90的这个链接错误都是因为引入了.m文件
2.其他可能是因为项目中存在了2个一样的.m文件

六、创建UIBarButtonItem的代码为什么放在UIBarButtonItem分类中最合适？
/*
+ (UIBarButtonItem *)itemWithTarget:(id)target andAction:(SEL)action andImage:(NSString *)image andHighImage:(NSString *)highImage
{
UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
[btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
// 设置图片
[btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
[btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
// 设置尺寸
btn.size = btn.currentBackgroundImage.size;

return [[UIBarButtonItem alloc] initWithCustomView:btn];
}*/
1.项目中有多处地方用到这段代码
2.每一段代码都应该放在最合适的地方：这段代码明显在创建一个UIBarButtonItem，所以跟UIBarButtonItem相关
3.按照命名习惯和规范角度看：[UIBarButtonItem itemWith....]这种形式创建item比较规范

七、重写NSLog
#ifdef DEBUG // 处于开发阶段
#define YPLog(...) NSLog(__VA_ARGS__)
#else // 处于发布阶段
#define YPLog(...)
#endif

八、
/**
 *  通过initWithImage来创建初始化UIImageView,UIImageView的尺寸默认就等于image的尺寸
 *  通过init来创建出赤化绝大部分控件,控件都是没有尺寸的
 */

九、
UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom]; 与 UIButton *titleButton = [[UIButton alloc] init]; 等价

十、// 如果图片的某个方向上不规则，比如有突起，那么这个方向就不能拉伸

十一、
/**
 *  UIPageControl就算没有chicun,里面的内容还是照常显示的
 *  pageControl.width = 100;
 *  pageControl.height = 50;
 *  pageControl.userInteractionEnabled = NO;
 */

十二、
/**
 *  1.如果发现控制器的view还在，但是view上面的数据不显示，极大可能是因为控制器被提前销毁了
 *  2.一个控制器的view是可以随意调整尺寸和位置的
 *  3.一个控制器的view是可以随意添加到其他view中
 *  4.如果将一个控制器的view添加到其他view中显示，那么要想办法保证控制器不被销毁
 *  5.原则：只要view在，view所在的控制器必须得在，这样才能保证view内部的数据和业务逻辑正常
 */

十三、
/**
 *  1.程序启动时会自动加载叫做Default.png的图片
 *      1> 3.5inch 非retina屏幕：Default.png
 *      1> 3.5inch retina屏幕：Default@2x.png
 *      1> 4.0inch retina屏幕：Default-568h@2x.png
 *  2.只有程序启动时自动去加载的图片，才会自动在4inch retina时查找-568h@2x.png
 */

十四、
/**
 *  一个控件用肉眼看不见，有哪些可能
 *  1.根本没有创建实例化这个控件
 *  2.没有设置尺寸
 *  3.控件的颜色跟父控件的背景色一样（实际上已经显示了，只不过用肉眼看不见）
 *  4.透明度alpha <= 0.01
 *  5.hidden = YES
 *  6.没有添加到父控件中
 *  7.被其他控件挡住了
 *  8.位置不对
 *  9.父控件发生了以上情况
 *  10.特殊情况：
 *      UIImageView没有设置image属性，或者设置的图片名不对
 *      UILabel没有设置文字，或者没有设置边框样式
 *      UITextField没有设置文字，
 *      UIPageControl没有设置总页数，不会显示小圆点
 *      UIButton内部imageView和titleLabel的frame被篡改了，或者imageView和titleLabel没有内容
 *      ......
 *
 *  添加一个控件的建议（调试技巧）：
 *  1.最好设置背景色和尺寸
 *  2.控件的颜色尽量不要跟父控件的背景色一样
 */

十五、
什么样的应用才有资格被用户授权
1.注册一个新浪微博账号，成为新浪的开发者
2.登录开发者主页，创建一个应用 http://open.weibo.com
3.创建完应用后，会获得以下主要信息
* Appkey：应用的唯一标识
* AppSecret
* RedirectURI

十六、
/**
 *  什么情况下建议使用imageEdgeInsets、titleEdgeInsets
 *  如果按钮内部的图片、文字固定，用这两个属性来设置间距会比较简单
 *  // 标题宽度
 *  CGFloat titleW = titleButton.titleLabel.width;
 *  // 乘上scale系数,保证retina屏幕下宽度是正确的
 *  CGFloat imageW = titleButton.imageView.width * YPScreenScale;
 *  CGFloat left = titleW + imageW;
 *  titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
 */

十七、
/**
 *  设置按钮内部的imageView的frame
 *
 *  @param contentRect 按钮的bounds
 */
//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    CGFloat imageX = 80;
//    CGFloat imageY = 0;
//    CGFloat imageW = 13;
//    CGFloat imageH = contentRect.size.height;
//    return CGRectMake(imageX, imageY, imageW, imageH);
//}
/**
 *  设置按钮内部的titleLabel的frame
 *
 *  @param contentRect 按钮的bounds
 */
//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    YPLog(@"titleRectForContentRect - 循环引用 不能在这个方法里访问titleLabel");
//    CGFloat titleX = 0;
//    CGFloat titleY = 0;
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    attributes[NSFontAttributeName] = self.titleLabel.font;
//    CGFloat titleW = [self.currentTitle sizeWithAttributes:attributes].width;
//    CGFloat titleH = contentRect.size.height;
//
//    return CGRectMake(titleX, titleY, titleW, titleH);
//}

十八、
(缩略图)profile_image_url = http://tp2.sinaimg.cn/1371731565/50/40064882850/0
(大图)avatar_large = http://tp2.sinaimg.cn/1371731565/180/40064882850/0
(高清图)avatar_hd = http://ww3.sinaimg.cn/crop.0.0.640.640.1024/4711809ejw8eua9a98sayj20hs0hs75k.jpg

十九、
/**
 *  -----------------------------
 *  contentMode 内容模式枚举
 *  -----------------------------
 *  UIViewContentModeScaleToFill - 图片拉伸直到填充整个ImageView（图片可能会变形）
 *  UIViewContentModeScaleAspectFit - 图片按照原来宽高比拉伸,直到拉伸至整个图片都包含在UIImageView内部为止,然后居中显示,因此会有空白
 *  UIViewContentModeScaleAspectFill - 图片按照原来宽高比拉伸,直到拉伸至图片的宽或高与ImageView宽或高相同为止（不一定哪个先达到,宽高谁先到就停止）,然后居中显示,因此会有超出部分
 *  UIViewContentModeRedraw - 当调用setNeedsDisplay的时候,就会将图片重新渲染
 *  UIViewContentModeCenter - 居中显示
 *  UIViewContentModeTop,
 *  UIViewContentModeBottom,
 *  UIViewContentModeLeft,
 *  UIViewContentModeRight,
 *  UIViewContentModeTopLeft,
 *  UIViewContentModeTopRight,
 *  UIViewContentModeBottomLeft,
 *  UIViewContentModeBottomRight,
 *  -------------------------------
 *  经验规律:
 *  1.凡是带有Scale单词的，图片都会拉伸
 *  2.凡是带有Aspect单词的,图片都会保持原来的宽高比，图片不会变形
 */
二十、
制造假数据
NSMutableDictionary *dict = [NSMutableDictionary dictionary];
dict[@"statuses"] = [YPStatus keyValuesArrayWithObjectArray:newStatuses];
dict[@"total_number"] = responseObject[@"total_number"];
[dict writeToFile:@"/Users/huyunpeng/Desktop/fakeStatus.plist" atomically:YES];
二十一、
/**
 *  UITextField
 *    1.文字永远是一行
 *    2.有placehoder属性设置占位文字
 *    3.继承自UIControl
 *    4.监听行为:
 *      1>设置代理
 *      2>addTarget:action:forControlEvents:
 *      3>通知 UITextFieldTextDidChangeNotification
 *  ----------------
 *  UITextView
 *    1.能显示任意行的文字
 *    2.不能设置占位文字
 *    3.继承自UIScrollView
 *    4.监听行为
 *      1>设置代理
 *      2>通知 UITextViewTextDidChangeNotification
 */
二十二、
/**
 *  b发出一个aNotification通知给监听者a,调用Method方法
 */
[[NSNotificationCenter defaultCenter] addObserver:a selector:@selector(Method) name:aNotification object:b];
二十三、
/**
 *  调用这个方法会重新调用drawRect方法进行重绘
 */
[self setNeedsDisplay];

