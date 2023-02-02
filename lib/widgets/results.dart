import 'package:calculadora/widgets/line_separator.dart';
import 'package:calculadora/widgets/main_result.dart';
import 'package:calculadora/widgets/sub_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/calculator/calculator_bloc.dart';

class Results extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Column=>Wrap with BlocBuilder
    //<Nombre del bloc con el que quiero trabajar y su estado>,
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        if (state.firstNumber== '0' && state.secondNumber=='0'){
          return  MainResultText(
              text: state.mathResult.endsWith('.0') ?
                    state.mathResult.substring(0,state.mathResult.length-2)
                    :state.mathResult
              );
        }
        return Column(
          children: [
            SubResult(text: state.firstNumber.endsWith('.0')?
                      state.firstNumber.substring(0,state.firstNumber.length-2)
                      :state.firstNumber),
            SubResult(text: state.operation),
            SubResult(text: state.secondNumber.endsWith('.0')?
                      state.secondNumber.substring(0,state.secondNumber.length-2)
                      :state.secondNumber
            
            ),
            LineSeparator(),
            MainResultText(
              text: state.mathResult.endsWith('.0') ?
                    state.mathResult.substring(0,state.mathResult.length-2)
                    :state.mathResult
              )
          ],
        );
      },
    );
  }
}
