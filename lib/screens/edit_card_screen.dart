import 'package:flutter/material.dart';
import '../models/card.dart';
import '../repositories/card_repository.dart';

class EditCardScreen extends StatefulWidget {
  final int folderId;
  final CardModel? card;
  const EditCardScreen({super.key, required this.folderId, this.card});

  @override
  State<EditCardScreen> createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final CardRepository repository = CardRepository();
  String suit = "Hearts";

  @override
  void initState() {
    super.initState();
    if (widget.card != null) {
      nameController.text = widget.card!.cardName;
      imageController.text = widget.card!.imageUrl;
      suit = widget.card!.suit;
    }
  }

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
              onPressed: () async {
                final card = CardModel(
                  id: widget.card?.id,
                  cardName: nameController.text,
                  suit: suit,
                  imageUrl: imageController.text,
                  folderId: widget.folderId,
                );
                if (widget.card == null) {
                  await repository.createCard(card);
                } else {
                  await repository.updateCard(card);
                }
                Navigator.pop(context, true);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
