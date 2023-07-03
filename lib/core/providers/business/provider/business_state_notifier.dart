//part of 'business_provider.dart';

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_admin_dashboard/core/types/syncresult.dart';
// import 'package:work_link/src/features/business/data/business_repository.dart';
// import 'package:work_link/src/models/custom_exception.dart';
// import 'package:work_link/src/models/profile/worker_profile.dart';

import '../../../exceptions/custom_exception.dart';
import '../../profile/worker_profile.dart';
import '../../../models/Business.dart';
import '../data/business_repository.dart';
import 'business_state.dart';

class BusinessNotifier extends StateNotifier<BusinessState> {
  BusinessNotifier({
    required IBusinessRepository businessRepository,
  })  : _businessRepository = businessRepository,
        super(BusinessState.initial());

  final IBusinessRepository _businessRepository;

  void resetState() {
    state = BusinessState.initial();
    print("Business state has been reset.");
  }
  // In case of sync conflict
  void resolveConflict(Business business) {
    state = BusinessState.data(business: business);
    print("Business state has been reset.");
  }

  Future<void> syncBusinesss() async {
    state = BusinessState.loading();

    try {
      print("Get sync starts");
      SyncResult getResp = await _businessRepository.getSyncBusinesss();
      print( getResp.message);
      if(!getResp.success!){
        if(getResp.code ==1){
          state = BusinessState.error(getResp.message);
        }else{
          //: To do: Handle conficts
        }
      }else{
        print("Post sync starts");
        final SyncResult resp = await _businessRepository.postSyncBusinesss();
        if(!resp.success!){
          state = BusinessState.error(resp.message);
        }else{
          state = BusinessState.loaded(resp.message);
        }
      }
    }catch (e) {
      if (e is CustomException) {
        state = BusinessState.error(e.message);
      } else  {
        state = BusinessState.error(e.toString());

      }

    }
  }
}
