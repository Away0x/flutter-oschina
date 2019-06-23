import 'package:http/http.dart' as http;

import 'package:oschina/constants/app.dart';

class Services {

  static const String API_ROOT = 'https://www.oschina.net';
  // 授权登录 ctrl shift u
  static const String OAUTH2_AUTHORIZE = API_ROOT + '/action/oauth2/authorize';

  static Future<String> httpGET(String url, {Map<String, dynamic> params}) async {
    var api = API_ROOT + url;
    
    if (params != null && params.isNotEmpty) {
      StringBuffer paramsStr = StringBuffer('');
      paramsStr.write('?');
      params.forEach((k, v) {
        paramsStr.write('$k=$v&');
      });
      api += paramsStr.toString().substring(0, paramsStr.length - 1); // 去掉最后的 &
    }

    try {
      http.Response resp = await http.get(api);

      return resp.body;
    } catch (e) {
      print("http get error: $e");
      return '';
    }
  }

  static Future<String> httpPOST(String url, {Map<String, dynamic> params}) async {
    try {
      http.Response resp = await http.post(API_ROOT + url, body: params);

      return resp.body;
    } catch (e) {
      print("http post error: $e");
      return '';
    }
  }

  // 授权登录
  Future<String> authorize() async {
    var resource = await httpGET('/action/oauth2/authorize');

    print(resource);
    return resource;
  }

}