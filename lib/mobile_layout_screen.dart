import 'dart:io';

import 'package:chat_app/common/utils/utils.dart';
import 'package:chat_app/features/auth/controller/auth_controller.dart';
import 'package:chat_app/features/group/screens/create_group_screen.dart';
import 'package:chat_app/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:chat_app/features/status/screens/confirm_status_screen.dart';
import 'package:chat_app/features/status/screens/status_contacts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'common/utils/colors.dart';
import 'features/chat/widgets/contact_list.dart';

class MobileLayoutScreen extends ConsumerStatefulWidget {
  const MobileLayoutScreen({super.key});

  @override
  ConsumerState<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: appBarColor,
            centerTitle: false,
            title: const Text(
              'Chat App',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.grey),
                onPressed: () {},
              ),
              PopupMenuButton(
                  icon: const Icon(Icons.more_vert, color: Colors.grey),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            child: const Text('Create Group'),
                            onTap: () => Future(() => Navigator.pushNamed(
                                context, CreateGroupScreen.routeName)))
                      ])
            ],
            bottom: TabBar(
                controller: tabController,
                indicatorColor: tabColor,
                indicatorWeight: 4,
                labelColor: tabColor,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(
                    text: 'CHATS',
                  ),
                  Tab(text: 'STATUS'),
                  Tab(text: 'CALLS'),
                ]),
          ),
          body: TabBarView(controller: tabController, children: const [
            ContactList(),
            StatusContactsScreen(),
            Text('Calls')
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (tabController.index == 0) {
                Navigator.pushNamed(context, SelectContactsScreen.routeName);
              } else {
                XFile? pickedImage = await pickImageFromGallery(context);
                if (pickedImage != null) {
                  Navigator.pushNamed(context, ConfirmStatusScreen.routeName,
                      arguments: File(pickedImage.path));
                }
              }
            },
            backgroundColor: tabColor,
            child: const Icon(Icons.comment, color: Colors.white),
          ),
        ));
  }
}
