import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/home_cubit/social_states.dart';
import '../../const.dart';
import '../../models/user_model.dart';
import '../../screens/chats/chats_screen.dart';
import '../../screens/home_screens/feeds_screen.dart';
import '../../screens/home_screens/post_screen.dart';
import '../../screens/home_screens/settings_screens/settings_screen.dart';
import '../../screens/home_screens/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(InitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

//Here For Home Screens

  List<Widget> screens = [
    PostScreen(),
    ChatsScreen(),
    FeedsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List titles = [
    'Home',
    'Chats',
    'Users ',
    'Settings ',
  ];
  int currentIndex = 2;

  void changeBottomNavigationBar(int index) {
    // if (index == 0) {
    //   emit(ChangeSocialNewsPostState());
    // } else {
    //   currentIndex = index;
    //   emit(ChangeBottomNavigationBarState());
    // }

    if (index == 1) {
      getAllUsers();
    }

    currentIndex = index;
    emit(ChangeBottomNavigationBarState());
  }

  UserModel? userModelData;

  void getUserData() {
    emit(GetDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModelData = UserModel.fromJson(value.data()!);
      // debugPrint(value.data());
      emit(GetDataSuccessfullyState());
      debugPrint('My username is ${userModelData!.username}');
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetDataErrorState(error: 'My Error is ${error.toString()}'));
    });
  }

  File? coverImage;

  Future picCoverImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(PickCoverImageSuccessState());
    } else {
      debugPrint('No Cover Image Selected ');
      emit(PickCoverImageErrorState());
    }
  }

  File? profileImage;

  Future picProfileImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      // print('Profile imags is $profileImage');
      //print('Profile file Segements is ${pickedFile.path}');

      ///data/user/0/com.social.social_app/cache/5fb94f18-e0f2-496d-a5a3-b755ba2d737e/1000070902.jpg
      emit(PickProfileImageSuccessState());
    } else {
      //print('No Profile Image Selected ');
      emit(PickProfileImageErrorState());
    }
  }

  // String profileUrl = '';

  void uploadProfileImage({
    required String username,
    required String bio,
    required String phone,
  }) {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((profileUrl) {
        //this.profileUrl = profileUrl;
        updateUserInformation(
          bio: bio,
          username: username,
          phone: phone,
          profileImage: profileUrl,
        );
        emit(UploadProfileImageSuccessState());
        // print('Profile Url IS $profileUrl');
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  // String coverUrl = '';

  void uploadCoverImage({
    required String username,
    required String bio,
    required String phone,
  }) {
    emit(UploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((coverUrl) {
        // this.coverUrl = coverUrl;
        updateUserInformation(
          bio: bio,
          username: username,
          phone: phone,
          coverImage: coverUrl,
        );
        emit(UploadCoverImageSuccessState());
        //print('Cover Url IS $coverUrl');
      }).catchError((error) {
        emit(UploadCoverImageSuccessState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String username,
  //   required String bio,
  //   required String phone,
  // }) {
  //   emit(UpdateProfileInformationLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if(coverImage != null &&profileImage != null)
  //     {
  //
  //     }
  //     else{
  //     updateUserInformation(phone: phone ,username: username ,bio: bio);
  //   }
  //
  //
  //
  // }

  void updateUserInformation({
    required String username,
    required String bio,
    required String phone,
    String? profileImage,
    String? coverImage,
  }) {
    emit(UpdateProfileInformationLoadingState());
    UserModel userModel = UserModel(
      username: username,
      bio: bio,
      uId: userModelData!.uId,
      phone: userModelData!.phone,
      email: userModelData!.email,
      image: profileImage ?? userModelData!.image,
      cover: coverImage ?? userModelData!.cover,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModelData!.uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
      // emit(UpdateProfileInformationSuccessState());
    }).catchError((error) {
      emit(UpdateProfileInformationErrorState());
    });
  }

  File? postImage;

  Future picPostImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);

      emit(UploadPostImageSuccessState());
    } else {
      // print('No Post Image Selected ');
      emit(UploadPostImageErrorState());
    }
  }

  void createPostWithImage({
    required String username,
    required String dateTime,
    required String postText,
  }) {
// emit(CreatePostWithImageLoadingState());
    emit(CreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file((postImage!.path)).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((postImage) {
        // print(postImage);

        createPost(
          username: username,
          dateTime: dateTime,
          postText: postText,
          postImage: postImage,
        );
        //emit(CreatePostWithImageSuccessState());
      }).catchError((error) {});
      emit(CreatePostWithImageErrorState());
    }).catchError((error) {
      emit(CreatePostWithImageErrorState());
    });
  }

  List<String> postsId = [];

  void createPost({
    required String username,
    required String dateTime,
    required String postText,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel postModel = PostModel(
        uId: userModelData!.uId,
        postText: postText,
        postImage: postImage ?? '',
        username: username,
        dateTime: dateTime,
        userProfileImage: userModelData!.image);
    // FirebaseFirestore.instance
    //     .collection('MyPosts')
    //     .add(postModel.toMap())
    //     .then((value) {
    //   if (myPosts.isNotEmpty) {
    //     myPosts = [];
    //     getMyPosts();
    //   } else {
    //     getMyPosts();
    //   }
    //
    //   emit(CreateMySuccessState());
    // }).catchError((error) {
    //   emit(CreateMyErrorState());
    // });

    FirebaseFirestore.instance
        .collection('Posts')
        .add(postModel.toMap())
        .then((value) {
      if (posts.isNotEmpty) {
        posts = [];
        getAllPosts();
      } else {
        getAllPosts();
      }

      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

//Get All Posts
  List<PostModel> posts = [];
  List<int> numberOfLikes = [];

  void getAllPosts() {
    emit(GetAllPostsLoadingState());
    //posts=[];
    FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('dateTime')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('Likes').get().then((value) {
          numberOfLikes.add(value.docs.length);
          // print(numberOfLikes);
          // print(postsId);
        }).catchError((error) {});

        // print(posts.length);
        // print(posts);
        postsId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
        emit(GetAllPostsSuccessState());
      });
    }).catchError((error) {
      //print(error.toString());
      emit(GetAllPostsErrorState(error: error.toString()));
    });
  }

  // List<PostModel> myPosts = [];
  //
  // void getMyPosts() {
  //   emit(GetMyPostsLoadingState());
  //   //posts=[];
  //   FirebaseFirestore.instance
  //       .collection('MyPosts')
  //       .orderBy('dateTime')
  //       .get()
  //       .then((value) {
  //     for (var element in value.docs) {
  //       myPosts.add(PostModel.fromJson(element.data()));
  //      // print(posts.length);
  //       //print(posts);
  //       emit(GetMyPostsSuccessState());
  //     }
  //   }).catchError((error) {
  //    // print(error.toString());
  //     emit(GetMyPostsErrorState(error: error.toString()));
  //   });
  // }

  void setPostsLikes(String postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Likes')
        .doc(userModelData!.uId)
        .set({'likes': true}).then((value) {
      emit(GetPostsLikesSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(GetPostsLikesErrorState(error: error.toString()));
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    emit(GetAllUsersLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModelData!.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
          // print(users.length);
        }
        emit(GetAllUsersSuccessState());
      }).catchError((error) {
        //print(error.toString());
        emit(GetAllUsersErrorState(error: error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: userModelData!.uId,
      receiverId: receiverId,
      text: text,
      dateTime: dateTime,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModelData!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModelData!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModelData!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(GetMessageSuccessState());
    });
  }
}
