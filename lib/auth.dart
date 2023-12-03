import 'package:mathe/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';
import 'dart:math';

class AuthService {
  // Connect to Supabase
  final supabase = SupabaseClient(ADD, ANON);
  // Create SharedPreference Object
  final SharedPreferences prefs;

  AuthService(this.prefs);

  // Function which checks if user is already authenticated, useful when pregame page is invoked again
  bool isLogged(){
    final user = supabase.auth.currentUser;
    if(user != null){
      return true;
    }
    else{
      return false;
    }
  }

  // Function for authentication using supabase
  Future<void> authenticate() async {
    // Generate a random email
    String email = generateRandomEmail();
    // Random password, as users do not have a endpoint to login
    String pass = "123Mathe@Mentally";
    // String phone = "9999999999";
    // Creating a gamertag
    String gamertag = createGamertag();

    // TODO : check if a gamertag already exists from supabase

    // Authenticate with supabase using the generated email
    if(!prefs.containsKey("email")){
      // Adding email to shared preferences
      await prefs.setString('email', email);
      // getting response from supabase
      final response = await supabase.auth.signUp(email : email, password : pass);
      await supabase
          .from('players')
          .insert({'gamertag': gamertag, 'email': email});

        print(gamertag);

      await prefs.setString('gamertag', gamertag);

      if (response.user != null) {
        print('Authentication failed: ${response.user}');
      } else {
        print('Authentication successful!');
      }
    }
    else{
      // Signing in
      final response = await supabase.auth.signInWithPassword(
        email: prefs.getString("email"),
        password: pass,
      );
      if (response.user == null) {
        print('Authentication failed: ${response}');
      } else {
        print('Authentication successful!');
      }
    }

  }


  // Using a function to crate a unique random email
  String generateRandomEmail() {
    String randomNumber = '${DateTime.now().millisecondsSinceEpoch % 100000000}';
    String email = 'user_$randomNumber@mentally.project';
    return email;
  }


  // Function which allows creation of a gamertag
  String createGamertag() {
    List<String> adjectives = [
      'Smoky',
      'Fierce',
      'Brave',
      'Sneaky',
      'Daring',
      'Swift',
      'Swift',
      'Wise',
      'Arcane',
      'Noble',
    ];

    List<String> nouns = [
      'Shadow',
      'Wolf',
      'Dragon',
      'Fox',
      'Hawk',
      'Panther',
      'Tiger',
      'Lion',
      'Serpent',
      'Raven',
    ];

    Random rand = Random();
    String adjective = adjectives[rand.nextInt(adjectives.length)];
    String noun = nouns[rand.nextInt(nouns.length)];
    int number = rand.nextInt(900) + 100;

    // Combining all parts
    return '$adjective$noun$number';
  }
}

