import 'package:flutter/material.dart';
import 'package:virtual_store/services/user_account_manager.dart';
import 'package:virtual_store/utils/constants.dart';

class LateralMenuHeader extends StatelessWidget {
  const LateralMenuHeader({
    super.key,
    required this.userManager,
  });

  final UserAccountmanager userManager;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: kDefaultPadding, bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage(kImagePerfilAvatar),
            radius: 52,
          ),
          const SizedBox(
            height: kDefaultPadding,
          ),
          Text(
            'Olá, ${userManager.userData?.name ?? ''}',
            softWrap: true,
            maxLines: 3,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: kDefaultPadding / 2,
          ),
        ],
      ),
    );
  }
}
