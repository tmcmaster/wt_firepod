import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:wt_models/wt_models.dart';

class FirepodModelView<T extends JsonSupport> extends StatelessWidget {
  final Query query;
  final T Function(DataSnapshot snapshot) snapshotToModel;
  final Widget Function(T model) itemBuilder;

  // TODO: need to add an errorBuilder and a waitingBuilder
  const FirepodModelView({
    super.key,
    required this.query,
    required this.snapshotToModel,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: query.onValue,
      builder: (context, snapshot) {
        final connectionState = snapshot.connectionState;

        if (connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return Text(':-(   ${snapshot.error}');
          } else if (snapshot.hasData) {
            final model = snapshotToModel(snapshot.data!.snapshot);
            return itemBuilder(model);
          } else {
            return const Center(child: Text('No Data'));
          }
        }
      },
    );
  }
}
