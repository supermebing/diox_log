import 'package:dio5_log/bean/net_options.dart';
import 'package:dio5_log/dio_log.dart';
import 'package:flutter/material.dart';

class LogResponseWidget extends StatefulWidget {
  final NetOptions netOptions;

  LogResponseWidget(this.netOptions);

  @override
  _LogResponseWidgetState createState() => _LogResponseWidgetState();
}

class _LogResponseWidgetState extends State<LogResponseWidget>
    with AutomaticKeepAliveClientMixin {
  bool isShowAll = false;
  double fontSize = 14;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var response = widget.netOptions.resOptions;
    var json = response?.data ?? 'no response';
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 10),
            Text(
              isShowAll ? '全部折叠' : '展开全部',
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
            Switch(
              inactiveThumbColor: Colors.grey.shade100,
              inactiveTrackColor: Colors.grey.shade400,
              value: isShowAll,
              onChanged: (check) {
                isShowAll = check;

                setState(() {});
              },
            ),
            Expanded(
              child: Slider(
                value: fontSize,
                max: 30,
                min: 1,
                onChanged: (v) {
                  fontSize = v;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Text(
          'Tip: 长按一个键将值复制到剪贴板',
          style: TextStyle(
            fontSize: 10,
            color: Colors.red,
          ),
        ),
        _buildJsonView('headers:', response?.headers),
        _buildJsonView('response.data:', json),
      ],
    ));
  }

  ///构建json树的展示
  Widget _buildJsonView(key, json) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            copyClipboard(context, toJson(json));
          },
          child: Text('复制 json'),
        ),
        Text(
          '$key',
          style: TextStyle(
            fontSize: fontSize,
            height: 1.4,
          ),
        ),
        JsonView(
          json: json,
          isShowAll: isShowAll,
          fontSize: fontSize,
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
