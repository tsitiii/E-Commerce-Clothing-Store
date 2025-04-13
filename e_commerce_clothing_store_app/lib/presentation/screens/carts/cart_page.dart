import 'package:flutter/material.dart';
import 'checkout_page.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Map<String, dynamic>> _cartItems = [
    {
      'name': 'Watch',
      'type': 'Rolex',
      'price': 40.0,
      'quantity': 1,
      'image': 'images/watch.png'
    },
    {
      'name': 'Airpods',
      'type': 'Apple',
      'price': 333.0,
      'quantity': 2,
      'image': 'images/ear_pod.jpg'
    },
    {
      'name': 'Hoodie',
      'type': 'puma',
      'price': 50.0,
      'quantity': 1,
      'image': 'images/hoodie.jpg'
    },
  ];

  int get _totalItems =>
      _cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));
  double get _subtotal =>
      _cartItems.fold(0, (sum, item) => sum + item['price'] * item['quantity']);
  double get _discount => 4.0;
  double get _deliveryCharge => 2.0;
  double get _total => _subtotal - _discount + _deliveryCharge;

  void _incrementQuantity(int index) {
    setState(() {
      _cartItems[index]['quantity']++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (_cartItems[index]['quantity'] > 1) {
        _cartItems[index]['quantity']--;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Cart')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Clear Cart') {
                _clearCart();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected: $value')),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Clear Cart', 'View Wishlist', 'Settings'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: _cartItems.isEmpty
          ? Center(
              child:
                  Text('Your cart is empty!', style: TextStyle(fontSize: 18)))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        width: 343,
                        height: 140,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF8F7F7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 6,
                              top: 6,
                              child: Container(
                                width: 126,
                                height: 99,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(item['image']),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 144,
                              top: 23,
                              child: Text(
                                item['name'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 144,
                              top: 48,
                              child: Text(
                                item['type'] ?? '',
                                style: TextStyle(
                                  color: const Color(0xFF9B9999),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 144,
                              top: 74,
                              child: Text(
                                '\$${item['price']}',
                                style: TextStyle(
                                  color: const Color(0xFF5F55D7),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              top: 40,
                              child: GestureDetector(
                                onTap: () => _removeItem(index),
                                child: Image.asset('images/delete_icon.png',
                                    width: 28, height: 28),
                              ),
                            ),
                            Positioned(
                              right: 70,
                              top: 90,
                              child: GestureDetector(
                                onTap: () => _decrementQuantity(index),
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xCE5F55D7),
                                    shape: OvalBorder(),
                                  ),
                                  child: Icon(Icons.remove,
                                      size: 16, color: Colors.white),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 45,
                              top: 92,
                              child: Text(
                                '${item['quantity']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                  color: Colors.black.withAlpha(178),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              top: 90,
                              child: GestureDetector(
                                onTap: () => _incrementQuantity(index),
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xCE5F55D7),
                                    shape: OvalBorder(),
                                  ),
                                  child: Icon(Icons.add,
                                      size: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border:
                        Border(top: BorderSide(color: Colors.grey.shade300)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderSummaryRow('Items', '$_totalItems'),
                      orderSummaryRow(
                          'Subtotal', '\$${_subtotal.toStringAsFixed(2)}'),
                      orderSummaryRow(
                          'Discount', '\$${_discount.toStringAsFixed(2)}'),
                      orderSummaryRow('Delivery Charges',
                          '\$${_deliveryCharge.toStringAsFixed(2)}'),
                      orderSummaryRow('Total', '\$${_total.toStringAsFixed(2)}',
                          isBold: true),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 79, 33, 243),
                            padding: EdgeInsets.symmetric(vertical: 14),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CheckoutPage(
                                  totalItems: _totalItems,
                                  subtotal: _subtotal,
                                  discount: _discount,
                                  deliveryCharge: _deliveryCharge,
                                  total: _total,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Checkout",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget orderSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
