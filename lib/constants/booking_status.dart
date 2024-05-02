import 'package:flutter/material.dart';

import 'my_colors.dart';

// user request booking = bookingStatus=0, paymentStatus=0
// auto delete (5min) on paymentStatus=0 = (delete record)
// payment done = bookingStatus=0, paymentStatus=1
// provider accept in 15mins = bookingStatus=1
// auto cancel if 15 min not accept: booking status: 4
// provider rejected = bookingStatus=2 (Booking Rejected by provider)
// user cancel = bookingStatus=5(Booking Cancelled by user)
// auto cancel after 2hrs = bookingStatus=6(Booking automatic cancelled)
// provider cancel = bookingStatus=7(Booking Cancelled by provider)
//
// provider arrvied = bookingStatus=8(Provider arrived at location)
// auto cancel within 45mins = bookingStatus=9(User didn't confirm the arrive location, booking cancelled)
// user confirm = bookingStatus=10(User confirmed, booking started)
//
// provider mark as complete = bookingStatus=11(Provider completed the booking)
// user confirm on complete = bookingStatus=3 (User confirmed the confirmation, booking completed)
class BookingStatus{
  static const int pending = 0;
  static const int accepted = 1;
  static const int rejected = 2;
  static const int completed = 3;
  static const int autoCancelled = 4;
  static const int cancelledByUser = 5;
  static const int autoCancelledNotArrivedToLocation = 6;
  static const int cancelledByProvider = 7;
  static const int providerArrived = 8;
  static const int autoCancelledUserNotConfirmedProviderArrival = 9;
  static const int userConfirmedProviderArrival = 10;
  static const int providerMarkedBookingAsComplete = 11;

  static String bookingStatusName(int status, {int secsLeft = 0}){
    switch(status){
      case 0:{

        if(secsLeft<=0){
          return 'Cancelled';
        }
        return 'Pending';
      }
      case 1: return 'Accepted';
      case 2: return 'Rejected';
      case 3: return 'Completed';
      case 4: return 'Cancelled';
      default: return 'Pending';
    }
  }

  static Color getStatusColor(int status, {int secsLeft = 0}){
    switch(status){
      case 0:
        {
          if(secsLeft<=0){
            return MyColors.redColor;
          }
          return MyColors.yellowColor;
        }
      case 1: return MyColors.greenColor;
      case 2: return MyColors.redColor;
      case 3: return MyColors.greenColor;
      case 4: return MyColors.redColor;
      default: return MyColors.yellowColor;
    }
  }


  static Color getTextColor(int status, {int secsLeft = 0}){
    switch(status){
      case 0:
        {
          if(secsLeft<=0){
            return MyColors.whiteColor;
          }
          return MyColors.blackColor;
        }
      case 1: return MyColors.whiteColor;
      case 2: return MyColors.whiteColor;
      case 3: return MyColors.whiteColor;
      case 4: return MyColors.whiteColor;
      default: return MyColors.blackColor;
    }
  }
}

// Upcoming: Pending (booking sent, waiting for pet sitter to confirm), In progress (booking confirmed, waiting for the start date or booking has already started and there are still ongoing dates)
// Completed: Completed, Declined, Canceled