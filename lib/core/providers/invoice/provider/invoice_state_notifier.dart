//part of 'invoice_provider.dart';

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_admin_dashboard/core/types/syncresult.dart';
// import 'package:work_link/src/features/invoice/data/invoice_repository.dart';
// import 'package:work_link/src/models/custom_exception.dart';
// import 'package:work_link/src/models/profile/worker_profile.dart';

import '../../../exceptions/custom_exception.dart';
import '../../business/data/business_repository.dart';
import '../../client/data/client_repository.dart';
import '../../profile/worker_profile.dart';
import '../../../models/Invoice.dart';
import '../data/invoice_repository.dart';
import 'invoice_state.dart';

class InvoiceNotifier extends StateNotifier<InvoiceState> {
  InvoiceNotifier({
    required IInvoiceRepository invoiceRepository,
    required IClientRepository clientRepository,
    required IBusinessRepository businessRepository,
  })  : _invoiceRepository = invoiceRepository,
        _clientRepository = clientRepository,
        _businessRepository = businessRepository,
        super(InvoiceState.initial());

  final IInvoiceRepository _invoiceRepository;
  final IClientRepository _clientRepository;
  final IBusinessRepository _businessRepository;

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
      SyncResult getClientsResp = new SyncResult(),
          getBusinessResp  = new SyncResult(),
          getInvoiceResp = new SyncResult();

      //Business get sync
      getBusinessResp = await _businessRepository.getSyncBusinesss();
      //Client get sync
      if(getBusinessResp.success) getClientsResp = await _clientRepository.getSyncClients();
      //Invoice get sync
      if(getClientsResp.success) getInvoiceResp = await _invoiceRepository.getSyncInvoices();

      if(getClientsResp.success && getBusinessResp.success && getInvoiceResp.success){
        SyncResult respBusiness =  new SyncResult();
        SyncResult respClient =  new SyncResult();
        SyncResult respInvoice =  new SyncResult();
        print("Post sync starts");
        respBusiness = await _businessRepository.postSyncBusinesss();
        if(respBusiness.success)  respClient = await _clientRepository.postSyncClients();
        if(respClient.success)  respInvoice = await _invoiceRepository.postSyncInvoices();

        if(respClient.success && respBusiness.success && respInvoice.success) {
          state = InvoiceState.loaded("Sync Complete");
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
