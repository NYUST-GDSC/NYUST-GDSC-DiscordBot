import 'package:nyxx_commands/nyxx_commands.dart';
import "package:nyxx/nyxx.dart";
import 'dart:math';
  
  ChatGroup throwCommandGroup = ChatGroup(
    'throw',
    '丟出物品',
    children: [
      ChatCommand(
        'coin',
        '丟銅板',
        id('throw-coin', (IChatContext context) {
          bool heads = Random().nextBool();

          context.respond(
              MessageBuilder.content('錢幣落地為 ${heads ? '正面' : '反面'}!'));
        }),

      ),
      ChatCommand(
        'die',
        '投骰子',
        id('throw-die', (IChatContext context) {
          int number = Random().nextInt(6) + 1;

          context.respond(MessageBuilder.content('骰子落地為 數字:$number!'));
        })
      ),
    ],
  );
