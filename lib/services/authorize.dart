import 'package:oschina/constants/app.dart';

import 'package:oschina/models/token.dart';
import 'package:oschina/storage/token.dart';

import './services.dart';

class AuthorizeService {

  // OpenAPI 授权登录页面
  static const String authorizeAPI = Services.OAUTH2_AUTHORIZE +
      '?response_type=code&client_id=${AppInfo.CLIENT_ID}&redirect_uri=${AppInfo.REDIRECT_URI}';

  // authorization_code 方式获取 AccessToken
  static Future<ActionResponse> getToken(String code) async {
    var resource = await Services.httpPOST('/action/openapi/token', params: {
      'client_id': AppInfo.CLIENT_ID,
      'client_secret': AppInfo.CLIENT_SECRET,
      'grant_type': 'authorization_code',
      'code': code,
    });

    // print(resource);
    if (resource['error'] != null) {
      return ActionResponse(status: false, message: resource['error_description']);
    }

    try {
      var model = TokenModel.fromJson(resource);
      // 保存 token 信息
      TokenStorage.setToken(model);
      return ActionResponse<TokenModel>(status: true, data: model);
    } catch (e) {
      print('AuthorizeService getToken error: $e');
      return ActionResponse(status: false, message: '获取数据失败');
    }
  }

}