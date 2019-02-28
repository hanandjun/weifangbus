import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weifangbus/utils/fontUtil.dart';
import 'package:weifangbus/widget/list_item.dart';

/// 关于我
class AboutMe extends StatefulWidget {
  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "来自贫困山区的孩子",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        // 阴影
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          // 为了上下拉时不割裂，对半分颜色
          Container(
            height: double.infinity,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          EasyRefresh(
            behavior: ScrollOverBehavior(),
            child: ListView(
              padding: const EdgeInsets.all(0.0),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                // 顶部栏
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(580),
                      color: Colors.white,
                    ),
                    ClipPath(
                      clipper: TopBarClipper(
                        MediaQuery.of(context).size.width,
                        ScreenUtil().setHeight(450),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(450),
                        child: Container(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    // 名字
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(60)),
                      child: Center(
                        child: Text(
                          "hanandjun",
                          style: TextStyle(fontSize: ScreenUtil().setSp(75), color: Colors.white),
                        ),
                      ),
                    ),
                    // 图标
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(200)),
                      child: Center(
                        child: Container(
                          width: ScreenUtil().setWidth(280),
                          height: ScreenUtil().setHeight(280),
                          child: PreferredSize(
                            preferredSize: Size(
                              ScreenUtil().setWidth(80),
                              ScreenUtil().setHeight(80),
                            ),
                            child: Container(
                              child: ClipOval(
                                child: Container(
                                  color: Colors.white,
                                  child: Image.asset(
                                    "assets/images/head.png",
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(
                    ScreenUtil().setWidth(28),
                  ),
                  child: Card(
                      color: Colors.green,
                      child: Container(
                        padding: EdgeInsets.all(
                          ScreenUtil().setWidth(28),
                        ),
                        child: Column(
                          children: <Widget>[
                            ListItem(
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              title: "姓名",
                              titleColor: Colors.white,
                              describe: "韩塞",
                              describeColor: Colors.white,
                            ),
                            ListItem(
                              icon: EmptyIcon(),
                              title: "年龄",
                              titleColor: Colors.white,
                              describe: "25岁",
                              describeColor: Colors.white,
                            ),
                            ListItem(
                              icon: EmptyIcon(),
                              title: "所在城市",
                              titleColor: Colors.white,
                              describe: "山东潍坊",
                              describeColor: Colors.white,
                            )
                          ],
                        ),
                      )),
                ),
                // 内容
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(
                    ScreenUtil().setWidth(28),
                  ),
                  child: Card(
                      color: Colors.blue,
                      child: Container(
                        padding: EdgeInsets.all(
                          ScreenUtil().setWidth(28),
                        ),
                        child: Column(
                          children: <Widget>[
                            ListItem(
                              icon: Icon(
                                MyIcons.qq,
                                color: Colors.white,
                              ),
                              title: "添加QQ",
                              titleColor: Colors.white,
                              describe: "724149270",
                              describeColor: Colors.white,
                              onPressed: () {
                                launch(
                                    "mqqwpa://im/chat?chat_type=wpa&uin=724149270&version=1&src_type=web&web_src=qietu.cn");
                              },
                            ),
                            ListItem(
                              icon: Icon(
                                MyIcons.github,
                                color: Colors.white,
                              ),
                              title: "GitHub",
                              titleColor: Colors.white,
                              describe: "https://github.com/hanandjun",
                              describeColor: Colors.white,
                              onPressed: () {
                                launch("https://github.com/hanandjun");
                              },
                            )
                          ],
                        ),
                      )),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(
                    ScreenUtil().setWidth(28),
                  ),
                  child: Card(
                      color: Colors.teal,
                      child: Container(
                        padding: EdgeInsets.all(
                          ScreenUtil().setWidth(28),
                        ),
                        child: Column(
                          children: <Widget>[
                            ListItem(
                              icon: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              title: "手机号",
                              titleColor: Colors.white,
                              describe: "15553665833",
                              describeColor: Colors.white,
                              onPressed: () {
                                launch("tel:15553665833");
                              },
                            ),
                            ListItem(
                              icon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              title: "邮件",
                              titleColor: Colors.white,
                              describe: "imhansai@foxmail.com",
                              describeColor: Colors.white,
                              onPressed: () {
                                launch("mailto:imhansai@foxmail.com?subject=WeiFang-Bus-Feedback");
                              },
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 顶部栏裁剪
class TopBarClipper extends CustomClipper<Path> {
  // 宽高
  double width;
  double height;

  TopBarClipper(this.width, this.height);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(width, 0.0);
    path.lineTo(width, height / 2);
    path.lineTo(0.0, height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}