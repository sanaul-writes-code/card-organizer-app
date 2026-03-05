import 'package:flutter/material.dart';
import '../models/folder.dart';
import '../repositories/folder_repository.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({super.key});

  @override
  State<FoldersScreen> createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen> {
  final FolderRepository repository = FolderRepository();
  List<Folder> folders = [];

  @override
  void initState() {
    super.initState();
    initializeFolders();
  }

  Future initializeFolders() async {
    await createDefaultFolders();
    await loadFolders();
  }

  Future createDefaultFolders() async {
    final existing = await repository.getFolders();
    if (existing.isEmpty) {
      await repository.createFolder(
        Folder(folderName: "Hearts", timestamp: DateTime.now().toString()),
      );
      await repository.createFolder(
        Folder(folderName: "Spades", timestamp: DateTime.now().toString()),
      );
      await repository.createFolder(
        Folder(folderName: "Diamonds", timestamp: DateTime.now().toString()),
      );
      await repository.createFolder(
        Folder(folderName: "Clubs", timestamp: DateTime.now().toString()),
      );
    }
  }

  Future loadFolders() async {
    final data = await repository.getFolders();

    setState(() {
      folders = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Card Folders")),
      body: ListView.builder(
        itemCount: folders.length,
        itemBuilder: (context, index) {
          final folder = folders[index];

          return ListTile(
            title: Text(folder.folderName),
            subtitle: Text("Created: older.timestamp}"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // next screen later
            },
          );
        },
      ),
    );
  }
}
