import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableListTile extends StatelessWidget {
  // Các thuộc tính cần thiết

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: ((context) async {
            }),
            icon: Icons.send,
            backgroundColor: Colors.grey,
            label: 'Gửi',
          ),
          SlidableAction(
            onPressed: ((context) async {
            }),
            icon: Icons.border_color,
            backgroundColor: Colors.green.shade900,
            label: 'Ký',
          ),
        ],
      ), child: Text('a'),
    );
  }
}
