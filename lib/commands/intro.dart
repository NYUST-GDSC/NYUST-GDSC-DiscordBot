import 'package:nyxx_commands/nyxx_commands.dart';
import "package:nyxx/nyxx.dart";

ChatCommand introCommands = ChatCommand(
  'intro',
  '查看雲科 GDSC 資訊',
  id('intro', (IChatContext context) {
    String msg = "您好我是 國立雲林科技大學 GDSC Discord Bot!\n\n";
    msg += "活動報名官方網站: https://gdsc.community.dev/national-yunlin-university-of-science-and-technology/ \n";
    msg += "官方網站: https://nyust-gdsc.github.io/#/ \n";
    msg += "Instagram: https://www.instagram.com/gdsc_nyust/ \n";
    msg += "Flickr: https://www.flickr.com/groups/14843619@N20/members/ \n";
    msg += "Email:  gdsc_nyust@googlegroups.com \n";
    msg += "GitHub: https://github.com/NYUST-GDSC \n";
    context.respond(MessageBuilder.content(msg));
  })
);