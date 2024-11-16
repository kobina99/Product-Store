import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class Cart extends ChangeNotifier {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addItem(Product item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItem(Product item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.price;
    }
    return total;
  }

  int get itemCount => _cartItems.length;
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: cart.cartItems.isEmpty
          ? Center(child: Text('No items in the cart'))
          : ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, index) {
                var item = cart.cartItems[index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text('\$${item.price}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      cart.removeItem(item);
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: cart.cartItems.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total: \$${cart.totalPrice.toStringAsFixed(2)}'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckoutPage()),
                      );
                    },
                    child: Text('Checkout'),
                  ),
                ],
              ),
            ),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Container(
        decoration: BoxDecoration(
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
              Text(
                'Items in your cart:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: cart.itemCount,
                itemBuilder: (context, index) {
                  var item = cart.cartItems[index];
                  return ListTile(
                    title:
                        Text(item.title, style: TextStyle(color: Colors.white)),
                    subtitle: Text('\$${item.price}',
                        style: TextStyle(color: Colors.white)),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Payment'),
                      content: Text('You chose Cash on Delivery.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Pay with Cash on Delivery'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
