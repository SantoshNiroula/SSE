class SseModel {
  final int? id;
  final String? event;
  final String? data;

  SseModel({this.id, this.event, this.data});

  factory SseModel.fromText(String text) {
    final splittedData = text.split('\n');
    int? id;
    String? event;
    String? data;

    for (final info in splittedData) {
      final splitByColon = info.split(':');
      if (splitByColon.isEmpty) continue;
      switch (splitByColon.first) {
        case 'id':
          id = int.tryParse(info.substring(3));
        case 'event':
          event = info.substring(6);
        case 'data':
          data = info.substring(5);
      }
    }

    return SseModel(id: id, data: data, event: event);
  }
}
