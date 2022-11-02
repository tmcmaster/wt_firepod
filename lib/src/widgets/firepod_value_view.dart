import 'package:wt_firepod/wt_firepod.dart';

abstract class FirepodValueView<T> extends StatelessWidget {
  final Query query;
  final Widget Function(T model) itemBuilder;

  const FirepodValueView({
    super.key,
    required this.query,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: query.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text(':-(');
        } else if (snapshot.hasData) {
          try {
            final value = toValue(snapshot.data!.snapshot);
            return itemBuilder(value);
          } catch (error) {
            return const Text(':-(');
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  T toValue(DataSnapshot snapshot);
}
