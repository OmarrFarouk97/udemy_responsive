import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/compomats/shared_componat/componat.dart';
import 'package:project_udemy/layout/social_app/cubit/cubit.dart';
import 'package:project_udemy/layout/social_app/cubit/states.dart';
import 'package:project_udemy/moudules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:project_udemy/styles/icon_broken.dart';

import '../../../compomats/shared_componat/constan.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 180,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0)),
                            image: DecorationImage(
                                image: NetworkImage('${userModel!.cover}'),
                                fit: BoxFit.cover)),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 51,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 48.0,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${userModel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                ' ${userModel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              ' Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '90',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              ' Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '354K',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              ' Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '253',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              ' Following',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Add Photos'),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        navigateTo(
                          context,
                          EditProfileScreen(),
                        );
                      },
                      child: Icon(
                        IconBroken.Edit,
                        size: 16,
                      )),
                ],
              ),
              defaultButton(text: 'LogOut', function: ()
              {
                signOutFromSocialApp(context);
              }),
              Row(
                children: [
                  OutlinedButton(onPressed: () {}, child: Text('follow')),
                  Spacer(),
                  OutlinedButton(onPressed: () {}, child: Text('unfollow')),
                ],
              ),

            ],
          ),
        );
      },
    );
  }
}
