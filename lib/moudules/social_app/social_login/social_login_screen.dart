import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/layout/social_app/social_layout.dart';
import 'package:project_udemy/moudules/social_app/social_login/cubit/cubit.dart';
import 'package:project_udemy/moudules/social_app/social_register/social_register_screen.dart';
import '../../../compomats/shared_componat/componat.dart';
import '../../../network/local/shared_preferences.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget
{
  var formKey=GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context, state)
        {
          if (state is SocialLoginErrorState) {
            {
              showToast(text: state.error, state: ToastStates.ERROR);
            };
          }
          if(state is SocialLoginSuccessState)
            {
              CacheHelper.saveData(
                  key: 'uId',
                  value:state.uId,
              ).then((value) {
                navigateAndFinish(context, SocialLayout());
              });
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child:SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height:30.0 ,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if(value.isEmpty)
                            {
                              return 'email must not empty';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: SocialLoginCubit.get(context).suffix,
                          suffixPressed: ()
                          {
                            SocialLoginCubit.get(context).changePasswordVisibility();

                          },
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          validator: (value)
                          {
                            if(value.isEmpty)
                            {
                              return 'password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context)=>  defaultButton(
                            text: 'login',
                            function: ()
                            {
                              if (formKey.currentState!.validate())
                              {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }

                            },
                            isUpperCase: true,
                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),

                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextBottom(
                              function: ()
                              {
                                navigateTo(context, SocialRegisterScreen(),);
                              },
                              text: 'register',
                            ),

                          ],
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
