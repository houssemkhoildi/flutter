import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class DashbordFirebaseUser {
  DashbordFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

DashbordFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<DashbordFirebaseUser> dashbordFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<DashbordFirebaseUser>(
      (user) {
        currentUser = DashbordFirebaseUser(user);
        return currentUser!;
      },
    );
