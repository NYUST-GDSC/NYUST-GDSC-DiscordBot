import 'package:nyxx_commands/nyxx_commands.dart';
import "package:nyxx/nyxx.dart";
import 'dart:io';

ChatCommand meCommands = ChatCommand(
  'me',
  '查看我這支 Bot 資訊',
  id('intro', (IChatContext context) {
    String msg = "您好我是 國立雲林科技大學 GDSC Discord Bot!\n\n";
    msg += "我是建構於 Dart ${Platform.version} \n";
    msg += "作業系統: ${Platform.operatingSystem} 版本:${Platform.operatingSystemVersion} \n";
    msg += "同時也是個開源專案: https://github.com/NYUST-GDSC/NYUST-GDSC-DiscordBot \n";
    msg += "核心單元數: ${Platform.numberOfProcessors} \n";
    context.respond(MessageBuilder.content(msg));
  })
);