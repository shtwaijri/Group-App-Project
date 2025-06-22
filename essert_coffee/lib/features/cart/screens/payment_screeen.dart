import 'package:essert_coffee/features/cart/bloc/payment_bloc.dart';
import 'package:essert_coffee/style/style_color.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/widgets/branch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moyasar/moyasar.dart';

/// A stateless widget responsible for handling payment processing.
///
/// Displays the selected branch information and a credit card payment form.
/// Uses [PaymentBloc] for payment state management.
class PaymentScreeen extends StatelessWidget {
  const PaymentScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<PaymentBloc>();
          bloc.add(AmountEvent());
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 24,
                    children: [
                      // Show currently selected branch using BranchWidget.
                      BranchWidget(branch: bloc.branchGetIt.branchName()),

                      BlocBuilder<PaymentBloc, PaymentState>(
                        builder: (context, state) {
                          if (state is SuccessState) {
                            return CreditCard(
                              config: paymentConfig(bloc.num),
                              onPaymentResult: (PaymentResponse value) async {
                                // Callback when payment result is received.
                                if (value.status == PaymentStatus.paid) {
                                  print("SuccessState");
                                } else if (value.status ==
                                    PaymentStatus.failed) {
                                  // Show snackbar on payment failure.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Payment failed. Please try again.',
                                        style: StyleText.regular16Error,
                                      ),
                                      backgroundColor: StyleColor.white,
                                    ),
                                  );
                                }
                              },
                            );
                          }
                          return Text("notheng");
                        },
                      ),
                    ],
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

/// Creates and returns a [PaymentConfig] object for the Moyasar payment plugin.
PaymentConfig paymentConfig(int amount) {
  return PaymentConfig(
    publishableApiKey: 'pk_test_aZfJhyxmSMDXeaLEegMznMKegF7DmGcRjusudQSk',
    amount: amount,
    description: 'order #1324',
  );
}
