class TokenModel {
  String accessToken;
  String refreshToken;
  String tokenType;
  int expiresIn;
  int uid;

  TokenModel(
      {this.accessToken,
      this.refreshToken,
      this.tokenType,
      this.expiresIn,
      this.uid});

  TokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['uid'] = this.uid;
    return data;
  }
}