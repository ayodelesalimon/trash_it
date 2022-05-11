import 'package:flutter/material.dart';

class PaymentHistoryDetails extends StatefulWidget {
  const PaymentHistoryDetails({ Key? key, this.message }) : super(key: key);

 final  Map<String, dynamic>? message;

  @override
  State<PaymentHistoryDetails> createState() => _PaymentHistoryDetailsState();
}

class _PaymentHistoryDetailsState extends State<PaymentHistoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
              Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Payment Amount'),
                   Text(widget.message!['currency']+widget.message!['amount'].toString(),   style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),),
                
                ],
              ),
              SizedBox(height: 8),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Payment ID'),
                   Text(widget.message!['payment_id'].toString(),   style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),),
                
                ],
              ),
              SizedBox(height: 8),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Transaction Date'),
                   Text(widget.message!['payment_date'].toString(),   style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),),
                
                ],
              ),
               SizedBox(height: 8),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Payment Number'),
                   Text(widget.message!['payment_number'].toString(),   style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),),
                
                ],
              ),
               SizedBox(height: 8),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('transaction_reference'),
                   Text(widget.message!['transaction_reference'].toString(),   style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),),
                
                ],
              ),
          ],
        
        ),
      ),
    
    );
  }
}