import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home/product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username; // Username passed from login
  const HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  void _handleLogout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  void _openProductDetail(String id, Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          id: id,
          name: product['name'],
          description: product['description'],
          price: product['price'].toDouble(),
          imageUrl: product['imageUrl'] ?? '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final username = widget.username;

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $username!'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _handleLogout),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No products available.'));
          }

          final products = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final doc = products[index];
              final data = doc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: data['imageUrl'] != null && data['imageUrl'] != ''
                      ? Image.network(
                          data['imageUrl'],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image),
                        ),
                  title: Text(data['name']),
                  subtitle: Text('\$${data['price'].toStringAsFixed(2)}'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () => _openProductDetail(doc.id, data),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
