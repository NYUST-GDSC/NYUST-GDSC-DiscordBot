import 'package:nyxx/nyxx.dart';
import 'package:dotenv/dotenv.dart';

import 'package:role_bot/interactions/init.dart';
import 'package:role_bot/commands/init.dart';
import 'package:role_bot/plugins/commands.dart';


void main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();
  String token = env['BOT_TOKEN'] ?? '';
  print('BOT_TOEKN: $token');
  final client = NyxxFactory.createNyxxWebsocket(token, GatewayIntents.allUnprivileged | GatewayIntents.messageContent);

  client
    ..registerPlugin(Logging())
    ..registerPlugin(CliIntegration())
    ..registerPlugin(IgnoreExceptions())
    ..registerPlugin(commandPlugins);

  initInteractions(client);
  initCommands(client,commandPlugins);
  client.connect();
  // Listen to ready event. Invoked when bot is connected to all shards. Note that cache can be empty or not incomplete.
  client.eventsWs.onReady.listen((IReadyEvent e) {
    print("Discord Bot Ready!");
  });
}