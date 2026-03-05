import 'package:flutter/material.dart';

class EditCardScreen extends StatefulWidget {
  const EditCardScreen({super.key});

  @override
  State<EditCardScreen> createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  String suit = "Hearts";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Card")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Card Name"),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: suit,
              items: const [
                DropdownMenuItem(value: "Hearts", child: Text("Hearts")),
                DropdownMenuItem(value: "Spades", child: Text("Spades")),
                DropdownMenuItem(value: "Diamonds", child: Text("Diamonds")),
                DropdownMenuItem(value: "Clubs", child: Text("Clubs")),
              ],
              onChanged: (value) {
                setState(() {
                  suit = value!;
                });
              },
              decoration: const InputDecoration(labelText: "Suit"),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: "Image URL"),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
