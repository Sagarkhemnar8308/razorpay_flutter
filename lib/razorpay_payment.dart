import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayPayment extends StatefulWidget {
  const RazorPayPayment({super.key});

  @override
  State<RazorPayPayment> createState() => _RazorPayPaymentState();
}

class _RazorPayPaymentState extends State<RazorPayPayment> {
  //nhTAqtvDf12EdhG0I57h35Bprzp_test_JkHZhM2DjmedxT
  late Razorpay _razorpay;
  TextEditingController amt = TextEditingController();

  void opencheckout(amount) async {
    amount = amount * 100;
    var options = {
      'key': '[your-key]',
      'amount': amount,
      'prefill': {'contact': '1234567890', 'email': 'test@gmail.com'},
    };
    try {
      _razorpay.open(options);
    } catch (e, stk) {
      print("error to open options $e $stk");
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse resp) {
    Fluttertoast.showToast(
      msg: 'Payment SuccessFully ${resp.paymentId}',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void handlePaymentError(PaymentFailureResponse resp) {
    Fluttertoast.showToast(
      msg: 'Payment SuccessFully ${resp.message}',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void handleExternalWallet(ExternalWalletResponse resp) {
    Fluttertoast.showToast(
      msg: 'External Wallet ${resp.walletName}',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      handlePaymentSuccess,
    );
    _razorpay.on(
      Razorpay.EVENT_PAYMENT_ERROR,
      handlePaymentError,
    );
    _razorpay.on(
      Razorpay.EVENT_EXTERNAL_WALLET,
      handleExternalWallet,
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                opencheckout(2);
              },
              child: Text("RozarPay in Flutter"),
            )
          ],
        ),
      ),
    );
  }
}
