import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_udemy/compomats/shared_componat/constan.dart';
import 'package:project_udemy/layout/social_app/cubit/states.dart';
import 'package:project_udemy/models/social_app/message_model.dart';
import 'package:project_udemy/models/social_app/social_user_model.dart';
import 'package:project_udemy/moudules/social_app/chats/chats_screen.dart';
import 'package:project_udemy/moudules/social_app/feeds/feeds_screen.dart';
import 'package:project_udemy/moudules/social_app/new_post/new_post_screen.dart';
import 'package:project_udemy/moudules/social_app/settings/settings_screen.dart';
import 'package:project_udemy/moudules/social_app/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../models/social_app/post_model.dart';
import '../../../network/local/shared_preferences.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);

      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index)
  {
    if (index == 1 )
      getUsers();
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
    }
    emit(SocialChangeBottomNavState());
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickerFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickerFile != null) {
      profileImage = File(pickerFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('NO image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickerFile = await picker.getImage(
      source: ImageSource.camera,
    );
    if (pickerFile != null) {
      coverImage = File(pickerFile.path);
      emit(SocialProfileCoverPickedSuccessState());
    } else {
      print('NO image selected');
      emit(SocialProfileCoverPickedErrorState());
    }
  }

  void upLoadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void upLoadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    //emit(SocialUserUpdateLoadingState());
    // if (coverImage != null)
    // {
    //   upLoadCoverImage();
    // }else if ( profileImage != null)
    //   {
    //     upLoadCoverImage();
    //   } else if (coverImage != null && profileImage !=null)
    //   {
    //
    //   }
    //     else
    //     {
    //
    //     }
    SocialUserModel? model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      uId: uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap()!)
        .then((value) {
      getUserData();
    }).catchError((onError) {
      emit(SocialUserUpdateErrorState());
    });
  }

   File? postImage;
 // File postImage= File('');

  Future<void> getPostImage() async {
    final pickerFile = await picker.getImage(
      source: ImageSource.camera,
    );
    if (pickerFile != null) {
      postImage = File(pickerFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('NO image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage()
  {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel? model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap()!)
        .then((value)
    {
      emit(SocialCreatePostSuccessState());
    }
    ).catchError((onError) {
      emit(SocialCreatePostErrorState());
    });
  }



  List<PostModel>posts =[];
  List<String>postsId =[];
  List<int> likes=[];
  List<int> comment=[];

  void getPosts()
  {
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value)
    {
      value.docs.forEach((element)
      {
       element.reference
           .collection('likes')
           .get()
           .then((value)
       {
         comment.add(value.docs.length);
         likes.add(value.docs.length);
         postsId.add(element.id);
         posts.add(PostModel.fromJson(element.data()));
       })
           .catchError((error){});
      });
          emit(SocialGetPostsSuccessState());
    })
        .catchError((error)
    {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }


  void likePost(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId).collection('likes')
        .doc(userModel!.uId)
        .set({
      'like':true,
    })
        .then((value) {
          emit(SocialLikePostsSuccessState());
    })
        .catchError((error){
          emit(SocialLikePostsErrorState(error.toString()));
    });
  }



  void commentPost(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId).collection('comment')
        .doc(userModel!.uId)
        .set({
      'comment':true,
    })
        .then((value) {
      emit(SocialCommentPostsSuccessState());
    })
        .catchError((error){
      emit(SocialCommentPostsErrorState(error.toString()));
    });
  }

List<SocialUserModel> users=[] ;
  void getUsers()
  {
    if (users.length ==0)
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value)
    {
      value.docs.forEach((element)
      {
        if (element.data()['uId'] != userModel!.uId)
        users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUsersSuccessState());
    })
        .catchError((error)
    {
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }


  void sendMessage({
  required String receiverId,
    required String dateTime,
    required String text,

})
  {

    // bn3ml crate le model mn class model 3shan nwade data dah m3nah eni 3mlt object
    MessageModel model= MessageModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );
    // hena b2a hnwade l object da
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel!.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(model.toMap()!)
    .then((value) {
      emit(SocialSendMessageSuccessState());
    })
    .catchError((error){
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap()!)
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState());
    });

  }

  List<MessageModel> messages =[];
  void getMessage({
    required String receiverId,

  })
  {

    // snapshot dah 3bara 3n tabor mn l future mash zai eno bygeb l data mara wa7da fel future
    //we b3den by2of la dah byfdl mkml  -- we listen byshof eh l t8yorat eli bt7sl feh
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
    .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      // lazem asafer l list wna da5el 3shan l listen bygeb l message kulha tani mn l awl
      messages =[];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
    emit(SocialGetMessageSuccessState());
    });
  }



  // bool isDark= true;
  //
  // void changeAppMode({ bool? fromShared}) {
  //   if (fromShared != null) {
  //     isDark = fromShared;
  //     emit(AppChangeSocialMode());
  //   } else {
  //     isDark = !isDark;
  //     CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
  //       emit(AppChangeSocialMode());
  //     });
  //   }
  // }

}

