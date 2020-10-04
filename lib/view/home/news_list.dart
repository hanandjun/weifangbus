import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/view/home/news_detail.dart';
import 'package:weifangbus/view/store/news_model.dart';

/// 资讯列表页
class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final GlobalKey<ScaffoldState> _newsListKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  // 展示 SnackBar
  void showSnackBar(String snackStr) {
    _newsListKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(snackStr),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _newsListKey,
      appBar: AppBar(
        title: Text("资讯列表"),
      ),
      body: Consumer<NewsModel>(
        builder: (context, _showNewsList, _) => Center(
          child: EasyRefresh.custom(
            header: PhoenixHeader(),
            footer: PhoenixFooter(),
            onRefresh: () async {
              var connectivityResult =
                  await (Connectivity().checkConnectivity());
              if (connectivityResult != ConnectivityResult.none) {
                try {
                  Provider.of<NewsModel>(context, listen: false)
                      .refreshNewsList();
                  showSnackBar('刷新成功!');
                } catch (e) {
                  print('刷新资讯列表出错::: $e');
                  showSnackBar('请求数据失败，请尝试切换网络后重试!');
                }
              } else {
                showSnackBar('设备未连接到任何网络,请连接网络后重试!');
              }
            },
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ListTile(
                      tileColor:
                          index % 2 == 0 ? Colors.grey[300] : Colors.white,
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: Text(
                        DateFormat("yyyy年MM月dd日")
                            .format(DateTime.parse(
                                _showNewsList.showNewsList[index].realeasetime))
                            .toString(),
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: ScreenUtil().setSp(43),
                        ),
                      ),
                      subtitle: AutoSizeText(
                        _showNewsList.showNewsList[index].title,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(40),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return InformationDetail(
                                headLine: _showNewsList.showNewsList[index],
                              );
                            },
                          ),
                        ),
                      },
                    );
                  },
                  childCount: _showNewsList.showNewsList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
