import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/moudules/counter_app/counter/cubit.dart';
import 'package:project_udemy/moudules/counter_app/counter/states.dart';





class counter extends StatelessWidget {
  // 3shan astad3e objet mn counter cubit

 // @override
 // _counterState createState() => _counterState();
//}

// class _counterState extends State<counter> {

  //  @override
  // void initState() {
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      //requied create de  fa hcreate mn class eli esmha countercubit eli be textend mn cubit 3shan a3ml mno object
      create: (BuildContext context) => CounterCubit(),
      // wel blocProvider lazm leh child : BlocCOnsumer
      child: BlocConsumer<CounterCubit,CounterStates>(

        // blocconsumer dah eli by5lene alisen 3ala l t8yorat eli bt7sl fel CounterCubit fa 3shan keda howa bya5odha gowah
        // <CounterCubit, we 3shan ya3rf howa hylisen 3ala ane state eli hia  CounterStates >
        // هليسن عليه بقي عشان  يشوف  هيعمل rebuild لي اني cubit و  في اني state
        listener: ( BuildContext context, CounterStates state)
        {
          if( state is CounterMinusState)
          {
            print(' Minus state ${state.Counter}');
          }

          if( state is CounterPlusState)
            {
              print(' Plus state ${state.Counter}');
            }
        },
        builder: (BuildContext context,CounterStates state) {
          return Scaffold(
            appBar: AppBar(
              title: Text
                (
                  'Counter'
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: ()
                    {

                      CounterCubit.get(context).Minus();
                    },
                    child: Text(
                        'MINUS'
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Text(
                      '${CounterCubit.get(context).Counter}',
                      style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w900
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: ()
                    {

                      CounterCubit.get(context).Plus();
                    },
                    child: Text(
                        'PLUS'
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

