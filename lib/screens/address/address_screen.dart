import 'package:flutter/material.dart';
import 'package:virtual_store/screens/address/components/address_card.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Endereço'),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: const [
          AddressCard(),
        ],
      ),
    );
  }
}
