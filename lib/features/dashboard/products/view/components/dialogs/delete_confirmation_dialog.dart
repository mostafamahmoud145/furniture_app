import 'package:flutter/material.dart';

Future<void> showDeleteConfirmationDialog({
  required BuildContext context,
  required String name,
  required VoidCallback onConfirm,
}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete $name?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Close the dialog
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              onConfirm(); // Call the confirmation callback
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}
