import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:clientapp/core/color/color.dart';
import 'package:clientapp/core/controller/controller.dart';
import 'package:clientapp/domain/model/model_chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import '../../widget/widget_out_room.dart';
import '../../widget/chat_buuble.dart';

class widget_body extends StatelessWidget {
  const widget_body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: backgroundColor,
      child: Obx(() => anonim_c.message.length == 0
          ? Container(
              color: backgroundColor,
            )
          : GroupedListView<model_chat, String>(
              reverse: true,
              elements: anonim_c.message,
              order: GroupedListOrder.DESC,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10),
              groupBy: (element) => DateFormat('yyyy-MM-dd').format(
                  DateFormat('yyyy-MM-dd HH:mm:ss')
                      .parse('${element.timestamp}')),
              groupComparator: (value1, value2) => value1.compareTo(value2),
              groupSeparatorBuilder: (element) => Center(
                    child: DateChip(
                        date: DateFormat('yyyy-MM-dd').parse(element),
                        color: grey),
                  ),
              itemBuilder: (context, element) {
                if (element.status?.value != 'out') {
                  return ChatBuuble(data: element);
                } else if (element.status?.value == 'out') {
                  return widget_out_room(data: element);
                } else {
                  return SizedBox();
                }
              })),
    ));
  }
}
