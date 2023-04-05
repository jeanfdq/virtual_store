import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/components/app_bar.dart';
import 'package:virtual_store/components/lateral_menu.dart';
import 'package:virtual_store/services/admin_users_manager.dart';

class AdminUsers extends StatelessWidget {
  const AdminUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Admin - Usuários'),
      drawer: const LateralMenu(),
      body: Consumer<AdminUsersManager>(
        builder: (_, adminUsersManager, __) {
          return AlphabetListScrollView(
            strList: adminUsersManager.listOfNames,
            highlightTextStyle: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
            showPreview: true,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  isThreeLine: true,
                  minVerticalPadding: 0,
                  title: Text(adminUsersManager.listOfNames[index]),
                  subtitle: Text(adminUsersManager.listOfUsers[index].email),
                ),
              );
            },
            indexedHeight: (index) => 80,
          );
        },
      ),
    );
  }
}
