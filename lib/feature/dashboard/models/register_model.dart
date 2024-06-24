class RegisterModel {
  RegisterModel({
    int? id,
    String? token,
  }) {
    _id = id;
    _token = token;
  }

  RegisterModel.fromJson(dynamic json) {
    _id = json['id'];
    _token = json['token'];
  }
  int? _id;
  String? _token;
  RegisterModel copyWith({
    int? id,
    String? token,
  }) =>
      RegisterModel(
        id: id ?? _id,
        token: token ?? _token,
      );
  int? get id => _id;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['token'] = _token;
    return map;
  }
}
