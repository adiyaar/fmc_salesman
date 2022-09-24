import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CostInvoice extends StatefulWidget {
  final String pagename;
  final String id;
  CostInvoice({Key key, @required this.pagename, @required this.id}) : super(key: key);

  @override
  State<CostInvoice> createState() => _CostInvoiceState();
}

class _CostInvoiceState extends State<CostInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl:
            'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/costinvoice.php?pagename=${widget.pagename}&id=${widget.id}',
        onProgress: (val) {
          return CircularProgressIndicator.adaptive(
            value: val.toDouble(),
          );
        },
      ),
    );
  }
}
