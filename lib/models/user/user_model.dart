class UserModel {
  int? id;
  String? role;
  String? name;
  String? email;
  String? password;

  UserModel({this.id, this.name, this.email, this.password, this.role});
  UserModel.empty();

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'role': role,
      'name': name,
      'email': email,
      'password': password
    };
  }
  
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'],
      role: json['role'],
      name: json['name'],
      email: json['email'],
      password: json['password']
    );
  }
}