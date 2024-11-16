import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart.dart'; // Import the Cart class and CartPage

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Container(
        color: Colors.red,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pic.avif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Items in your cart:', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: cart.itemCount,
                itemBuilder: (context, index) {
                  var item = cart.cartItems[index];
                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _showPaymentDialog(context);
                },
                child: Text('Pay with Cash on Delivery'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Confirmation'),
        content: Text('You chose Cash on Delivery for your payment.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              Navigator.pop(context);
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
