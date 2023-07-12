import 'package:flutter/material.dart';
import 'package:km_test/features/third_screen/data/models/user_model.dart';

import '../../../../core/theme/base_colors.dart';

class ListItem extends StatefulWidget {
  final UserModel userModel;
  final Function onTap;

  const ListItem(
      {Key? key, required this.userModel, required this.onTap})
      : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    final user = widget.userModel;
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                user.avatarUrl,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${user.firstName} ${user.lastName}",
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  color: BaseColors.black,
                ),),
              Text(user.email, style: const TextStyle(
                fontSize: 10,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: BaseColors.lightGrey,
              ),),
            ],
          )
        ],
      ),
    );
  }
}
