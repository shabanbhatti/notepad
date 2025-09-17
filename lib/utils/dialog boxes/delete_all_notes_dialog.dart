
import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/controllers/select_for_delete_controller.dart';
import 'package:provider/provider.dart';

void deleteMultipleItemDialog(BuildContext context, VoidCallback onDelete) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete Notes"),
        content: const Text("Are you sure?"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<CheckForDelete>(
                context,
                listen: false,
              ).afterDelete(context);

               

              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Row(
                    children: [
                      const Icon(Icons.delete, color: Colors.red),
                      Padding(
                        padding: EdgeInsets.only(left: 7),
                        child: const Text(
                          'Delete successfuly',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}