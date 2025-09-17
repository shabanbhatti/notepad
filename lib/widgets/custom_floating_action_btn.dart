import 'package:flutter/material.dart';

class CustomFloatingActionBtn extends StatelessWidget {
  const CustomFloatingActionBtn({super.key, required this.icon, required this.onTap});
final IconData icon;
final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
                      shape: CircleBorder(),
                      
                      backgroundColor: Colors.amber,
                      onPressed: onTap,
                      child: Icon(
                        icon,
                        
                        color: Theme.of(context).scaffoldBackgroundColor,
                        size: 40,
                      ),
                    );
  }
}