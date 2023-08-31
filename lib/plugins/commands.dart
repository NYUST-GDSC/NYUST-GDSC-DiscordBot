  import 'package:nyxx_commands/nyxx_commands.dart';
  import "package:nyxx/nyxx.dart";
  import 'package:dotenv/dotenv.dart';
  
  var env = DotEnv(includePlatformEnvironment: true)..load();
  String guild = env['GUILD'] ?? '';
  CommandsPlugin commandPlugins = CommandsPlugin(
    prefix: (message) => '!',
    guild: Snowflake(guild),
    options: CommandsOptions(
      logErrors: true,
    ),
  );