import 'package:chat_app/common/utils/colors.dart';
import 'package:chat_app/common/widgets/loader.dart';
import 'package:chat_app/features/auth/controller/auth_controller.dart';
import 'package:chat_app/features/chat/widgets/bottom_chat_field.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/features/chat/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = 'mobile-chat-screen';
  final String name;
  final String uid;
  final bool isGroupChat;
  const MobileChatScreen(
      {super.key,
      required this.name,
      required this.uid,
      required this.isGroupChat});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: isGroupChat
            ? Text(name)
            : StreamBuilder<UserModel>(
                stream: ref.read(authControllerProvider).userDataById(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  return Column(
                    children: [
                      Text(name),
                      Text(
                        snapshot.data!.isOnline ? 'online' : 'offline',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.normal),
                      )
                    ],
                  );
                }),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ChatList(recieverUserId: uid, isGroupChat: isGroupChat)),
          BottomChatField(recieverUserId: uid, isGroupChat: isGroupChat),
        ],
      ),
    );
  }
}
