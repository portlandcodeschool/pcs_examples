function compare(user_choice) {
    var computer_choice = 'spock';
    var user_wins;

    switch(user_choice) {
      case 'spock':
        break;
      case 'lizard':
        user_wins = true;
        break;
      case 'rock':
        user_wins = false;
        break;
      case 'paper':
        user_wins = true;
        break;
      case 'scissors':
        user_wins = false;
        break;
    }

    if (typeof user_wins === 'undefined') {
      alert('Tie!');
    }
    else if (user_wins === true) {
      alert('You win! I picked spock');
    }
    else {
      alert('You lose! I picked spock');
    }
};