// import 'package:flutter/material.dart';
// import 'package:notepad_app_using_database_sqflite/Modal%20class/notepad.dart';
// import 'package:notepad_app_using_database_sqflite/Routes/My%20Widget/Provider/animation_provider.dart';
// import 'package:notepad_app_using_database_sqflite/Routes/My%20Widget/Provider/notepad_home_provider.dart';
// import 'package:notepad_app_using_database_sqflite/Routes/My%20Widget/Provider/select_for_delete_prvider.dart';
// import 'package:provider/provider.dart';

// class SelectAndDelete extends StatelessWidget {
//   const SelectAndDelete({super.key, required this.notepad});

//   final List<Notepad> notepad;
//   @override
//   Widget build(BuildContext context) {
//     return (notepad.isEmpty)
//         ? const SliverToBoxAdapter(child: SizedBox())
//         : SliverPadding(
//           padding: const EdgeInsets.only(right: 10, top: 0),
//           sliver: SliverToBoxAdapter(
//             child: Consumer<CheckForDelete>(
//               builder:
//                   (context, value, child) => Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       (value.isSelected == true)
//                           ? SlideTransition(
//                             position: context.read<AnimationProvider>().slide,
//                             child: TextButton(
//                               onPressed: () {
//                                 context.read<CheckForDelete>().selectButton();
//                               },
//                               child: const Text(
//                                 'Select',
//                                 style: TextStyle(
//                                   color: Colors.amber,
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           )
//                           : SlideTransition(
//                             position: context.read<AnimationProvider>().slide,
//                             child: TextButton(
//                               onPressed: () {
//                                 for (var element in value.selecteditemList!) {
                                  
//                                   context
//                                       .read<ProviderForDatabase>()
//                                       .delete(element)
//                                       .then((valueX) {


//                                         Provider.of<CheckForDelete>(
//                                           context,
//                                           listen: false,
//                                         ).afterDelete(context);
                                       

//                                       });
//                                 }
//                               },
//                               child: const Text(
//                                 'Delete',
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                     ],
//                   ),
//             ),
//           ),
//         );
//   }
// }
