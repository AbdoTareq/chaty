import 'package:flutter_new_template/export.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('text', style: Theme.of(context).textTheme.displayLarge),
      ],
    );
  }
}
