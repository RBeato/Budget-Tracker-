import 'package:budget_tracker/helper/get_category_color.dart';
import 'package:budget_tracker/item_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemContainer extends StatelessWidget {
  final Item item;

  const ItemContainer({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 2.0,
          color: getCategoryColor(item.category),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: ListTile(
        title: Text(item.name),
        subtitle:
            Text('${item.category} • ${DateFormat.yMd().format(item.date)}'),
        trailing: Text('-\$${item.price.toStringAsFixed(2)}'),
      ),
    );
  }
}
