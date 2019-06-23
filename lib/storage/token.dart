import 'package:oschina/models/token.dart';

import './storage.dart';


class TokenStorage {
  
  static const String key = 'access_token';
  static TokenModel store;

  static setToken(TokenModel model) {
    store = model;
    Storage.setJSON(key, model.toJson());
  }

  static Future<TokenModel> getToken() async {
    if (store != null) {
      return store;
    }

    var map = await Storage.getJSON(key);
    var model = TokenModel.fromJson(map);
    store = model;

    return store;
  }

  static removeToken() {
    Storage.remove(key);
    store = null;
  }

  // 是否登录
  static Future<bool> isLogin() async {
    var model = await getToken();

    return model != null && model.accessToken != null && model.accessToken.isNotEmpty;
  }

}