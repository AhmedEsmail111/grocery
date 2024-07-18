import 'package:flutter/material.dart';
import 'package:grocery/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class AddressDialogueWidget extends StatefulWidget {
  const AddressDialogueWidget({super.key});

  @override
  State<AddressDialogueWidget> createState() => _AddressDialogueWidgetState();
}

class _AddressDialogueWidgetState extends State<AddressDialogueWidget> {
  String _enteredAddress = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return AlertDialog(
      title: const Text('Update'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          textInputAction: TextInputAction.done,
          initialValue: profileProvider.userInfo?.address,
          decoration: InputDecoration(
            hintText: 'Your new address..',
            hintStyle: const TextStyle().copyWith(
              color: Colors.black45,
            ),
          ),
          maxLines: 5,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Enter your new address';
            }
            return null;
          },
          onSaved: (value) {
            setState(() {
              _enteredAddress = value!;
            });
          },
          onEditingComplete: () {
            updateAddress(profileProvider: profileProvider);
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            updateAddress(profileProvider: profileProvider);
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: const Text('Update'),
        )
      ],
    );
  }

  Future<void> updateAddress({required ProfileProvider profileProvider}) async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      profileProvider.updateAddress(
          newAddress: _enteredAddress, context: context);
    }
  }
}
