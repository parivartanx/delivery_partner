import 'package:delivery_app/data/models/model.dart';
import 'package:intl/intl.dart';

class TextFormatter {
  static String getFormattedOrderId(String id) {
    if (!id.contains('#')) {
      return '#$id';
    }
    return id;
  }
}

class TimeFormatter {
  static String getEstimatedMinutes(String eta) {
    try {
      final now = DateTime.now();
      final etaTime = DateFormat('HH:mm').parse(eta);
      final etaDateTime = DateTime(
        now.year, 
        now.month, 
        now.day,
        etaTime.hour,
        etaTime.minute,
      );
      final adjustedEtaDateTime = etaDateTime.isBefore(now) 
          ? etaDateTime.add(const Duration(days: 1)) 
          : etaDateTime;
      final difference = adjustedEtaDateTime.difference(now).inMinutes;
      return '$difference mins';
    } catch (e) {
      return 'Unknown';
    }
  }

  /// Calculates the total estimated time to complete all orders
  static String calculateTotalEstimatedTime(List<Order> orders) {
    if (orders.isEmpty) {
      return '0 mins';
    }

    try {
      final now = DateTime.now();
      DateTime? latestEta;

      for (final order in orders) {
        final etaTime = DateFormat('HH:mm').parse(order.eta);
        final etaDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          etaTime.hour,
          etaTime.minute,
        );
        final adjustedEtaDateTime = etaDateTime.isBefore(now)
            ? etaDateTime.add(const Duration(days: 1))
            : etaDateTime;
        if (latestEta == null || adjustedEtaDateTime.isAfter(latestEta)) {
          latestEta = adjustedEtaDateTime;
        }
      }

      if (latestEta != null) {
        final totalMinutes = latestEta.difference(now).inMinutes;
        final hours = totalMinutes ~/ 60;
        final minutes = totalMinutes % 60;
        if (hours > 0) {
          return '$hours hr ${minutes > 0 ? '$minutes mins' : ''}';
        } else {
          return '$minutes mins';
        }
      }
      
      return 'Unknown';
    } catch (e) {
      return 'Unknown';
    }
  }
}