import 'package:nyxx_commands/nyxx_commands.dart';
import "package:nyxx/nyxx.dart";

ChatCommand ping = ChatCommand(
  'ping',
  '敲敲我還活者麻',
  id('ping', (IChatContext context) {
    context.respond(MessageBuilder.content('pong! NYUST GDSC Bot 還活者!'));
  })
);