/// message : "User already exists"

class RegistrationResponse {
  RegistrationResponse({
      String? message,}){
    _message = message;
}

  RegistrationResponse.fromJson(dynamic json) {
    _message = json['message'];
  }
  String? _message;
RegistrationResponse copyWith({  String? message,
}) => RegistrationResponse(  message: message ?? _message,
);
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }

}