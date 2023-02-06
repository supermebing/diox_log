import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///复制到粘贴板
copyClipboard(BuildContext context, String? value) {
  var snackBar = SnackBar(
      content: Text(
    '$value\n\n copy success to clipboard',
    style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color),
  ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  Clipboard.setData(ClipboardData(text: value ?? 'null'));
}
