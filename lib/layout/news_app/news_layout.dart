import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/compomats/shared_componat/componat.dart';
import 'package:project_udemy/compomats/shared_componat/cubit/cubit2.dart';
import 'package:project_udemy/layout/news_app/cubit.dart';
import 'package:project_udemy/layout/news_app/states.dart';
import 'package:project_udemy/network/remote/dio_helper.dart';

import '../../moudules/news_app/search/search_screen.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(onPressed: ()
              {
                navigateTo(context, SearchScreen(),);
              },
                  icon: Icon(Icons.search_rounded)),
              IconButton(onPressed: ()
              {
                AppCubit.get(context).changeAppMode();
              },
                  icon: Icon(Icons.brightness_4_outlined)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
