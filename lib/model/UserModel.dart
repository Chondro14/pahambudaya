import 'package:meta/meta.dart';

class UserModel {
  const UserModel(
      {@required this.id,
      @required this.emailUser,
      @required this.nameUser,
      @required this.phoneUser,
      @required this.photoUser})
      : assert(emailUser != null),
        assert(id != null);
  final String emailUser;
  final String nameUser;
  final String id;
  final String photoUser;
  final String phoneUser;
  static const empty = UserModel(
      id: '', emailUser: '', nameUser: null, phoneUser: null, photoUser: null);

  @override
  // TODO: implement props
  List<Object> get props => [emailUser, id, nameUser, photoUser, phoneUser];
}
