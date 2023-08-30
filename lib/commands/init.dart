import "package:nyxx/nyxx.dart";
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:dotenv/dotenv.dart';
import 'package:role_bot/commands/comming_events.dart';

import 'package:role_bot/commands/intro.dart';
import 'package:role_bot/commands/ping.dart';
import 'package:role_bot/commands/nick.dart';
import 'package:role_bot/commands/throw.dart';
import 'package:role_bot/commands/help.dart';
import 'package:role_bot/commands/me.dart';

void initCommands(INyxxWebsocket bot,CommandsPlugin commands){
    var env = DotEnv(includePlatformEnvironment: true)..load();
    String guild = env['GUILD'] ?? '';

    commands.addCommand(ping);
    commands.addCommand(nickCommands);
    commands.addCommand(throwCommandGroup);
    commands.addCommand(introCommands);
    commands.addCommand(helpCommands);
    commands.addCommand(commingEventsCommands);
    commands.addCommand(meCommands);
}