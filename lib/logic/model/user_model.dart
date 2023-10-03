class User{
  int id;
  String email;
  String nickname;

  User({
    required this.id,
    required this.email,
    required this.nickname,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          nickname == other.nickname);

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ nickname.hashCode;

  @override
  String toString() {
    return 'User{ id: $id, email: $email, nickname: $nickname,}';
  }

  User copyWith({
    int? id,
    String? email,
    String? nickname,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'nickname': this.nickname,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      email: map['email'] as String,
      nickname: map['nickname'] as String,
    );
  }
}