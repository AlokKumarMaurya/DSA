import 'package:network_service/network_service.dart';

class ChatDetailListEntity extends BaseEntity{
  final List<Message> messages;

  ChatDetailListEntity({required this.messages, required super.message});
}