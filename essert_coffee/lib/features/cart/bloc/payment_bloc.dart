import 'package:bloc/bloc.dart';
import 'package:essert_coffee/layer%20data/branch_data.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
part 'payment_event.dart';
part 'payment_state.dart';

/// BLoC for managing payment amount parsing and state.
///
/// Methods:
/// - Handles [AmountEvent] to parse the payment amount and convert it into the smallest currency unit.
///
/// Emits:
/// - [SuccessState] after successfully parsing and converting the amount.
/// - [ErrorState] if the amount format is invalid.
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  String amount = ' 100';
  late int num = 1;
  final branchGetIt = GetIt.I.get<BranchData>();
  PaymentBloc() : super(PaymentInitial()) {
    on<AmountEvent>((event, emit) {
      try {
        final double changeToDouble = double.parse(amount);
        num = (changeToDouble * 100).toInt();
        emit(SuccessState());
      } catch (e) {
        emit(ErrorState('Invalid amount format'));
      }
    });
  }
}
