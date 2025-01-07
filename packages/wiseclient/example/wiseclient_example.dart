import 'package:wiseclient/wiseclient.dart';

void main() async {
  final options = WiseOptions.base(
    url: 'https://jsonplaceholder.typicode.com/',
  );
  final client = WiseClient(
    options: options,
    wiseInterceptors: [
      WiseInterceptor.logging,
    ],
  );

  await client.wGet('todos/1');
}
