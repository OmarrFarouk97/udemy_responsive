import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/models/social_app/social_user_model.dart';
import 'package:project_udemy/moudules/social_app/social_register/cubit/states.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context)=> BlocProvider.of(context);


  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(SocialRegisterLoadingState());
    // ba5od object mn firebaseauth . instance we feha method esmha create user deh b2a

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value)
    {

      userCreate(
        uId: value.user!.uid,
        email: email,
        phone: phone,
        name: name,
      );
    }).catchError((error)
    {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }


  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,

  })
  {
    SocialUserModel? model= SocialUserModel(
        email:email,
        name:name,
        phone:phone,
        uId:uId,
      bio:'Write Your Bio...',
      cover: 'https://img.freepik.com/free-photo/close-up-young-successful-man-smiling-camera-standing-casual-outfit-against-blue-background_1258-66609.jpg?t=st=1651290678~exp=1651291278~hmac=125144a738571eac41823cccae40b0420f2abd7cb1e7112c90c413e8d8d60e83&w=1060',
      image: 'https://img.freepik.com/free-photo/close-up-young-successful-man-smiling-camera-standing-casual-outfit-against-blue-background_1258-66609.jpg?t=st=1651290678~exp=1651291278~hmac=125144a738571eac41823cccae40b0420f2abd7cb1e7112c90c413e8d8d60e83&w=1060',
      isEmailVerified:false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap()!).then((value) {
          emit(SocialCreateUserSuccessState());
    }
    ).catchError((error)
    {
      emit(SocialCreateUserErrorState(error.toString()));

    });


  }


 IconData suffix= Icons.visibility ;
  bool isPassword=true;
  void changePasswordVisibility ()
  {
    suffix =isPassword ?Icons.visibility_off_outlined  :Icons.visibility   ;
    isPassword =!isPassword;
    emit(SocialRegisterChangePasswordVisibilityState());

  }
}
