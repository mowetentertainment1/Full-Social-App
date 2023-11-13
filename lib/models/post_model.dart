class PostModel {
  String? uId;

  String? postText;
  String? postImage;
  String? username;
  String? dateTime;
  String? userProfileImage;

  PostModel({
    required this.uId,
    required this.postText,
    this.postImage,
    required this.username,
    required this.dateTime,
    required this.userProfileImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    postText = json['postText'];
    postImage = json['postImage'];
    username = json['username'];
    dateTime = json['dateTime'];
    userProfileImage = json['userProfileImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'postText': postText,
      'postImage': postImage,
      'username': username,
      'dateTime': dateTime,
      'userProfileImage': userProfileImage,
    };
  }
}
