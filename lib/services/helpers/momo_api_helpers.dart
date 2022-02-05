import 'dart:convert';

import 'package:http/http.dart' as http;


class MomoApiHelpers{
 static Future<String> getCollectionUUID()async{
   var headers = {
		'Authorization': 'Bearer ${(MomoApiHelpers.getAccessToken() as AccessToken).accessToken}'
};
var request = http.Request('GET', Uri.parse('https://www.uuidgenerator.net/api/version4'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  String data = await response.stream.bytesToString();
		return (data);
}else{
  throw(Error);///please check this code again !!!!
}
 }
 static Future<AccessToken> getAccessToken()async{
    var headers = {
		'Ocp-Apim-Subscription-Key': 'b66795091e1842b5ad1c2a730bbd0db6',
		'Authorization': 'Basic NTQ2MzRmODYtNjU3NC00Nzc3LTg0NjUtNzFjMGI2MmY4NDkzOjJjMDdkYWI3NTVjZjQ5MjViMTE1ZTg0ZmU4ZDE0N2Jl'
};
var request = http.Request('POST', Uri.parse('https://sandbox.momodeveloper.mtn.com/collection/token/'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  String data = await response.stream.bytesToString();
		return (accessTokenFromJson(data));
}else{
  throw(Error);///please check this code again !!!!
}
  }

}

AccessToken accessTokenFromJson(String str) => AccessToken.fromJson(json.decode(str));

String accessTokenToJson(AccessToken data) => json.encode(data.toJson());

class AccessToken {
    AccessToken({
        required this.accessToken,
        required this.tokenType,
        required this.expiresIn,
    });

    String accessToken;
    String tokenType;
    int expiresIn;

    factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
    };
}