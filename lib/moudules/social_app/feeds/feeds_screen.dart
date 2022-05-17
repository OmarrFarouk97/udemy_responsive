import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/layout/social_app/cubit/cubit.dart';
import 'package:project_udemy/layout/social_app/cubit/states.dart';
import 'package:project_udemy/models/social_app/post_model.dart';
import 'package:project_udemy/styles/colors.dart';
import 'package:project_udemy/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition:SocialCubit.get(context).posts.length >0 && SocialCubit.get(context).userModel != null,
          builder: (context)=> SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/cheerful-man-pointing-finger-left-advertise-product_176420-18862.jpg?t=st=1651290696~exp=1651291296~hmac=d8465b748ded8046cb203078d8939f7635088ca9809d79de482b30be63443e16&w=1060'),
                        fit: BoxFit.fill,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate with friends',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  itemCount: SocialCubit.get(context).posts.length,
                  separatorBuilder: ( context, index)=> SizedBox(
                    height: 8,
                  ),
                ),
                SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );
  }


  Widget buildPostItem( PostModel model,context,index)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                '${model.image}'),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: TextStyle(height: 1.2,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: defualtColor,
                          size: 18,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime} ',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(height: 1.5),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16.0,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          // SizedBox(
          //   height: 15,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //       vertical: 10
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 5),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               height: 15,
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software',
          //                 style: TextStyle(color: defualtColor),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 1),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               height: 15,
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#flutter',
          //                 style: TextStyle(color: defualtColor),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 2),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               height: 15,
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#Fit',
          //                 style: TextStyle(color: defualtColor),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 5),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               height: 15,
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#hardware',
          //                 style: TextStyle(color: defualtColor),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 5),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               height: 15,
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#hacker',
          //                 style: TextStyle(color: defualtColor),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 5),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               height: 15,
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software_development',
          //                 style: TextStyle(color: defualtColor),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage !='')
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage(
                          '${model.postImage}'),
                      fit: BoxFit.cover)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5
                      ),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 16,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 14,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                              '${SocialCubit.get(context).comment[index]}',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                    onTap: ()
                    {

                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 15
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16.0,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel!.image}'),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Write a comment.... ',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(),
                      ),

                    ],
                  ),
                  onTap: ()
                  {
                    SocialCubit.get(context).commentPost(SocialCubit.get(context).postsId[index]);

                  },
                ),
              ),
              InkWell(
                onTap: ()
                {
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);

                },
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      size: 16,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                        'Likes',
                        style: Theme.of(context).textTheme.caption),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );

}
