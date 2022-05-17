import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/compomats/shared_componat/componat.dart';
import 'package:project_udemy/layout/social_app/cubit/cubit.dart';
import 'package:project_udemy/layout/social_app/cubit/states.dart';
import 'package:project_udemy/models/social_app/social_user_model.dart';
import 'package:project_udemy/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget
{


  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          //var postImage = SocialCubit.get(context).postImage;
          var userModel = SocialCubit.get(context).userModel;


          return Scaffold(
            appBar: AppBar(
              title: Text('Create Post'),
              leading: IconButton(
                icon: Icon(IconBroken.Arrow___Left_2),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                defaultTextBottom(
                    function: ()
                {
                  var now = DateTime.now();
                  if (SocialCubit.get(context).postImage==null)
                  {

                    SocialCubit.get(context).createPost(
                        dateTime: now.toString(),
                        text: textController.text);
                  }else
                    {
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text
                      );
                    }
                },
                  text: 'Post'
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if ( state is SocialCreatePostLoadingState)
                    LinearProgressIndicator(),
                  if ( state is SocialCreatePostLoadingState)
                    SizedBox(
                    height:10 ,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                           // 'https://img.freepik.com/free-photo/close-up-young-successful-man-smiling-camera-standing-casual-outfit-against-blue-background_1258-66609.jpg?t=st=1651290678~exp=1651291278~hmac=125144a738571eac41823cccae40b0420f2abd7cb1e7112c90c413e8d8d60e83&w=1060'
                       userModel!.image!
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          //'Omar Farouk',
                          userModel.name!,
                          style: TextStyle(
                              height: 1.2, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:20 ,),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                          hintText: 'what is in your mind...',
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: FileImage  (SocialCubit.get(context).postImage!),
                                fit: BoxFit.cover
                            ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.close,
                              size: 20,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height:20 ,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: ()
                            {
                              SocialCubit.get(context).getPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconBroken.Image,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('add photo'),
                              ],
                            )),
                      ),
                      Expanded(
                          child: TextButton(
                        onPressed: () {},
                        child: Text('# tags'),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
