class UserModel {
  String? uId;
  String? image;
  String? cover;
  String? username;
  String? email;
  String? phone;
  String? bio;

  UserModel({
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.username,
    this.email,
    this.phone,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
      'username': username,
      'email': email,
      'phone': phone,
    };
  }
}
