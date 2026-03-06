import 'package:flutter/material.dart';
import '../models/card.dart';
import '../repositories/card_repository.dart';
import 'edit_card_screen.dart';

class CardsScreen extends StatefulWidget {
  final int folderId;
  final String folderName;

  const CardsScreen({
    super.key,
    required this.folderId,
    required this.folderName,
  });

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  final CardRepository repository = CardRepository();
  List<CardModel> cards = [];

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  Future loadCards() async {
    final data = await repository.getCardsByFolder(widget.folderId);

    setState(() {
      cards = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.folderName)),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];

          return GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditCardScreen(folderId: widget.folderId, card: card),
                ),
              );
              if (result == true) {
                loadCards();
              }
            },
            onLongPress: () async {
              final confirm = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Delete Card"),
                  content: const Text(
                    "Are you sure you want to delete this card?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await repository.deleteCard(card.id!);
                loadCards();
              }
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          (card.suit.toLowerCase() == "jokers" ||
                              card.suit.toLowerCase() == "joker")
                          ? Image.asset(
                              "assets/images/${card.cardName.toLowerCase()}.png",
                              width: 100,
                              height: 140,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.style, size: 60),
                            )
                          : Image.asset(
                              "assets/images/${card.cardName.toLowerCase()}_of_${card.suit.toLowerCase()}.png",
                              width: 100,
                              height: 140,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.style, size: 60),
                            ),
                    ),
                  ),
                  Text(
                    card.cardName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(card.suit),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditCardScreen(folderId: widget.folderId),
            ),
          );
          if (result == true) {
            loadCards();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
