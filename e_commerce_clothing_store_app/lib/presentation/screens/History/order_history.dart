import 'package:flutter/material.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _orders = [
    {
      'status': 'Active',
      'name': 'Watch',
      'type': 'Rolex',
      'price': 40.0,
      'quantity': 1,
      'image': 'images/watch.jpg'
    },
    {
      'status': 'Completed',
      'name': 'Airpods',
      'type': 'Apple',
      'price': 333.0,
      'quantity': 2,
      'image': 'images/ear_pod.jpg'
    },
    {
      'status': 'Canceled',
      'name': 'Hoodie',
      'type': 'Puma',
      'price': 50.0,
      'quantity': 1,
      'image': 'images/watch2.jpg'
    },
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              fontFamily: 'Poppins',
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          indicatorColor: Color(0xFF5F55D7),
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
            Tab(text: 'Canceled'),
          ],
        ),
        leading: BackButton(color: Colors.black),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(_orders, showTrackButton: true),
          _buildOrderList([], showTrackButton: false),
          _buildOrderList([], showTrackButton: false),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<Map<String, dynamic>> orders,
      {bool showTrackButton = false}) {
    if (orders.isEmpty) {
      return Center(child: Text('No orders here.'));
    }
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final item = orders[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          width: 343,
          height: 140,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: ShapeDecoration(
                    color: const Color.fromARGB(220, 212, 209, 209),
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
                  style: const TextStyle(
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
                  style: const TextStyle(
                    color: Color(0xFF9B9999),
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
                  '\$${item['price']} x${item['quantity']}',
                  style: TextStyle(
                    color: const Color(0xFF5F55D7),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (showTrackButton) ...[
                Positioned(
                  right: 12,
                  top: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5F55D7),
                    ),
                    child: Text(
                      'Track Order',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
