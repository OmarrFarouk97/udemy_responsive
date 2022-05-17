import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/compomats/shared_componat/componat.dart';
import 'package:project_udemy/layout/social_app/cubit/cubit.dart';
import 'package:project_udemy/layout/social_app/cubit/states.dart';
import 'package:project_udemy/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Text('Edit Profile'),
            actions: [
              defaultTextBottom(
                  function: () {
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  text: 'Update'),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 180,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0)),
                                    image: DecorationImage(
                                        image: coverImage == null
                                            ? NetworkImage('${userModel.cover}')
                                            : FileImage(coverImage)
                                                as ImageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 20,
                                    ),
                                  )),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 51,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 48.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: CircleAvatar(
                                  radius: 16,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 18,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                  Row(
                    children: [
                      if (SocialCubit.get(context).profileImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  text: 'Upload profile',
                                function: ()
                                {
                                  SocialCubit.get(context).upLoadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text
                                  );
                                },
                              ),
                              if (state is SocialUserUpdateLoadingState)
                                SizedBox(
                                height: 5,
                              ),
                              if (state is SocialUserUpdateLoadingState)
                              LinearProgressIndicator(),
                            ],
                          )
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (SocialCubit.get(context).coverImage != null)
                      Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  text: 'Upload Cover ',
                                function: ()
                                {
                                  SocialCubit.get(context).upLoadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text
                                  );
                                },
                              ),
                              if (state is SocialUserUpdateLoadingState)
                                SizedBox(
                                height: 5,
                              ),
                              if (state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //if (SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: IconBroken.User),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'phone number must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: IconBroken.Call),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'bio must not be empty';
                        }
                        return null;
                      },
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
