import 'package:chat_app/common/utils/colors.dart';
import 'package:flutter/material.dart';

import '../screens/mobile_chat_screen.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MobileChatScreen()));
                    },
                    child: const Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Text(
                            '',
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              '',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          leading: CircleAvatar(
                            //backgroundImage: NetworkImage(''),
                            radius: 30,
                          ),
                          trailing: Text(
                            '',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 13),
                          ),
                        ))),
                const Divider(
                  color: dividerColor,
                  indent: 85,
                )
              ],
            );
          }),
    );
  }
}
