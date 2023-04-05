import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  const SearchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 2,
            left: 4,
            right: 4,
            child: Card(
              color: Colors.white,
              child: TextFormField(
                autofocus: true,
                autocorrect: false,
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  suffix: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.clear)),
                ),
                onFieldSubmitted: (text) {
                  Navigator.of(context).pop(text);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
