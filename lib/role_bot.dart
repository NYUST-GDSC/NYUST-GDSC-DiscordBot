import 'dart:math';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:dotenv/dotenv.dart';


void main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();
  String token = env['BOT_TOKEN'] ?? '';
  String guild = env['GUILD'] ?? '';
  print('BOT_TOEKN: $token');

  final client = NyxxFactory.createNyxxWebsocket(token, GatewayIntents.allUnprivileged | GatewayIntents.messageContent);
  CommandsPlugin commands = CommandsPlugin(
    prefix: (message) => '!',
    // guild: Snowflake(guild),
    options: CommandsOptions(
      logErrors: true,
    ),
  );
  client.registerPlugin(commands);

  client
    ..registerPlugin(Logging())
    ..registerPlugin(CliIntegration())
    ..registerPlugin(IgnoreExceptions());

  client.connect();
  // Listen to ready event. Invoked when bot is connected to all shards. Note that cache can be empty or not incomplete.
  client.eventsWs.onReady.listen((IReadyEvent e) {
    print("Ready!");
  });
  client.eventsWs.onMessageReceived.listen((IMessageReceivedEvent e) async {
    if (e.message.content == "!create_channel") {
      if (e.message.guild == null) {
        return;
      }
      // Get guild object from message
      final guild = e.message.guild!.getFromCache()!;
      final channel = await guild.createChannel(TextChannelBuilder.create("Test channel")) as ITextGuildChannel;
      await e.message.channel.sendMessage(MessageBuilder.content("Crated ${channel.mention}"));
      await channel.delete();
      await e.message.channel.sendMessage(MessageBuilder.content("Deleted ${channel.mention}"));
    }
  });


  ChatCommand ping = ChatCommand(
    'ping',
    'Checks if the bot is online',
    id('ping', (IChatContext context) {
      context.respond(MessageBuilder.content('pong! Discord Bot is online!'));
    }),
  );

  commands.addCommand(ping);

  ChatGroup throwGroup = ChatGroup(
    'throw',
    'Throw an objet',
    children: [
      ChatCommand(
        'coin',
        'Throw a coin',
        id('throw-coin', (IChatContext context) {
          bool heads = Random().nextBool();

          context.respond(
              MessageBuilder.content('The coin landed on its ${heads ? 'head' : 'tail'}!'));
        }),

      ),
      ChatCommand(
        'die',
        'Throw a die',
        id('throw-die', (IChatContext context) {
          int number = Random().nextInt(6) + 1;

          context.respond(MessageBuilder.content('The die landed on the $number!'));
        })
      ),
    ],
  );

  commands.addCommand(throwGroup);

  ChatCommand say = ChatCommand(
    'say',
    'Make the bot say something',
    id('say', (IChatContext context, String message) {
      context.respond(MessageBuilder.content(message));
    }),
  );

  commands.addCommand(say);

  ChatCommand nick = ChatCommand(
    'nick',
    "Change a user's nickname",
    id('nick', (IChatContext context, IMember target, String newNick) async {
      try {
        await target.edit(builder: MemberBuilder()..nick = newNick);
      } on IHttpResponseError {
        context.respond(MessageBuilder.content("Couldn't change nickname :/"));
        return;
      }

      context.respond(MessageBuilder.content('Successfully changed nickname!'));
    }),
  );

  commands.addCommand(nick);

  Converter<Shape> shapeConverter = Converter<Shape>(
    (view, context) {
      switch (view.getQuotedWord().toLowerCase()) {
        case 'triangle':
          return Shape.triangle;
        case 'square':
          return Shape.square;
        case 'pentagon':
          return Shape.pentagon;
        default:
          return null;
      }
    },
    choices: [
      ArgChoiceBuilder('Triangle', 'triangle'),
      ArgChoiceBuilder('Square', 'square'),
      ArgChoiceBuilder('Pentagon', 'pentagon'),
    ],
  );

  commands.addConverter(shapeConverter);

  Converter<Dimension> dimensionConverter = CombineConverter<int, Dimension>(
    intConverter,
    (number, context) {
      switch (number) {
        case 2:
          return Dimension.twoD;
        case 3:
          return Dimension.threeD;
        default:
          return null;
      }
    },
  );

  commands.addConverter(dimensionConverter);

  ChatCommand favouriteShape = ChatCommand(
    'favourite-shape',
    'Outputs your favourite shape',
    id('favourite-shape', (IChatContext context, Shape shape, Dimension dimension) {
      String favourite;

      switch (shape) {
        case Shape.triangle:
          if (dimension == Dimension.twoD) {
            favourite = 'triangle';
          } else {
            favourite = 'pyramid';
          }
          break;
        case Shape.square:
          if (dimension == Dimension.twoD) {
            favourite = 'square';
          } else {
            favourite = 'cube';
          }
          break;
        case Shape.pentagon:
          if (dimension == Dimension.twoD) {
            favourite = 'pentagon';
          } else {
            favourite = 'pentagonal prism';
          }
      }

      context.respond(MessageBuilder.content('Your favourite shape is $favourite!'));
    }),
  );

  commands.addCommand(favouriteShape);

  ChatCommand favouriteFruit = ChatCommand(
    'favourite-fruit',
    'Outputs your favourite fruit',
    id('favourite-fruit', (IChatContext context, [String favourite = 'apple']) {
      context.respond(MessageBuilder.content('Your favourite fruit is $favourite!'));
    }),
  );

  commands.addCommand(favouriteFruit);

  ChatCommand alphabet = ChatCommand(
    'alphabet',
    'Outputs the alphabet',
    id('alphabet', (IChatContext context) {
      context.respond(MessageBuilder.content('ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
    }),
    checks: [
      CooldownCheck(
        CooldownType.user | CooldownType.guild,
        Duration(seconds: 30),
      )
    ],
  );

  commands.addCommand(alphabet);
}

enum Shape {
  triangle,
  square,
  pentagon,
}

enum Dimension {
  twoD,
  threeD,
}
