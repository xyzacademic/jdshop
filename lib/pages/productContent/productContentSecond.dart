import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../widget/loadingWidget.dart';

class ProductContentSecond extends StatefulWidget {
  List _productContentList;
  ProductContentSecond(this._productContentList, {Key? key}) : super(key: key);

  @override
  State<ProductContentSecond> createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond> with AutomaticKeepAliveClientMixin {



  bool _flag = true;
  var _id;
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _id = widget._productContentList[0].sId;

  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String url = "https://jdmall.itying.com/pcontent?id=${_id}";
    return Container(
      child: Column(
        children: [
          _flag? LoadingWidget(): Text(""),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(url)),
              onProgressChanged:
              (InAppWebViewController controller, int progress){
                print(progress / 100);
                if(progress / 100 > 0.9999){
                  setState((){
                    _flag = false;
                  });
                }
              },
            )
          )

        ],
      )
    );
  }
}
