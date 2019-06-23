import 'dart:convert';
import 'package:http/http.dart' as http;

class Services {

  static const String API_ROOT = 'https://www.oschina.net';
  // 授权登录 ctrl shift u
  static const String OAUTH2_AUTHORIZE = API_ROOT + '/action/oauth2/authorize';

  static Map<String, dynamic> _resolveResp(String resp) {
    if (resp != null && resp.isNotEmpty) {
      Map<String, dynamic> map = json.decode(resp );

      return map ?? {}; 
    }

    return {};
  }

  static Future<Map<String, dynamic>> httpGET(String url, {Map<String, dynamic> params}) async {
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

      return _resolveResp(resp.body);
    } catch (e) {
      print("http get error: $e");
      return {};
    }
  }

  static Future<Map<String, dynamic>> httpPOST(String url, {Map<String, dynamic> params}) async {
    try {
      http.Response resp = await http.post(API_ROOT + url, body: params);

      return _resolveResp(resp.body);
    } catch (e) {
      print("http post error: $e");
      return {};
    }
  }

}

class ActionResponse<T> {

  final bool status;
  final String message;
  final T data;

  ActionResponse({
    this.status,
    this.message,
    this.data,
  });

}