import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/compomats/shared_componat/componat.dart';
import 'package:project_udemy/layout/social_app/cubit/cubit.dart';
import 'package:project_udemy/layout/social_app/cubit/states.dart';
import 'package:project_udemy/models/social_app/social_user_model.dart';
import 'package:project_udemy/moudules/social_app/new_post/new_post_screen.dart';
import 'package:project_udemy/styles/icon_broken.dart';

import '../../compomats/shared_componat/constan.dart';
import '../../moudules/social_app/social_login/cubit/cubit.dart';

class SocialLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
              // IconButton(onPressed: ()
              // {
              //   SocialCubit.get(context).changeAppMode();
              // },
              //     icon: Icon(Icons.brightness_4_outlined)),

            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Location), label: 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting), label: 'Settings'),
              ]),
        );
      },
    );
  }
}
