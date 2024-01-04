import 'dart:collection';

import 'package:flutter/material.dart';

import 'bean/net_options.dart';
import 'dio_log.dart';
import 'page/log_widget.dart';

///网络请求日志列表
class HttpLogListWidget extends StatefulWidget {
  @override
  _HttpLogListWidgetState createState() => _HttpLogListWidgetState();
}

class _HttpLogListWidgetState extends State<HttpLogListWidget> {
  LinkedHashMap<String, NetOptions>? logMap;
  List<String>? keys;

  @override
  Widget build(BuildContext context) {
    logMap = LogPoolManager.getInstance().logMap;
    keys = LogPoolManager.getInstance().keys;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dio Console 日志',
          style: TextStyle(color: theme.textTheme.titleLarge?.color, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 1.0,
        iconTheme: theme.iconTheme,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              if (debugBtnIsShow()) {
                dismissDebugBtn();
              } else {
                showDebugBtn(context);
              }
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                child: Text(
                  debugBtnIsShow() ? '隐藏悬浮' : '显示悬浮',
                  style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              LogPoolManager.getInstance().clear();
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                child: Text(
                  '清空',
                  style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      body: logMap!.length < 1
          ? Center(
              child: Text('无请求日志'),
            )
          : ListView.builder(
              reverse: false,
              itemCount: keys!.length,
              itemBuilder: (BuildContext context, int index) {
                NetOptions item = logMap![keys![index]]!;
                return _buildItem(item);
              },
            ),
    );
  }

  ///构建请求的简易信息
  Widget _buildItem(NetOptions item) {
    var resOpt = item.resOptions;
    var reqOpt = item.reqOptions!;

    ///格式化请求时间
    var requestTime = getTimeStr1(reqOpt.requestTime!);

    Color? textColor = LogPoolManager.getInstance().isError(item) ? Colors.red : Theme.of(context).textTheme.titleLarge!.color;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LogWidget(item);
          }));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'url: ${reqOpt.url}',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 8),
              Divider(height: 2),
              SizedBox(height: 8),
              Text(
                'statusCode: ${resOpt?.statusCode}',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 8),
              Divider(height: 2),
              SizedBox(height: 8),
              Text(
                'requestTime: $requestTime    duration: ${resOpt?.duration ?? 0}ms',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
