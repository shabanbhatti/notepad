import 'package:flutter/material.dart';

class HomeNoDataWidget extends StatelessWidget {
  const HomeNoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 17,
                                        backgroundColor: Colors.amber,
                                        child: Icon(
                                          Icons.note,
                                          color:
                                              Theme.of(
                                                context,
                                              ).scaffoldBackgroundColor,
                                          size: 20,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          'No Notes added',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
    );
  }
}