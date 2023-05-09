bool useTestUrl = true;

final String testBaseUrl = 'https://test-api.myworklink.uk/';
// final String testBaseUrl = 'http://localhost:8765/';
// 'https://testa.myworklink.uk/';
final String liveBaseUrl = 'https://api.myworklink.uk/';

final String baseUrl = useTestUrl ? testBaseUrl : liveBaseUrl;
const String dataService = 'worklink-api'; // worklink-api-test // worklink-api-live
const String authService = 'oauth-service';
const String userService = 'user-service';

/// loader state enum
enum Loader {
  None,
  Loading,
  Complete,
  Error,
}

enum RequestState {
  None,
  Loaded,
  Error,
  Failed,
}
