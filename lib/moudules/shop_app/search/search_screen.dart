import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/compomats/shared_componat/componat.dart';
import 'package:project_udemy/moudules/shop_app/search/cubit/cubit.dart';
import 'package:project_udemy/moudules/shop_app/search/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: SearchController,
                          type: TextInputType.text,
                          validator: (value)
                          {
                            if (value.isEmpty)
                            {
                              return ' enter text to search';
                            }return null;
                          },
                          label: 'Search',
                          prefix: Icons.search,
                        onSubmit: (String text)
                          {
                            SearchCubit.get(context).search(text);
                          }
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (state is SearchLoadingState)
                      LinearProgressIndicator(),
                      if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice: false),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context).model!.data!.data!.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
