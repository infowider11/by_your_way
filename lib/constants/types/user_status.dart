class UserStatus{
  static const int pending = 0;
  static const int approved = 1;
  static const int rejected = 3;
  static const int blocked = 2;


  static String getName(int status, {int? secsLeft}){
    switch(status){
      case UserStatus.pending:return 'Pending';
      case UserStatus.approved:return 'Approved';
      case UserStatus.rejected: return 'Rejected';
      case UserStatus.blocked: return 'Blocked';

      default: return 'Pending';
    }
  }
}