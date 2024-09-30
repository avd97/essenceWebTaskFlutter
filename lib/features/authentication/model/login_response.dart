/// message : "Login successful"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJhYmhpLnBhbmRlMjE1QGdtYWlsLmNvbSIsImlhdCI6MTcyNzcyMTkzMywiZXhwIjoxNzI3NzI1NTMzfQ.GqYmPbZB3EwPrMwbjdBTDAjkuH7vZLvjATGteR29BL8"
/// user : {"id":1,"fullname":"Abhishek Deshpande","email":"abhi.pande215@gmail.com","mobile":"8857870272","photo":"uploads\\1727716891947-diwaliimages.jpg"}

class LoginResponse {
  LoginResponse({
    String? message,
    String? token,
    User? user,
  }) {
    _message = message;
    _token = token;
    _user = user;
  }

  LoginResponse.fromJson(dynamic json) {
    _message = json['message'];
    _token = json['token'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  String? _message;
  String? _token;
  User? _user;

  LoginResponse copyWith({
    String? message,
    String? token,
    User? user,
  }) =>
      LoginResponse(
        message: message ?? _message,
        token: token ?? _token,
        user: user ?? _user,
      );

  String? get message => _message;

  String? get token => _token;

  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['token'] = _token;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

/// id : 1
/// fullname : "Abhishek Deshpande"
/// email : "abhi.pande215@gmail.com"
/// mobile : "8857870272"
/// photo : "uploads\\1727716891947-diwaliimages.jpg"

class User {
  User({
    num? id,
    String? fullname,
    String? email,
    String? mobile,
    String? photo,
  }) {
    _id = id;
    _fullname = fullname;
    _email = email;
    _mobile = mobile;
    _photo = photo;
  }

  User.fromJson(dynamic json) {
    _id = json['id'] as int;
    _fullname = json['fullname'];
    _email = json['email'];
    _mobile = json['mobile'];
    _photo = json['photo'];
  }

  num? _id;
  String? _fullname;
  String? _email;
  String? _mobile;
  String? _photo;

  User copyWith({
    num? id,
    String? fullname,
    String? email,
    String? mobile,
    String? photo,
  }) =>
      User(
        id: id ?? _id,
        fullname: fullname ?? _fullname,
        email: email ?? _email,
        mobile: mobile ?? _mobile,
        photo: photo ?? _photo,
      );

  num? get id => _id;

  String? get fullname => _fullname;

  String? get email => _email;

  String? get mobile => _mobile;

  String? get photo => _photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['fullname'] = _fullname;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['photo'] = _photo;
    return map;
  }
}
