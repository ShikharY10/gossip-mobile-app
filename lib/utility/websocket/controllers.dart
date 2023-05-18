import 'dart:isolate';
import 'package:gossip_frontend/database/models.dart';
import 'package:gossip_frontend/schema/schema.pb.dart';

import '../../database/config.dart';

class Controllers {
  DataBase db;
  SendPort mainSendPort;

  Controllers(this.db, this.mainSendPort);

  /// for handling a new partner request.
  /// Type: "011"
  makePartnerRequest(List<int> data) {
    PartnerRequest partnerRequest = PartnerRequest();
    partnerRequest.toObject(String.fromCharCodes(data));
    mainSendPort.send(partnerRequest);
  }

  /// for handling a new partner response.
  /// Type: "012"
  makePartnerResponse(List<int> data) {
    DeliveryPacket deliveryPacket = DeliveryPacket.fromBuffer(data);
    PartnerResponse partnerResponse = PartnerResponse();
    partnerResponse.toObject(String.fromCharCodes(deliveryPacket.payload));
    mainSendPort.send(partnerResponse);
  }

  /// for notifying that a partner has remove you.
  /// Type: "013"
  removePartnerNotify(List<int> data) {
    DeliveryPacket deliveryPacket = DeliveryPacket.fromBuffer(data);
    RemovePartnerNotify removePartnerNotify = RemovePartnerNotify();
    removePartnerNotify.toObject(String.fromCharCodes(deliveryPacket.payload));
    mainSendPort.send(removePartnerNotify);
  }
}