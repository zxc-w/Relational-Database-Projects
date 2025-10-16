#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals
do

if [[ $winner != winner && $opponent != opponent ]]
then
  WINNER_NAME="$($PSQL "SELECT name FROM teams WHERE name='$winner'")"
  OPPONENT_NAME="$($PSQL "SELECT name FROM teams WHERE name='$opponent'")"

  if [[ -z $WINNER_NAME ]]
  then
    $PSQL "INSERT INTO teams(name) VALUES('$winner')"
  fi
  if [[ -z $OPPONENT_NAME ]]
  then
    $PSQL "INSERT INTO teams(name) VALUES('$opponent')"
  fi

  WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")"
  OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")"

  $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($year, '$round', $WINNER_ID, $OPPONENT_ID, $winner_goals, $opponent_goals)"
fi



done
