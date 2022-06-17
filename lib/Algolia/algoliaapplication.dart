import 'package:algolia/algolia.dart';

class AlgoliaApplication{
  static final Algolia algolia = Algolia.init(
    applicationId: 'BTPSH8PQQG', //ApplicationID
    apiKey: 'a05e4c50fd87ac32915d56125239557a', //search-only api key in flutter code
  );
}