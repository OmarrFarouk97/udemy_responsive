 abstract class CounterStates {}

 class CounterInitailState extends CounterStates {}

 class CounterPlusState extends CounterStates {
 // lw 3ayz ab3t data m3 l state 3shan at7km feha bardo we tb2a m3aya
 final int Counter;

  CounterPlusState(this.Counter);
 }


 class CounterMinusState extends CounterStates {
  final int Counter ;

  CounterMinusState(this.Counter);

 }