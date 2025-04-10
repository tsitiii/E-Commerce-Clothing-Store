import 'package:flutter/material.dart';

import '../History/order_history.dart';

class CheckoutPage extends StatefulWidget {
  final int totalItems;
  final double subtotal;
  final double discount;
  final double deliveryCharge;
  final double total;

  const CheckoutPage({
    super.key,
    required this.totalItems,
    required this.subtotal,
    required this.discount,
    required this.deliveryCharge,
    required this.total,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedPayment = 'paypal';

  void _selectPayment(String method) {
    setState(() {
      _selectedPayment = method;
    });
  }

  void _addNewPaymentMethod() {
    // Add your logic to add a new method
    debugPrint("Add new payment method tapped.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery Location
              Row(
                children: [
                  Image.asset('images/map.png', width: 24, height: 24),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '325 15th Eighth Avenue, NewYork',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        'Saepe eaque fugiat ea voluptatum veniam.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9B9999),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 24),

              // Delivery Time
              Row(
                children: [
                  Image.asset('images/clock.png', width: 24, height: 24),
                  const SizedBox(width: 8),
                  const Text(
                    '6:00 pm, Wednesday 20',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Order Summary
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F7F7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Order Summary',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 12),
                    _summaryRow('Items', '${widget.totalItems}'),
                    _summaryRow(
                        'Subtotal', '\$${widget.subtotal.toStringAsFixed(2)}'),
                    _summaryRow(
                        'Discount', '-\$${widget.discount.toStringAsFixed(2)}'),
                    _summaryRow('Delivery Charges',
                        '\$${widget.deliveryCharge.toStringAsFixed(2)}'),
                    const Divider(),
                    _summaryRow(
                        'Total', '\$${widget.total.toStringAsFixed(2)}'),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Payment Methods
              const Text(
                'Choose payment method',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 12),
              _buildPaymentOption('PayPal', 'images/paypal.png'),
              _buildPaymentOption('Cash', 'images/cash.png'),
              _buildPaymentOption('Credit Card', 'images/credit.png'),
              const SizedBox(height: 12),

              // Add Payment
              GestureDetector(
                onTap: _addNewPaymentMethod,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Add new payment method',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Icon(Icons.add, size: 20),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Checkout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5F55D7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderHistoryPage()),
                    );
                  },
                  child: const Text(
                    'Check Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: _summaryStyle()),
          Text(value, style: _summaryStyle()),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String method, String assetPath) {
    final isSelected = _selectedPayment.toLowerCase() == method.toLowerCase();
    return GestureDetector(
      onTap: () => _selectPayment(method.toLowerCase()),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFF5F55D7) : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(assetPath, width: 24, height: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                method,
                style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF5F55D7)),
          ],
        ),
      ),
    );
  }

  TextStyle _summaryStyle() {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xFF484747),
      fontFamily: 'Poppins',
    );
  }
}
