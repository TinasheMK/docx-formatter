//part of 'invoice_provider.dart';

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_admin_dashboard/providers/invoice/model/syncresult.dart';
// import 'package:work_link/src/features/invoice/data/invoice_repository.dart';
// import 'package:work_link/src/models/custom_exception.dart';
// import 'package:work_link/src/models/profile/worker_profile.dart';

import '../../custom_exception.dart';
import '../../profile/worker_profile.dart';
import '../../registration/Invoice.dart';
import '../data/invoice_repository.dart';
import 'invoice_state.dart';

class InvoiceNotifier extends StateNotifier<InvoiceState> {
  InvoiceNotifier({
    required IInvoiceRepository invoiceRepository,
  })  : _invoiceRepository = invoiceRepository,
        super(InvoiceState.initial());

  final IInvoiceRepository _invoiceRepository;

  void resetState() {
    state = InvoiceState.initial();
    print("Invoice state has been reset.");
  }
  // In case of sync conflict
  void resolveConflict(Invoice invoice) {
    state = InvoiceState.data(invoice: invoice);
    print("Invoice state has been reset.");
  }

  Future<void> syncInvoices() async {
    state = InvoiceState.loading();

    try {
      print("Get sync starts");
      InvoiceSyncResult getResp = await _invoiceRepository.getSyncInvoices();
      print( getResp.message);
      if(!getResp.success!){
        if(getResp.code ==1){
          state = InvoiceState.error(getResp.message);
        }else{
          state = InvoiceState.data( invoice: getResp.invoice!);
        }
      }else{
        print("Post sync starts");
        final InvoiceSyncResult resp = await _invoiceRepository.postSyncInvoices();
        if(!resp.success!){
          state = InvoiceState.error(resp.message);
        }else{
          state = InvoiceState.loaded(resp.message);
        }
      }
    }catch (e) {
      if (e is CustomException) {
        state = InvoiceState.error(e.message);
      } else  {
        state = InvoiceState.error(e.toString());

      }

    }
  }
}
