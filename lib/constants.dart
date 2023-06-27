bool useTestUrl = true;

final String testBaseUrl = 'http://10.0.2.2:8765/';
// 'https://testa.myworklink.uk/';
final String liveBaseUrl = 'https://api.myworklink.uk/';

final String baseUrl = useTestUrl ? testBaseUrl : liveBaseUrl;
const String invoicerService = 'invoicer-service'; // worklink-api-test // worklink-api-live
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
