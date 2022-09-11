import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:flutter/material.dart';
import '../../../../../core/models/audiobook/audiobookfetchall.model.dart';
import '../../../../utils/audiobookdetail_argument.dart';

class AudiobookList extends StatelessWidget {
  final dynamic snapshot;
  const AudiobookList({Key? key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: snapshot.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Dataftadal audiodata = snapshot[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.AudioBookDetailRoute,
                  arguments:
                      AudiobookDetailArguments(id: audiodata.audiobookId));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                    width: 115,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 2, 1, 4),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(9),
                          topLeft: Radius.circular(9)),
                      image: DecorationImage(
                          image: NetworkImage(
                              audiodata.audiobookImagecover.toString()),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Container(
                    height: 27,
                    width: 115,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 2, 1, 4),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(9),
                          bottomLeft: Radius.circular(9)),
                    ),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          audiodata.audiobookAuthor.toString(),
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w600,
                              fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
