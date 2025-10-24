#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

SECRET=$((RANDOM%1000 + 1))

echo "Enter your username:"
read USERNAME

USERNAME_RESULT=$($PSQL "SELECT username FROM users WHERE username='$USERNAME'" | xargs)

if [[ -z $USERNAME_RESULT ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  $PSQL "INSERT INTO users(username, played_games, best_game_guesses) VALUES('$USERNAME', 0, 0);" > /dev/null
  GAMES=0
  BEST_GAME=0
else
  USER_INFO=$($PSQL "SELECT played_games, best_game_guesses FROM users WHERE username='$USERNAME'" | xargs)
  IFS="|" read GAMES BEST_GAME <<< "$USER_INFO"
  echo "Welcome back, $USERNAME! You have played $GAMES games, and your best game took $BEST_GAME guesses."
fi

echo "Guess the secret number between 1 and 1000:"
read GUESS

while [[ ! $GUESS =~ ^[0-9]+$ ]]
do
  echo "That is not an integer, guess again:"
  read GUESS
done

NUMBER_OF_GUESSES=1
((GAMES++))

while [[ $GUESS -ne $SECRET ]]
do
  ((NUMBER_OF_GUESSES++))
  if [[ $GUESS -lt $SECRET ]]
  then
    echo "It's higher than that, guess again:"
  elif [[ $GUESS -gt $SECRET ]]
  then
    echo "It's lower than that, guess again:"
  fi
  read GUESS
done

if [[ $BEST_GAME -eq 0 || $NUMBER_OF_GUESSES -lt $BEST_GAME ]]
then
  $PSQL "UPDATE users SET played_games=$GAMES, best_game_guesses=$NUMBER_OF_GUESSES WHERE username='$USERNAME'" > /dev/null
else
  $PSQL "UPDATE users SET played_games=$GAMES WHERE username='$USERNAME'" > /dev/null
fi

echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET. Nice job!"
exit