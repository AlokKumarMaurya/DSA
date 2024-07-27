library chat_module;

import 'package:chat_module/src/data/datasource/chat_data_source/chat_data_source.dart';
import 'package:chat_module/src/data/repo_impl/chat_repo_impl/chat_repo_impl.dart';
import 'package:chat_module/src/domain/repositories/chat_list_repo/chat_list_repo.dart';
import 'package:network_service/network_service.dart';

import 'src/domain/usecase/chat_useCase/chat_useCase.dart';

export './src/utils/chat_routes/chat_route.dart';

class ChatModuleDependencyInjection {
  void init() {
    _putDataSource();
    _putRepo();
    _putUseCases();
  }
void _putDataSource(){
  Get.lazyPut<ChatDataSource>(()=>ChatDataSourceImpl());
}

  void _putRepo() {
    Get.lazyPut<ChatListRepo>(() => ChatRepoImpl());
  }

  void _putUseCases() {
    Get.lazyPut(() => ChatUseCase());
  }
}
