class UserLocal {
  String? userName;
  String? email;
  String? avatar;

  UserLocal({
    this.userName,
    this.email,
    this.avatar,
  });

  UserLocal.fromDbMap(Map<String, dynamic>? obj) {
    avatar = obj?['avatar'];
    email = obj?['email'];
    userName = obj?['userName'];
  }

  Map<String, dynamic> toDbMap() {
    return <String, dynamic>{
      'userName': userName,
      'email': email,
      'avatar': avatar,
    };
  }
}
