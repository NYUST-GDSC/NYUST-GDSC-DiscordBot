import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";
import 'package:dotenv/dotenv.dart';

import 'package:role_bot/interactions/buttons_and_dropdowns.dart';

void initInteractions(INyxxWebsocket bot){
    var env = DotEnv(includePlatformEnvironment: true)..load();
    String guild = env['GUILD'] ?? '';
    
    IInteractions.create(WebsocketInteractionBackend(bot))
    ..registerSlashCommand(singleCommand) // Register created before slash command
    ..registerButtonHandler("thisisid", buttonHandler) // register handler for button with id: thisisid
    ..registerMultiselectHandler("customId", multiselectHandlerHandler) // register handler for multiselect with id: customId
    ..syncOnReady();
}