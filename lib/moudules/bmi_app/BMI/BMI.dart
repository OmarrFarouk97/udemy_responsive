import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_udemy/compomats/shared_componat/componat.dart';
import 'package:project_udemy/moudules/bmi_app/bmi_result/result.dart';

class BMI extends StatefulWidget {
  const BMI({Key? key}) : super(key: key);

  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  bool isMale = true;
  double height = 120;
  int weight = 40;
  int age =20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: ()
                      {
                        setState(() {
                          isMale =true;

                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/Mars_symbol.svg/1024px-Mars_symbol.svg.png",
                              scale: 15,
                            ),
                             SizedBox(
                              height: 15,
                            ),
                             Text(
                              'Male',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isMale ? Colors.blue : Colors.grey
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale=false;
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Venus_symbol.svg/1024px-Venus_symbol.svg.png",
                              scale: 15,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Female',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: !isMale ? Colors.blue : Colors.grey
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      'Height',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children:  [
                        Text(
                          '${height.round()}',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight:FontWeight.w900
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'CM',
                          style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Slider(value: height,
                        max: 180,
                        min: 80,
                        onChanged: (value){
                      setState(() {
                        height=value;
                      });

                        }
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            'age',
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                           Text(
                            '${age}',
                            style:
                            TextStyle(fontSize: 40,
                                fontWeight:FontWeight.w900),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(onPressed: ()
                              {
                                setState(() {
                                  age--;
                                });
                              },
                                heroTag: 'age-',
                                mini: true,
                              child: const Icon(Icons.remove),),
                              FloatingActionButton(onPressed: ()
                              {
                                setState(() {
                                  age++;
                                });
                                  },
                                heroTag: 'age+',
                                mini: true,
                                child: const Icon(Icons.add),),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            'Wieght',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                           Text(
                             '${weight}',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight:FontWeight.w900
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(onPressed: ()
                              {
                                setState(() {
                                  weight--;

                                });
                              },
                                heroTag: 'weight-',
                                mini: true,
                                child: const Icon(Icons.remove),),
                              FloatingActionButton(onPressed: ()
                              {
                                setState(() {

                                  weight++;
                                });
                              },
                                heroTag: 'weight+',
                                mini: true,
                                child: const Icon(Icons.add),),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
            )
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            height: 50,
            child: MaterialButton(
              onPressed: ()
              {
                double result = weight/pow(height/100,2);
                print (result.round());
                
                navigateTo(context, Result(result: result.round(),
                    isMale: isMale, age: age));
              },
              child: const Text('Calculate'),
            ),
          )
        ],
      ),
    );
  }
}
