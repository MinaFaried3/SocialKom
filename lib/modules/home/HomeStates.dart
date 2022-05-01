abstract class HomeStates {}

class HomeInitState extends HomeStates {}

class GetUserLoadingState extends HomeStates {}

class GetUserSuccessState extends HomeStates {}

class GetUserErrorState extends HomeStates {
  final CastError error;
  GetUserErrorState(this.error);
}

class GetUserFriendLoadingState extends HomeStates {}

class GetUserFriendSuccessState extends HomeStates {}

class GetUserFriendErrorState extends HomeStates {
  final String error;
  GetUserFriendErrorState(this.error);
}

class ChangeBottomNavState extends HomeStates {}

class ChangeToPostNavState extends HomeStates {}

class ProfileImagePickedSuccessState extends HomeStates {}

class ProfileImagePickedErrorState extends HomeStates {}

class CoverImagePickedSuccessState extends HomeStates {}

class CoverImagePickedErrorState extends HomeStates {}

class UploadProfileImagePickedSuccessState extends HomeStates {}

class UploadProfileImagePickedErrorState extends HomeStates {}

class UploadCoverImagePickedSuccessState extends HomeStates {}

class UploadCoverImagePickedErrorState extends HomeStates {}

class UpdateErrorState extends HomeStates {}

class UpdateSuccessState extends HomeStates {}

class UpdateLoadingState extends HomeStates {}

class UpdateProfileLoadingState extends HomeStates {}

class UpdateCoverLoadingState extends HomeStates {}
// create post

class CreatePostSuccessState extends HomeStates {}

class CreatePostErrorState extends HomeStates {}

class CreatePostLoadingState extends HomeStates {}

class CreatePostImagePickedSuccessState extends HomeStates {}

class CreatePostImagePickedErrorState extends HomeStates {}

class RemovePostImagePickedSuccessState extends HomeStates {}
// create story

class CreateStorySuccessState extends HomeStates {}

class CreateStoryErrorState extends HomeStates {}

class CreateStoryLoadingState extends HomeStates {}

class CreateStoryImagePickedSuccessState extends HomeStates {}

class CreateStoryImagePickedErrorState extends HomeStates {}

class RemoveStoryImagePickedSuccessState extends HomeStates {}

class AddTextSuccessState extends HomeStates {}

class CloseCreateStoryScreenState extends HomeStates {}

// get post

class GetPostLoadingState extends HomeStates {}

class GetPostSuccessState extends HomeStates {}

class GetPostErrorState extends HomeStates {
  final String error;
  GetPostErrorState(this.error);
}

class GetPostPersonalLoadingState extends HomeStates {}

class GetPostPersonalSuccessState extends HomeStates {}

class GetPostPersonalErrorState extends HomeStates {
  final String error;
  GetPostPersonalErrorState(this.error);
}

class GetPostFriendsLoadingState extends HomeStates {}

class GetPostFriendsSuccessState extends HomeStates {}

class GetPostFriendsErrorState extends HomeStates {
  final String error;
  GetPostFriendsErrorState(this.error);
}

//get story
class GetStoryPersonalLoadingState extends HomeStates {}

class GetStoryPersonalSuccessState extends HomeStates {}

class GetStoryPersonalErrorState extends HomeStates {
  final String error;
  GetStoryPersonalErrorState(this.error);
}

class GetStoryLoadingState extends HomeStates {}

class GetStorySuccessState extends HomeStates {}

class GetStoryErrorState extends HomeStates {
  final String error;
  GetStoryErrorState(this.error);
}

//likes
class LikesSuccessState extends HomeStates {}

class LikesErrorState extends HomeStates {
  final String error;
  LikesErrorState(this.error);
}

//comments
class CreateCommentSuccessState extends HomeStates {}

class CreateCommentErrorState extends HomeStates {
  final String error;
  CreateCommentErrorState(this.error);
}

class GetCommentsLoadingState extends HomeStates {}

class GetCommentsSuccessState extends HomeStates {}

class GetCommentsErrorState extends HomeStates {
  final String error;
  GetCommentsErrorState(this.error);
}

// notification
class GetNotificationsLoadingState extends HomeStates {}

class GetNotificationsSuccessState extends HomeStates {}

class GetNotificationsErrorState extends HomeStates {
  final String error;
  GetNotificationsErrorState(this.error);
}

// chats user
class GetAllChatUserLoadingState extends HomeStates {}

class GetAllChatUserSuccessState extends HomeStates {}

class GetAllChatUserErrorState extends HomeStates {
  final String error;
  GetAllChatUserErrorState(this.error);
}

class GetAllSearchUserLoadingState extends HomeStates {}

class GetAllSearchUserSuccessState extends HomeStates {}

class GetAllSearchUserErrorState extends HomeStates {
  final String error;
  GetAllSearchUserErrorState(this.error);
}

class ee {}

//message
class SendingMessageSuccessState extends HomeStates {}

class SendingMessageErrorState extends HomeStates {}

class GetMessageSuccessState extends HomeStates {}

class GetMessageSuccessState2 extends HomeStates {}

class GetMessageErrorState extends HomeStates {}

class ChangeMessageMicButtonState extends HomeStates {}

class ShowCommentButtonState extends HomeStates {}

class HideCommentButtonState extends HomeStates {}

class OpenChatState extends HomeStates {}

class ChangeSwitchThemeState extends HomeStates {}

class ChangeMenuItemState extends HomeStates {}

class ChangeMenuScreenState extends HomeStates {}

class TranslateTextState extends HomeStates {}

class TranslateTextErrorState extends HomeStates {}

class ShowTranslateTextState extends HomeStates {}

// savePost

class SavePostSuccessState extends HomeStates {}

class SavePostErrorState extends HomeStates {}

class GetSavedPostLoadingState extends HomeStates {}

class GetSavedPostSuccessState extends HomeStates {}

class GetSavedPostErrorState extends HomeStates {}

// save to gallery

class SavedToGallerySuccessState extends HomeStates {}

class SavedToGalleryErrorState extends HomeStates {}

class SavedToGalleryLoadingState extends HomeStates {}

// edit profile

class EditPostLoadingState extends HomeStates {}

class EditPostSuccessState extends HomeStates {}

class EditPostErrorState extends HomeStates {}

class ChangeThemeState extends HomeStates {}
