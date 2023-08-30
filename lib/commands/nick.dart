import 'package:nyxx_commands/nyxx_commands.dart';
import "package:nyxx/nyxx.dart";
  
ChatCommand nickCommands = ChatCommand(
  'nick',
  "更改暱稱 !nick 選擇目標 新暱稱",
  id('nick', (IChatContext context, IMember target, String newNick) async {
    try {
      await target.edit(builder: MemberBuilder()..nick = newNick);
    } on IHttpResponseError {
      context.respond(MessageBuilder.content("無法更改暱稱 :/"));
      return;
    }
    context.respond(MessageBuilder.content('成功更改暱稱!'));
  }),
);