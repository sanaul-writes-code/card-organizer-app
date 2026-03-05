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
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];

          return ListTile(
            title: Text(card.cardName),
            subtitle: Text(card.suit),
            trailing: const Icon(Icons.arrow_forward),
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
