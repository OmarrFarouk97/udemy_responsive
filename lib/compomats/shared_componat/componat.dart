

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_udemy/compomats/shared_componat/cubit/cubit2.dart';
import 'package:project_udemy/layout/shop_app/cubit/cubit.dart';
import 'package:project_udemy/styles/colors.dart';
import 'package:project_udemy/styles/icon_broken.dart';

import '../../moudules/news_app/web_view/web_view_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 10.0,
  required String text,
  required Function function,
}) =>
    Container(
      height: 40,
      width: width,
      child: MaterialButton(
        onPressed:(){
          function();
        } ,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
   onSubmit,
   onChange,
  required validator,
  required String label,
  required IconData prefix,
   IconData? suffix,
  bool isPassword =false,
  suffixPressed,
  onTab,

})=> TextFormField(
  controller:controller ,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  onTap:onTab,
  validator: validator,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
        prefix
    ),
    suffixIcon: suffix != null? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
          suffix
      ),
    ) : null,
    border: OutlineInputBorder(),
  ),
);


// 3shan a5leh ya3ml y sweb 3shan yms7 a3mlha be dissmissibal we lazm m3aha onDissmissed: (direction ) {}, key  we lazm tb2a string
 Widget  buildTaskItem ( Map model, context )
 => Dismissible(

   key: Key(model['id'].toString()),
   child: Padding(
     padding: const EdgeInsets.all(15.0),
     child: Row(
       children:  [
         CircleAvatar(
           backgroundColor: Colors.blueGrey,
           radius: 40,
           child: Text(
               '${model['time']}',
           ),

         ),
         SizedBox(
           width:20.0 ,
         ),
         Expanded(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 '${model['title']}',
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 18.0,
                 ),
               ),
               Text(
                 '${model['date']}',
                 style: TextStyle(
                     color: Colors.grey
                 ),
               ),


             ],
           ),
         ),
         SizedBox(
           width:20.0 ,
         ),
         IconButton(
             onPressed: ()
         {
           AppCubit.get(context).updateData(status: 'done', id: model['id']);

         }, icon:Icon(
               Icons.check_box,
               color: Colors.green,
             )),
         IconButton(
             onPressed: ()
             {
               AppCubit.get(context).updateData(status: 'archived', id: model['id']);

             },
             icon:Icon(
               Icons.archive_outlined,
               color: Colors.black45,
             )),
         IconButton(
             onPressed: ()
             {
               AppCubit.get(context).updateData(status: 'new', id: model['id']);

             },
             icon:Icon(
               Icons.keyboard_return,
               color: Colors.black45,
             )),

       ],
     ),
   ),
   onDismissed: (direction)
   {
     AppCubit.get(context).deletData(id: model['id']);

   },
 );



 Widget tasksBuilder ({
  required List<Map> tasks
})=> ConditionalBuilder(
   condition: tasks.length>0,
   builder: (context)=> ListView.separated(
     itemBuilder: (context, index) => buildTaskItem(tasks[index],context) ,
     separatorBuilder: (context, index)=>myDivider (),
     itemCount: tasks.length,
   ),
   fallback: (context)=> Center(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Icon(
           Icons.menu,
           size: 100.0,
           color: Colors.blueGrey,
         ),
         Text(
           'No Tasks Yet, Please Add Some Tasks',
           style: TextStyle(
               fontSize: 16.0,
               fontWeight: FontWeight.bold
           ),
         ),
       ],
     ),
   ),
 );


 Widget myDivider ()=> Padding(
   padding: const EdgeInsets.all(8.0),
   child: Container(
     width: double.infinity,
     height: 2,
     color: Colors.grey,
   ),
 );



 Widget articleBuilder(list,context, {isSerach =false})=> ConditionalBuilder(
   condition: list.length>0,
   builder: (context) => ListView.separated(
     // btshel l scroll l azr2 we bt5leh ynot
     physics: BouncingScrollPhysics(),
     itemBuilder: (context, index) => buildArticleItem(list[index],context),
     separatorBuilder: (context, index) => myDivider (),
     itemCount:list.length,
   ),
   fallback: (context)=> isSerach ? Container() : Center(child: CircularProgressIndicator()),
 );

Widget buildArticleItem (article, context)=> InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                      "${article['title']}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1
                  ),
                ),
                Text("${article['publishedAt']}",
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),

              ],
            ),
          ),
        )
      ],
    ),
  ),
);


void navigateTo(context,widget) => Navigator.push(
     context,
     MaterialPageRoute(
         builder: (context)=> widget,
     )
 );

void navigateAndFinish (context,widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context)=> widget,
    ),
      (Route<dynamic>route) => false,
);

Widget defaultTextBottom ({
  required Function function,
  required String text,
})=> TextButton( onPressed: (){function();}, child: Text(text.toUpperCase(),),);


void showToast({
  required String? text,
  required ToastStates state,
})=> Fluttertoast.showToast(
    msg: text!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor (state),
    textColor: Colors.white,
    fontSize: 16.0
);
//enum 3bara 3n 7aga so8ira b5tar meno we bona2an 3ale ha5taro hy3ml 7aga

enum ToastStates {SUCCESS,ERROR,WARNING}

Color chooseToastColor (ToastStates state)
{
  Color color ;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.yellow;
      break;
  }
  return color;
}


Widget buildListProduct( model,
    context,
{
  bool isOldPrice = true,
}
)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 120,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: 120,
                height: 120,
              ),
              if (model.discount!=0 && isOldPrice)
                Container(
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 10.0, color: Colors.white),
                      ),
                    ))
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, height: 1.1),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      color: defualtColor,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model.discount !=0 && isOldPrice)
                    Text(
                      model.oldPrice.toString(),
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavourites(model.id!);
                    },
                    icon: CircleAvatar(
                      backgroundColor:ShopCubit.get(context).favorites[model.id]!  ? defualtColor : Colors.grey,
                      child:Icon(
                        Icons.favorite_border,
                        size: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

Widget defaultAppBar ({
  required BuildContext context,
  String? title,
  List<Widget>? action ,
})=> AppBar(
  toolbarHeight: 20,
  leading: IconButton(onPressed: ()
  {
    Navigator.pop(context);
  },
      icon: Icon(
        IconBroken.Arrow___Left_2
      )),

  title: Text(
    title!,
  ),
  actions: action,
);