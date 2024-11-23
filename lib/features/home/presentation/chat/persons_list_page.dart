import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_new_template/core/feature/data/models/person_model.dart';
import 'package:flutter_new_template/core/view/widgets/avatar.dart';
import 'package:flutter_new_template/core/view/widgets/custom_cubit_builder.dart';
import 'package:flutter_new_template/export.dart';
import 'package:flutter_new_template/features/home/presentation/chat/persons_cubit.dart';

class PersonsListPage extends StatefulWidget {
  const PersonsListPage({super.key});

  @override
  State<PersonsListPage> createState() => _PersonsListPageState();
}

class _PersonsListPageState extends State<PersonsListPage> {
  PersonsCubit cubit = sl<PersonsCubit>();

  @override
  void initState() {
    cubit.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Persons'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomCubitBuilder<List<PersonModel>>(
          tryAgain: () => cubit.getAll(),
          cubit: cubit,
          onSuccess: (context, state) {
            return ListView.separated(
              itemCount: state.data?.length ?? 0,
              separatorBuilder: (BuildContext context, int index) =>
                  16.heightBox,
              itemBuilder: (context, index) {
                final item = state.data![index];
                return ListTile(
                  onTap: () {
                    context.pushNamed(Routes.chatDetails, extra: item);
                  },
                  leading: Avatar(item: item.email![0].toTitleCase()),
                  title: Text(
                    item.email ?? '',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  subtitle: Text(
                    item.status.toString().toTitleCase(),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
