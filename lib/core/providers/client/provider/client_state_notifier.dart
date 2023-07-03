//part of 'client_provider.dart';

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_admin_dashboard/core/types/syncresult.dart';
// import 'package:work_link/src/features/client/data/client_repository.dart';
// import 'package:work_link/src/models/custom_exception.dart';
// import 'package:work_link/src/models/profile/worker_profile.dart';

import '../../../exceptions/custom_exception.dart';
import '../../profile/worker_profile.dart';
import '../../../models/Client.dart';
import '../data/client_repository.dart';
import 'client_state.dart';

class ClientNotifier extends StateNotifier<ClientState> {
  ClientNotifier({
    required IClientRepository clientRepository,
  })  : _clientRepository = clientRepository,
        super(ClientState.initial());

  final IClientRepository _clientRepository;

  void resetState() {
    state = ClientState.initial();
    print("Client state has been reset.");
  }
  // In case of sync conflict
  void resolveConflict(Client client) {
    state = ClientState.data(client: client);
    print("Client state has been reset.");
  }

  Future<void> syncClients() async {
    state = ClientState.loading();

    try {
      print("Get sync starts");
      SyncResult getResp = await _clientRepository.getSyncClients();
      print( getResp.message);
      if(!getResp.success!){
        if(getResp.code ==1){
          state = ClientState.error(getResp.message);
        }else{
          //: To do: Handle conficts
        }
      }else{
        print("Post sync starts");
        final SyncResult resp = await _clientRepository.postSyncClients();
        if(!resp.success!){
          state = ClientState.error(resp.message);
        }else{
          state = ClientState.loaded(resp.message);
        }
      }
    }catch (e) {
      if (e is CustomException) {
        state = ClientState.error(e.message);
      } else  {
        state = ClientState.error(e.toString());

      }

    }
  }
}
