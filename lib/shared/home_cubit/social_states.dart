abstract class SocialStates {}

class InitialState extends SocialStates {}

class ChangeBottomNavigationBarState extends SocialStates {}

class ChangeSocialNewsPostState extends SocialStates {}

class RemoveUIdState extends SocialStates {}

class GetDataLoadingState extends SocialStates {}

class GetDataSuccessfullyState extends SocialStates {}

class GetDataErrorState extends SocialStates {
  final dynamic error;

  GetDataErrorState({required this.error});
}

//Pick Profile Image
class PickProfileImageSuccessState extends SocialStates {}

class PickProfileImageErrorState extends SocialStates {}

//Pick Cover Image
class PickCoverImageSuccessState extends SocialStates {}

class PickCoverImageErrorState extends SocialStates {}

//Upload Profile Image
class UploadProfileImageLoadingState extends SocialStates {}

class UploadProfileImageSuccessState extends SocialStates {}

class UploadProfileImageErrorState extends SocialStates {}

//Upload Cover Image
class UploadCoverImageLoadingState extends SocialStates {}

class UploadCoverImageSuccessState extends SocialStates {}

class UploadCoverImageErrorState extends SocialStates {}

class UpdateProfileInformationLoadingState extends SocialStates {}

class UpdateProfileInformationSuccessState extends SocialStates {}

class UpdateProfileInformationErrorState extends SocialStates {}

//Create New Post

class CreatePostLoadingState extends SocialStates {}

class CreatePostSuccessState extends SocialStates {}

class CreatePostErrorState extends SocialStates {}

//Create My Post

class CreateMyLoadingState extends SocialStates {}

class CreateMySuccessState extends SocialStates {}

class CreateMyErrorState extends SocialStates {}

//Upload Post Image

class UploadPostImageSuccessState extends SocialStates {}

class UploadPostImageErrorState extends SocialStates {}

//Create Post With Image

class CreatePostWithImageLoadingState extends SocialStates {}

class CreatePostWithImageSuccessState extends SocialStates {}

class CreatePostWithImageErrorState extends SocialStates {}

class RemovePostImageState extends SocialStates {}

//Get ALl Posts

class GetAllPostsLoadingState extends SocialStates {}

class GetAllPostsSuccessState extends SocialStates {}

class GetAllPostsErrorState extends SocialStates {
  final String error;

  GetAllPostsErrorState({required this.error});
}

//Get My Posts

class GetMyPostsLoadingState extends SocialStates {}

class GetMyPostsSuccessState extends SocialStates {}

class GetMyPostsErrorState extends SocialStates {
  final String error;

  GetMyPostsErrorState({required this.error});
}

class GetPostsLikesSuccessState extends SocialStates {}

class GetPostsLikesErrorState extends SocialStates {
  final String error;

  GetPostsLikesErrorState({required this.error});
}

class GetAllUsersLoadingState extends SocialStates {}

class GetAllUsersSuccessState extends SocialStates {}

class GetAllUsersErrorState extends SocialStates {
  final String error;

  GetAllUsersErrorState({required this.error});
}

//Chat

class SendMessageSuccessState extends SocialStates {}

class SendMessageErrorState extends SocialStates {}

class GetMessageSuccessState extends SocialStates {}
