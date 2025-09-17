import 'package:flutter/material.dart';


class CustomTextfield extends StatelessWidget {
  const CustomTextfield({super.key, required this.onFunction, required this.controller});

  final void Function(String value) onFunction;
  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return TextField(
            cursorColor: Colors.black,
            style: const TextStyle(color: Colors.black),
            controller: controller,
            onChanged:onFunction,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.black),

              label: const Text(
                'Search',
                style: TextStyle(color: Colors.black),
              ),

              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 152, 116, 9),
                ),
              ),
            ),
          );
  }
}
