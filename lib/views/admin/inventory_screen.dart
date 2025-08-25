import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Item {
  final String name;
  final int quantity;

  Item({required this.name, required this.quantity});

  Map<String, dynamic> toMap() => {'name': name, 'quantity': quantity};

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(name: map['name'], quantity: map['quantity']);
  }
}

class Inventory {
  List<Item> items;

  Inventory(this.items);

  void addItem(Item item) {
    items.add(item);
  }

  void editItem(int index, Item item) {
    items[index] = item;
  }

  void deleteItem(int index) {
    items.removeAt(index);
  }
}

class InventoryScreen extends StatefulWidget {
  InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  late Inventory inventory;
  List<Item> filteredItems = [];
  String searchQuery = '';
  bool showOnlyOutOfStock = false;

  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    inventory = Inventory([]);
    _loadInventory();
  }

  Future<void> _loadInventory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> storedItems = prefs.getStringList('inventory') ?? [];
    setState(() {
      inventory = Inventory(
        storedItems.map((e) {
          final parts = e.split(':');
          return Item(name: parts[0], quantity: int.parse(parts[1]));
        }).toList(),
      );
      _filterItems();
    });
  }

  Future<void> _saveInventory() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsToStore = inventory.items
        .map((e) => '${e.name}:${e.quantity}')
        .toList();
    await prefs.setStringList('inventory', itemsToStore);
  }

  void _filterItems() {
    setState(() {
      filteredItems = inventory.items.where((item) {
        final matchesSearch = item.name.toLowerCase().contains(
          searchQuery.toLowerCase(),
        );
        final matchesStock = showOnlyOutOfStock ? item.quantity == 0 : true;
        return matchesSearch && matchesStock;
      }).toList();
    });
  }

  void _onSearchChanged(String value) {
    searchQuery = value;
    _filterItems();
  }

  void _toggleOutOfStockFilter(bool? value) {
    showOnlyOutOfStock = value ?? false;
    _filterItems();
  }

  void _showItemDialog({Item? item, int? index}) {
    if (item != null) {
      _nameController.text = item.name;
      _quantityController.text = item.quantity.toString();
      _selectedIndex = index!;
    } else {
      _nameController.clear();
      _quantityController.clear();
      _selectedIndex = -1;
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(_selectedIndex == -1 ? 'Add Item' : 'Edit Item'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
              ),
              TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = _nameController.text.trim();
              final quantity = int.tryParse(_quantityController.text) ?? 0;
              if (name.isEmpty || quantity < 0) return;

              final newItem = Item(name: name, quantity: quantity);
              setState(() {
                if (_selectedIndex == -1) {
                  inventory.addItem(newItem);
                } else {
                  inventory.editItem(_selectedIndex, newItem);
                }
                _saveInventory();
                _filterItems();
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteItem(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                inventory.deleteItem(index);
                _saveInventory();
                _filterItems();
              });
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showItemDialog(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Products',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearchChanged,
            ),
            Row(
              children: [
                Checkbox(
                  value: showOnlyOutOfStock,
                  onChanged: _toggleOutOfStockFilter,
                ),
                const Text('Show only out of stock'),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filteredItems.isEmpty
                  ? const Center(child: Text('No products found.'))
                  : ListView.separated(
                      itemCount: filteredItems.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        final isOutOfStock = item.quantity == 0;
                        return ListTile(
                          leading: CircleAvatar(child: Text(item.name[0])),
                          title: Text(item.name),
                          subtitle: Text('Quantity: ${item.quantity}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                isOutOfStock ? 'Out of stock' : 'In stock',
                                style: TextStyle(
                                  color: isOutOfStock
                                      ? Colors.red
                                      : Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _showItemDialog(
                                  item: item,
                                  index: inventory.items.indexOf(item),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    _deleteItem(inventory.items.indexOf(item)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
