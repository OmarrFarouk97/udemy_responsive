import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/layout/social_app/cubit/cubit.dart';
import 'package:project_udemy/layout/social_app/cubit/states.dart';
import 'package:project_udemy/models/social_app/message_model.dart';
import 'package:project_udemy/models/social_app/social_user_model.dart';
import 'package:project_udemy/styles/colors.dart';
import 'package:project_udemy/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {

  SocialUserModel? userModel;
  ChatDetailsScreen({ this.userModel}) ;

  var messageController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessage(receiverId: userModel!.uId!);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener:(context, state) {},
          builder: (context,state)
          {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          userModel!.image!
                      ),
                    ),
                    SizedBox(
                      width:15 ,
                    ),
                    Text(
                      userModel!.name!,
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition:SocialCubit.get(context).messages.length >0 ,
                builder: (context)=> Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                     Expanded(
                       child: ListView.separated(
                           itemBuilder: (context,index)
                           {
                             var message =SocialCubit.get(context).messages[index];
                             if (SocialCubit.get(context).userModel!.uId == message.senderId) {
                               return buildMyMessage(message);
                             }
                             return buildMessage(message);
                           },
                           separatorBuilder: (context,index)=>SizedBox(
                             height: 15,
                           ),
                            itemCount: SocialCubit.get(context).messages.length
                       ),
                     ),
                      SizedBox(height:20 ,),
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
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey[300]!,

                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [

                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here ..'
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              color: defualtColor,
                              child: MaterialButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: userModel!.uId!,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  IconBroken.Send,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 40,
                              color: defualtColor,
                              child: MaterialButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).getPostImage();
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  IconBroken.Image,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context)=> Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
      
    );
  }
// b3ml feh gowa dah 3shan yst2bel 3shan na kont b3to fo2
  Widget  buildMessage ( MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          )
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
          model.text!
      ),
    ),
  );
  Widget  buildMyMessage ( MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: defualtColor.withOpacity(.2),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          )
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
          model.text!
      ),
    ),
  );

}
