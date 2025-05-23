import 'package:get/get.dart';
import 'package:hyip_pro/data/model/base_model/api_response.dart';
import 'package:hyip_pro/data/model/response_model/view_ticket_model.dart';
import 'package:hyip_pro/data/repository/view_ticket_repo.dart';

import '../data/repository/ticket_file_download_repo.dart';


class TicketFileDownloadController extends GetxController{

  final TicketFileDownloadRepo ticketFileDownloadRepo;

  TicketFileDownloadController({required this.ticketFileDownloadRepo});


  bool _isLoading = false;
  bool get isLoading => _isLoading;


  ViewTicketModel viewTicketModel = ViewTicketModel();

  Future<dynamic> downloadTicketFile(dynamic id) async {
    _isLoading = true;
    update();
    ApiResponse apiResponse = await ticketFileDownloadRepo.downloadTicketFile(id);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoading = false;
      update();
    } else {
      _isLoading = false;
      update();
    }
  }

}