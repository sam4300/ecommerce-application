import 'dart:convert';

class User {
  final String id;
  final String password;
  final String email;
  final String name;
  final String address;
  final String type;
  final String token;
  User({
    required this.id,
    required this.password,
    required this.email,
    required this.name,
    required this.address,
    required this.type,
    required this.token,
  });

  User copyWith({
    String? id,
    String? password,
    String? email,
    String? name,
    String? address,
    String? type,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      password: password ?? this.password,
      email: email ?? this.email,
      name: name ?? this.name,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'password': password,
      'email': email,
      'name': name,
      'address': address,
      'type': type,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      password: map['password'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, password: $password, email: $email, name: $name, address: $address, type: $type, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.password == password &&
        other.email == email &&
        other.name == name &&
        other.address == address &&
        other.type == type &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        password.hashCode ^
        email.hashCode ^
        name.hashCode ^
        address.hashCode ^
        type.hashCode ^
        token.hashCode;
  }
}
