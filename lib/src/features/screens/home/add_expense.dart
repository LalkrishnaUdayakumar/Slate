import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseEntry extends StatefulWidget {
  final Function(ExpenseDetails) onSave;
  final VoidCallback onCancel;

  const ExpenseEntry({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<ExpenseEntry> createState() => _ExpenseEntryState();
}

class ExpenseDetails {
  final double amount;
  final String description;
  final String category;
  final String? imagePath;
  final DateTime date;
  final String accountType;
  final String toWho;

  ExpenseDetails({
    required this.amount,
    required this.description,
    required this.category,
    this.imagePath,
    required this.date,
    required this.accountType,
    required this.toWho,
  });
}

class _ExpenseEntryState extends State<ExpenseEntry> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedCategory = 'Food';
  final List<String> _categories = [
    'Housing',
    'Utilities',
    'Food',
    'Transportation',
    'Shopping',
    'Entertainment'
  ];
  DateTime _selectedDate = DateTime.now();
  String _accountType = 'Cash';
  final TextEditingController _toWhoController = TextEditingController();
  String? _imagePath;

  void _saveExpense() {
    // Validate input
    if (_amountController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    final expense = ExpenseDetails(
      amount: double.parse(_amountController.text),
      description: _descriptionController.text,
      category: _selectedCategory,
      imagePath: _imagePath,
      date: _selectedDate,
      accountType: _accountType,
      toWho: _toWhoController.text,
    );

    widget.onSave(expense);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.purpleAccent,
              onPrimary: Colors.white,
              surface: Color(0xFF1E1E1E),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF121212),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: widget.onCancel,
        ),
        title: Row(
          children: [
            const Text(
              'Add New ',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.purpleAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Expense',
                style: TextStyle(
                  color: Colors.purpleAccent.shade200,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Main scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Amount Field
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Text(
                              '₹',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _amountController,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: '0',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Description Field
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _descriptionController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Description (e.g. Pizza Margherita)',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Other Details Dropdown

                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: InkWell(
                          onTap: () => _selectDate(context),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: Colors.white),
                              const SizedBox(width: 12),
                              Text(
                                DateFormat('MMM dd, yyyy')
                                    .format(_selectedDate),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Icon(Icons.account_balance_wallet,
                                color: Colors.white),
                            const SizedBox(width: 12),
                            DropdownButton<String>(
                              value: _accountType,
                              dropdownColor: const Color(0xFF1E1E1E),
                              style: const TextStyle(color: Colors.white),
                              underline: Container(),
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _accountType = newValue;
                                  });
                                }
                              },
                              items: <String>[
                                'Cash',
                                'Credit Card',
                                'Debit Card',
                                'Bank Transfer',
                                'UPI'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Icon(Icons.person, color: Colors.white),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: _toWhoController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: 'Paid to',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: InkWell(
                          onTap: () {
                            // In a real app, this would open image picker
                            setState(() {
                              _imagePath = 'placeholder_image_path';
                            });
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.camera_alt, color: Colors.white),
                              const SizedBox(width: 12),
                              Text(
                                _imagePath == null
                                    ? 'Add receipt or image'
                                    : 'Receipt added',
                                style: TextStyle(
                                  color: _imagePath == null
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                              ),
                              if (_imagePath != null) ...[
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.grey),
                                  onPressed: () {
                                    setState(() {
                                      _imagePath = null;
                                    });
                                  },
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Categories
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Icon(Icons.category, color: Colors.white),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(
                                    text: _selectedCategory),
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: 'Category',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCategory = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _categories.map((category) {
                            final bool isSelected =
                                _selectedCategory == category;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedCategory = category;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.green
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.green
                                          : Colors.grey.shade700,
                                    ),
                                  ),
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : getColorForCategory(category),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      // Add extra space at the bottom to ensure content doesn't get hidden behind the buttons
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),

            // Fixed bottom buttons
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF121212),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: widget.onCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('CANCEL'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveExpense,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('SAVE'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColorForCategory(String category) {
    switch (category) {
      case 'Housing':
        return Colors.blue;
      case 'Utilities':
        return Colors.purple;
      case 'Food':
        return Colors.green;
      case 'Transportation':
        return Colors.pink;
      case 'Shopping':
        return Colors.orange;
      case 'Entertainment':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }
}

// Example usage in your app
class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.purpleAccent,
      ),
      home: Scaffold(
        body: ExpenseEntry(
          onSave: (expense) {
            // Handle saving the expense
            debugPrint(
                'Expense saved: ${expense.description} - ₹${expense.amount}');
          },
          onCancel: () {
            // Handle cancel action
            debugPrint('Operation cancelled');
          },
        ),
      ),
    );
  }
}
