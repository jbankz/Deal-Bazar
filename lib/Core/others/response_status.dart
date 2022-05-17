import 'package:deal_bazaar/core/enums/process_status.dart';

class ResponseStatus {
  Map value;
  ProcessStatus? status;

  ResponseStatus({this.status, required this.value});
}
