import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorState());

  @override
  Stream<CalculatorState> mapEventToState(
    CalculatorEvent event,
  ) async* {
    if (event is ResetAC) {
      //yield* no emite el stream=>emite el valor que el stream va a emitir.
      yield* this._resetAC();
    } else if (event is AddNumber) {
      if (state.mathResult.isNotEmpty) {
        yield* _resetAC();
        yield* _changefirstNumber(event);
      } else {
        if (state.operation.isEmpty) {
          yield* _changefirstNumber(event);
        } else if (state.operation.isNotEmpty) {
          yield* _onChangeSecondNumberEvent(event);
        }
      }
    } else if (event is ChangeNegativePositive) {
      yield state.copyWith(
          mathResult: (state.mathResult.contains('-')
              ? (state.mathResult.replaceFirst('-', ''))
              : '-' + state.mathResult));
    } else if (event is DeleteLast) {
      yield* _onDeleteLast(event);
    } else if (event is OperationEntry) {
      if (state.mathResult.isEmpty) {
        yield state.copyWith(
          operation: event.operation,
        );
      } else {
        yield state.copyWith(
            firstNumber: state.mathResult,
            operation: event.operation,
            secondNumber: '',
            mathResult: '');
      }
    } else if (event is CalculateResult) {
      yield* _calculateResult();
    }
  }

  Stream<CalculatorState> _resetAC() async* {
    yield CalculatorState(
        firstNumber: '', mathResult: '', operation: '', secondNumber: '');
  }

  Stream<CalculatorState> _calculateResult() async* {
    final double num1 = double.parse(state.firstNumber);
    final double num2 = double.parse(state.secondNumber);

    switch (state.operation) {
      case '+':
        yield state.copyWith(
          mathResult: '${num1 + num2}',
        );

        break;
      case '-':
        yield state.copyWith(
          mathResult: '${num1 - num2}',
        );
        break;
      case 'X':
        yield state.copyWith(
          secondNumber: state.mathResult,
          mathResult: '${num1 * num2}',
        );
        break;
      case '/':
        String result;
        num2 == 0
            ? result = 'Cannot divide by zero'
            : result = '${num1 / num2}';

        yield state.copyWith(
          mathResult: result,
        );
        break;

      default:
        yield state;
    }
  }

  Stream<CalculatorState> _changefirstNumber(event) async* {
    if (state.firstNumber.isEmpty && event.number == ".") {
      yield state.copyWith(firstNumber: "0.");
      return;
    }
    if (state.firstNumber.isNotEmpty) {
      if (event.number == "." && state.firstNumber.contains(".")) return;
      if (state.firstNumber.substring(0, 1) == "0" &&
          !state.firstNumber.contains(".")) {
        yield (state.copyWith(
            firstNumber: "${state.firstNumber}.${event.number}"));
        return;
      }
    }
    yield (state.copyWith(firstNumber: "${state.firstNumber}${event.number}"));
  }

  Stream<CalculatorState> _onChangeSecondNumberEvent(event) async* {
    if (state.secondNumber.isEmpty && event.number == ".") {
      yield state.copyWith(secondNumber: "0.");
      return;
    }
    if (state.secondNumber.isNotEmpty) {
      if (event.number == "." && state.secondNumber.contains(".")) return;

      if (state.secondNumber.substring(0, 1) == "0" &&
          !state.secondNumber.contains(".")) {
        yield (state.copyWith(
            secondNumber: "${state.secondNumber}.${event.number}"));
        return;
      }
    }
    yield (state.copyWith(
        secondNumber: "${state.secondNumber}${event.number}"));
  }

  Stream<CalculatorState> _onDeleteLast(event) async* {
    if (state.mathResult.isNotEmpty) {
      yield state.copyWith(mathResult: '');
    } else {
      if (state.secondNumber.isEmpty && state.operation.isEmpty) {
        yield state.copyWith(
            firstNumber: state.firstNumber.length > 1
                ? state.firstNumber.substring(0, state.firstNumber.length - 1)
                : '');
      } else if (state.secondNumber.isEmpty && state.operation.isNotEmpty) {
        yield state.copyWith(operation: '');
      } else if (state.secondNumber.isNotEmpty) {
        yield state.copyWith(
            secondNumber: state.secondNumber.length > 1
                ? state.secondNumber.substring(0, state.secondNumber.length - 1)
                : '');
      }
    }
  }
}
