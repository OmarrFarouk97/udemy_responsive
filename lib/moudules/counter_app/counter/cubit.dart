
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/moudules/counter_app/counter/states.dart';


class CounterCubit extends Cubit<CounterStates>

    // (1) awl 7aga b3aml class be esm eli na 3ayzo we be extend mn  Cubit< > l cubit de bt7tag l states eli 3andi ...
   // we mash hynf3 adelo aktr mn claass
   // f b3ml fe page tania   class kber we tkon abstract class .. we b3ml b3dha classes tania be t extend meno we a7to howa fel cubit de
{
  CounterCubit() : super(CounterInitailState());

  // create ll constarctour  3shan hia 3ayza iniail state 3shan ybda2

  //(2)  3ayz acreate obj meno 3shan andho mn 5lal l obj dah bsor3a fe ay mkan
  // wel super deh m7taga  stetaya men eli 3ndi f b3ml  state mbd2aya hnak  be esm ay 7aga zai(initail state) we bdhalo hena


  // b7ot gowa hena b2a l logic wel method eli 3yzha




  static CounterCubit get(context)=> BlocProvider.of(context);

  // de tr2a 5asa 3shan astd3e mn l cubit dah  object we a2dr amsko be edi
  // lw 3yz andh 3ala 7aga gowa l claas mn 8er ma a5od mnha ocject fa b3mlha static we b3ml method esmha get we bta5od (context)
  // we return type bt3ha object mne s

  int Counter =1;

  void Minus ()
  {
    Counter--;
    // 3shan a8er l state b3ml emit
    emit(CounterMinusState(
      Counter
    ));

  }
  void Plus ()
  {
    Counter++;
    emit(CounterPlusState(
      Counter
    ));

  }

}