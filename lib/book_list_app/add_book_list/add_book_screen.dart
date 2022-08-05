import 'dart:typed_data';
import 'package:book_list_app/book_list_app/add_book_list/add_book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _titleTextController = TextEditingController();
  final _authorTextController = TextEditingController();

  final addViewModel = AddBookViewModel();
  final ImagePicker _picker = ImagePicker();

  // byte array
  Uint8List? _bytes;

  @override
  void dispose() {
    _titleTextController.dispose();
    _authorTextController.dispose();
    super.dispose();
  }

  final snackBar = const SnackBar(
    content: Text('제목과 저자를 모두 입력해주세요.'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('도서 추가'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              XFile? image =
              await _picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                // byte array
                _bytes = await image.readAsBytes();
                setState(() {});
              }
            },
            child: _bytes == null
                ? Container(
              width: 200,
              height: 200,
              color: Colors.grey,
            )
                : Image.memory(_bytes!, width: 200, height: 200),
          ),
          const SizedBox(height: 20),
          TextField(
            onChanged: (_) {
              setState(() {});
            },
            controller: _titleTextController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '제목',
            ),
          ),
          TextField(
            onChanged: (_) {
              setState(() {});
            },
            controller: _authorTextController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '저자',
            ),
          ),
          ElevatedButton(
              onPressed:
                addViewModel.isValid(
                  _titleTextController.text,
                  _authorTextController.text,
                )
                    ? null
                    : () {
                  addViewModel.addBook(
                    title: _titleTextController.text,
                    author: _authorTextController.text,
                    bytes: _bytes,
                  );
                  Navigator.pop(context);
                },
              child: Text('야야ㅣ이야')),
        ],
      ),
    );
  }
}
