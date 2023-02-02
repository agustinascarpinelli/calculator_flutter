import 'package:calculadora/widgets/results.dart';
import 'package:flutter/material.dart';
import 'package:calculadora/widgets/calc_button.dart';
import 'package:calculadora/widgets/line_separator.dart';
import 'package:calculadora/widgets/main_result.dart';
import 'package:calculadora/widgets/sub_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/calculator/calculator_bloc.dart';


class CalculatorScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final calculatorBloc=BlocProvider.of<CalculatorBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric( horizontal: 10 ),
          child: Column(
            children: [
              
              Expanded(
                child: Container(),
              ),

               Results(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: 'AC',
                    bgColor: Color(0xffA5A5A5 ),
                    onPressed: () =>calculatorBloc.add(ResetAC()) ,
                  ),
                  CalculatorButton( 
                    text: '+/-',
                    bgColor: Color(0xffA5A5A5 ),
                    onPressed: () => calculatorBloc.add(ChangeNegativePositive()),
                  ),
                  CalculatorButton( 
                    text: 'del',
                    bgColor: Color(0xffA5A5A5 ),
                    onPressed: () =>  calculatorBloc.add(DeleteLast()),
                  ),
                  CalculatorButton( 
                    text: '/',
                    bgColor: Color(0xffF0A23B ),
                    onPressed: () =>calculatorBloc.add(OperationEntry('/')),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: '7',
                    onPressed: () => calculatorBloc.add(AddNumber('7')),
                  ),
                  CalculatorButton( 
                    text: '8',
                    onPressed: () =>  calculatorBloc.add(AddNumber('8')),
                  ),
                  CalculatorButton( 
                    text: '9',
                    onPressed: () => calculatorBloc.add(AddNumber('9')),
                  ),
                  CalculatorButton( 
                    text: 'X',
                    bgColor: Color(0xffF0A23B ),
                    onPressed: () =>calculatorBloc.add(OperationEntry('X')),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: '4', 
                    onPressed: () => calculatorBloc.add(AddNumber('4')),
                  ),
                  CalculatorButton( 
                    text: '5', 
                    onPressed: () =>calculatorBloc.add(AddNumber('5')),
                  ),
                  CalculatorButton( 
                    text: '6', 
                    onPressed: () => calculatorBloc.add(AddNumber('6')),
                  ),
                  CalculatorButton( 
                    text: '-',
                    bgColor: Color(0xffF0A23B ),
                    onPressed: () => calculatorBloc.add(OperationEntry('-')),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: '1', 
                    onPressed: () => calculatorBloc.add(AddNumber('1')),
                  ),
                  CalculatorButton( 
                    text: '2', 
                    onPressed: () => calculatorBloc.add(AddNumber('2')),
                  ),
                  CalculatorButton( 
                    text: '3', 
                    onPressed: () => calculatorBloc.add(AddNumber('3')),
                  ),
                  CalculatorButton(
                    text: '+',  
                    bgColor: Color(0xffF0A23B ),
                    onPressed: () => calculatorBloc.add(OperationEntry('+')),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: '0', 
                    big: true,
                    onPressed: () =>calculatorBloc.add(AddNumber('0')),
                  ),
                  CalculatorButton( 
                    text: '.', 
                    onPressed: () => calculatorBloc.add(AddNumber('.')),
                  ),
                  CalculatorButton( 
                    text: '=',
                    bgColor: Color(0xffF0A23B ),
                    onPressed: () => {
                             calculatorBloc.add(CalculateResult())
                    }
                
                  ),
                ],
              ),
            ],
          ),
        ),
      )
   );
  }
}