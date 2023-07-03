// //part of 'invoice_provider.dart';
//
// import 'dart:developer';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:smart_admin_dashboard/core/types/syncresult.dart';
// // import 'package:work_link/src/features/invoice/data/invoice_repository.dart';
// // import 'package:work_link/src/models/custom_exception.dart';
// // import 'package:work_link/src/models/profile/worker_profile.dart';
//
// import '../../../exceptions/custom_exception.dart';
// import '../../profile/worker_profile.dart';
// import '../../../models/Sync.dart';
// import '../data/invoice_repository.dart';
// import 'invoice_state.dart';
//
// class SyncNotifier extends StateNotifier<SyncState> {
//   SyncNotifier({
//     required ISyncRepository invoiceRepository,
//   })  : _invoiceRepository = invoiceRepository,
//         super(SyncState.initial());
//
//   final ISyncRepository _invoiceRepository;
//
//   void resetState() {
//     state = SyncState.initial();
//     print("Sync state has been reset.");
//   }
//   // In case of sync conflict
//   void resolveConflict(Sync invoice) {
//     state = SyncState.data(invoice: invoice);
//     print("Sync state has been reset.");
//   }
//
//   Future<void> syncSyncs() async {
//     state = SyncState.loading();
//
//     try {
//       print("Get sync starts");
//       SyncResult getResp = await _invoiceRepository.getSyncSyncs();
//       print( getResp.message);
//       if(!getResp.success!){
//         if(getResp.code ==1){
//           state = SyncState.error(getResp.message);
//         }else{
//           //: To do: Handle conficts
//         }
//       }else{
//         print("Post sync starts");
//         final SyncResult resp = await _invoiceRepository.postSyncSyncs();
//         if(!resp.success!){
//           state = SyncState.error(resp.message);
//         }else{
//           state = SyncState.loaded(resp.message);
//         }
//       }
//     }catch (e) {
//       if (e is CustomException) {
//         state = SyncState.error(e.message);
//       } else  {
//         state = SyncState.error(e.toString());
//
//       }
//
//     }
//   }
// }
