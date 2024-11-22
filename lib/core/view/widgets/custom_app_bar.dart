import 'package:flutter_new_template/features/auth/presentation/cubit.dart';

import '../../../export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(title: title.text, actions: [
      IconButton(
        onPressed: () async {
          await sl<AuthCubit>().logout();
          context.pushNamed(Routes.login);
        },
        icon: const Icon(Icons.exit_to_app),
      )
    ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
