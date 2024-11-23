import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_new_template/core/feature/data/models/message_model.dart';
import 'package:flutter_new_template/core/feature/data/models/person_model.dart';
import 'package:flutter_new_template/core/view/widgets/chat_bubble.dart';
import 'package:flutter_new_template/core/view/widgets/custom_cubit_builder.dart';
import 'package:flutter_new_template/export.dart';
import 'package:flutter_new_template/features/home/presentation/chat/chat_cubit.dart';
import 'package:flutter_new_template/features/home/presentation/chat/persons_cubit.dart';

class ChatDetailsPage extends StatefulWidget {
  const ChatDetailsPage({super.key, required this.person});
  final PersonModel person;

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final TextEditingController textController = TextEditingController();
  final ChatCubit cubit = sl<ChatCubit>();
  final PersonsCubit personsCubit = sl<PersonsCubit>();
  late String chatId;

  @override
  void initState() {
    chatId =
        '${sl<FirebaseAuth>().currentUser?.email ?? ''}--${widget.person.email ?? ''}';
    cubit.getAll(chatId).then((r) {
      chatId =
          '${widget.person.email ?? ''}--${sl<FirebaseAuth>().currentUser?.email ?? ''}';
      cubit.getAll(chatId);
    });
    personsCubit.getAll();
    super.initState();
  }

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
                subtitle: CustomCubitBuilder<List<PersonModel>>(
                  tryAgain: () => personsCubit.getAll(),
                  cubit: personsCubit,
                  onSuccess: (context, state) {
                    return Text(
                      (state.data ?? [])
                          .firstWhere((p) => p.email == widget.person.email)
                          .status
                          .toString()
                          .toTitleCase(),
                      style: Theme.of(context).textTheme.labelLarge,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: CustomCubitBuilder<List<MessageModel>>(
                tryAgain: () => cubit.getAll(chatId).then((r) {
                  chatId =
                      '${widget.person.email ?? ''}--${sl<FirebaseAuth>().currentUser?.email ?? ''}';
                  cubit.getAll(chatId);
                }),
                cubit: cubit,
                onSuccess: (context, state) {
                  return ListView.separated(
                    itemCount: state.data?.length ?? 0,
                    separatorBuilder: (BuildContext context, int index) =>
                        16.heightBox,
                    itemBuilder: (context, index) {
                      final item = state.data?[index];
                      return item == null
                          ? Container()
                          : ChatBubble(message: item);
                    },
                  );
                },
              ),
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
                      SizedBox(
                        width: 40,
                        height: 30,
                        child: RoundedCornerLoadingButton(
                            color: kGrey,
                            onPressed: () async {
                              await cubit.sendMessage(
                                widget.person.email ?? '',
                                textController.text,
                                chatId,
                              );
                              textController.clear();
                            },
                            child: const Icon(Icons.send)),
                      ),
                      16.widthBox,
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
