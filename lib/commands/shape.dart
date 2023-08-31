import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

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
enum Shape {
  triangle,
  square,
  pentagon,
}
