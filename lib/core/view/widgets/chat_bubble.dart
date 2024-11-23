import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_new_template/core/feature/data/models/message_model.dart';
import 'package:flutter_new_template/export.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatefulWidget {
  final MessageModel message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  late bool isSender;
  @override
  void initState() {
    super.initState();
    isSender = widget.message.sender == sl<FirebaseAuth>().currentUser?.email;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isSender ? kPrimaryColor : kGrey,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft:
                isSender ? const Radius.circular(15) : const Radius.circular(0),
            bottomRight:
                isSender ? const Radius.circular(0) : const Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.message.message,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Text(
              '${DateFormat.yMd().format(widget.message.timestamp ?? DateTime.now())} ${DateFormat.jm().format(widget.message.timestamp ?? DateTime.now())}',
              style: const TextStyle(
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
