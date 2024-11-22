import 'package:flutter_new_template/core/feature/data/models/person_model.dart';
import 'package:flutter_new_template/export.dart';
import 'package:flutter_new_template/features/auth/presentation/cubit.dart';
import 'package:flutter_new_template/features/home/presentation/chat/persons_cubit.dart';

class ChatDetailsPage extends StatefulWidget {
  const ChatDetailsPage({super.key, required this.person});
  final PersonModel person;

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final TextEditingController textController = TextEditingController();
  final PersonsCubit cubit = sl<PersonsCubit>();

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
                          widget.person.email![0].toTitleCase(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                title: Text(
                  widget.person.email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                subtitle: Text(
                  widget.person.status.toString().toTitleCase(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(child: Column(children: [])),
            ),
            Container(
                color: kGrey,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextInput(
                            controller: textController,
                            hint: 'Type a message',
                            color: kBlack,
                          ),
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.send))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
