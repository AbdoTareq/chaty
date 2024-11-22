import 'package:flutter_new_template/export.dart';
import 'package:flutter_new_template/features/auth/presentation/cubit.dart';

class ChatDetailsPage extends StatelessWidget {
  const ChatDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async => await sl<AuthCubit>().logout(),
        child: Text('text', style: Theme.of(context).textTheme.displayLarge),
      ),
    );
  }
}
