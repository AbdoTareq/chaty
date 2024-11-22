import 'package:flutter_new_template/core/feature/data/models/person_model.dart';
import 'package:flutter_new_template/export.dart';
import 'package:flutter_new_template/features/auth/presentation/cubit.dart';

class ChatDetailsPage extends StatelessWidget {
  const ChatDetailsPage({super.key, required this.person});
  final PersonModel person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: SafeArea(
        child: Column(
          children: [
            Card(
              color: kBlack,
              elevation: 10,
              child: ListTile(
                leading: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      const BackButton(color: kPrimaryColor),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: kPrimaryColor,
                        child: Text(
                          person.email![0].toTitleCase(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                title: Text(
                  person.email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                subtitle: Text(
                  person.status.toString().toTitleCase(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(child: Column(children: [])),
            ),
          ],
        ),
      ),
    );
  }
}
