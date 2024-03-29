import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://imgs.search.brave.com/qokLZbpvFJbkYeUJ_ExEElLoBBB_yv-dr_kd2-XHiF8/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9yZXNp/emVyLmdsYW5hY2lv/bi5jb20vcmVzaXpl/ci92Mi9zb2ZpYS12/ZXJnYXJhLWVzLWp1/cmFkby1lbi1sYS1u/dWV2YS10ZW1wb3Jh/ZGEtZGUtSEJKWklF/WDdZVkhGM0lGSFlP/Q0JUUFNCS1UuanBn/P2F1dGg9MjI1MWU2/NmUyODRiMDFlOTg1/MjMyMDVlMTdkYzg2/Y2IzNGY0NGMxNGUz/MzZiZmMxYWRhODUx/Y2UxMjNmYzExOSZ3/aWR0aD00MjAmaGVp/Z2h0PTQyMCZxdWFs/aXR5PTcwJnNtYXJ0/PXRydWU'),
          ),
        ),
        title: const Text('Sofi ❤️ '),
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.chatScrollController,
                  itemCount: chatProvider.messageList.length,
                  itemBuilder: (context, index) {
                    final message = chatProvider.messageList[index];
                    return (message.fromWho == FromWho.hers)
                        ? HerMessageBubble(message: message)
                        : MyMessageBubble(message: message);
                  }),
            ),

            //Caja de texto de mensajes
            MessageFieldBox(
              onValue: (value) => chatProvider.sendMessage(value),
            ),
            // const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
