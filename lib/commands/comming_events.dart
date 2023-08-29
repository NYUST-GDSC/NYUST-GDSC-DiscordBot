import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:nyxx_commands/nyxx_commands.dart';
import "package:nyxx/nyxx.dart";

ChatCommand commingEventsCommands = ChatCommand(
  'comming_events',
  '查看雲科 GDSC 即將到來的活動',
  id('intro', (IChatContext context) async {
    String msg = "以下是 NYUST GDSC 即將到來的活動!\n\n";

    final pastEvents = [];
    List<dynamic> futureEvents = [];
    Future<void> fetchCommingEvents() async {
      final NYUST_GDSC_ID = 3153;
      final now = DateTime.now().toLocal().toString();
      final url = 'https://gdsc.community.dev/api/chapter/$NYUST_GDSC_ID/event?fields=id,title,status,url,description_short,picture,venue_name,start_date,end_date';

      try {
        final response = await http.get(
          Uri.parse(url),
          headers: {'Accept-Encoding': 'application/json; charset=utf-8'}
          );
        if (response.statusCode == 200) {
           final responseBody = utf8.decode(response.bodyBytes);
          final data = jsonDecode(responseBody);
          final results = data['results'];
          
          results.forEach((event) {
            final startDate = DateTime.parse(event['start_date']);
            final formattedStartDate = startDate.toLocal().toString();
            if (formattedStartDate.compareTo(now) < 0) {
              pastEvents.add(event);
            } else {
              futureEvents.add(event);
            }
          });
        } else {
          print('Request failed with status: ${response.statusCode}');
        }
      } catch (error) {
        print('Error: $error');
      }
    }
    await fetchCommingEvents();
    print(futureEvents);
    if(futureEvents.isEmpty) {
        msg += "目前沒有即將到來的活動喔!\n";
    }else{
      for(int i = 0; i<futureEvents.length;i++){
        final eventDate = DateTime.parse(futureEvents[i]['start_date']);
        final formattedEventDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(eventDate);
        msg += "活動名稱: ${futureEvents[i]['title']} \n";
        msg += "活動時間: $formattedEventDate \n";
        msg += "活動連結: ${futureEvents[i]['url']} \n";
        msg += "活動簡介: ${futureEvents[i]['description_short']} \n";
        msg += "活動地點: ${futureEvents[i]['venue_name']} \n";
        msg += "\n";
      }
    }
    context.respond(MessageBuilder.content(msg));
  })
);


