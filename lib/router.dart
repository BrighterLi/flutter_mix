import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_mix/component/utils/constant.dart';
import 'package:flutter_mix/component/utils/bridge.dart';
import 'package:flutter_mix/page/index/index.dart';


class Router extends StatefulWidget {
  Router();

  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router> {
  Map _routerConfigMap;

  @override
  void initState() {
    if (Platform.isAndroid) {
      //Android主动向native端请求路由相关数据
      getRouterFromAndroid();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return createPageWidget();
  }

  Widget createPageWidget() {
    String routerKey;
    if (_routerConfigMap != null) {
      routerKey = _routerConfigMap[Constant.ROUTER_KEY];
    }
    print('bright#router#routerKey: $routerKey');
    switch (routerKey) {
      case 'home':
        return HomePage();
      default:
        return Container(
          child: Text('11111111111'),
        );
    }
  }

  //从Native端获取数据
  Future<void> getRouterFromAndroid() async {
    try {
      Map result =
          await Bridge.methodChannel.invokeMapMethod('getDataFromNative');
      if (result != null) {
        setState(() {
          _routerConfigMap = result;
        });
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
