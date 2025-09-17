import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key, required this.isGrid});
  final bool isGrid;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child:
          (isGrid == true)
              ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 100,
                itemBuilder:
                    (context, index) => const ListTile(
                      shape: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 207, 207, 207),
                      ),
                      title: Text('My Notes'),
                      subtitle: Text('My Sub title note'),
                      trailing: Text('Today 12:30 AM'),
                    ),
              )
              : Padding(
                padding: EdgeInsets.all(11),
                child: GridView.builder(
                  itemCount: 100,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => _loadingCard(context),
                ),
              ),
    );
  }
}

Widget _loadingCard(BuildContext context) {
  var mqSize = MediaQuery.of(context).size;
  return Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: mqSize.height * 0.1,
          width: mqSize.width,

          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color.fromARGB(255, 186, 186, 186),
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(right: 10, left: 10),
          child: Column(
            children: [
              Text(
                '(NO TITLE)',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),

              Text(
                '(NO DESCRIPTION)',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color.fromARGB(255, 134, 134, 134),
                ),
              ),
            ],
          ),
        ),

        Text('Today 02:40 PM', style: const TextStyle(fontSize: 10)),
      ],
    ),
  );
}
