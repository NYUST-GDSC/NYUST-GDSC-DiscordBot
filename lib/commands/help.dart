import 'package:nyxx_commands/nyxx_commands.dart';
import "package:nyxx/nyxx.dart";

ChatCommand helpCommands = ChatCommand(
  'help',
  '查看雲科 GDSC Discord Bot 可用功能',
  id('intro', (IChatContext context) {
    String msg = "您好我是 國立雲林科技大學 GDSC Discord Bot!\n\n";
    msg += "!intro 查看所有 NYUST GDSC 相關連結 \n";
    msg += "!comming_events 即將到來的 NYUST GDSC 活動 \n";
    msg += "!throw 丟很多好玩的東西 擲硬幣/擲骰子 \n";
    msg += "!ping 測試 Bot 還活者嗎 \n";
    context.respond(MessageBuilder.content(msg));
  })
);