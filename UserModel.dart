class UserModel {
  String? user_id;
  String? user_name;
  String? email;
  String? password;
  String?gender;
  String?level;

  UserModel(this.user_name, this.email, this.user_id,this.level, this.password,this.gender);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_name': user_name,
      'email': email,
      'user_id': user_id,
      'level':level,
      'password': password,
      'gender':gender
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    user_name = map['user_name'];
    email = map['email'];
    user_id = map['user_id'];
    level=map['level'];
    password = map['password'];
    gender=map['gender'];
  }
}