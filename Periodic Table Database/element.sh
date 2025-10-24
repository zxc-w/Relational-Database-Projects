#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z "$1" ]]
then
  echo "Please provide an element as an argument."
  exit
fi

if [[ $1 =~ ^[0-9]+$ ]]
then
  SEARCH_COLUMN="atomic_number"
elif [[ $1 =~ ^[A-Za-z]{1,2}$ ]]
then
  SEARCH_COLUMN="symbol"
else
  SEARCH_COLUMN="name"
fi

RESULT=$($PSQL "
  SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass,
         p.melting_point_celsius, p.boiling_point_celsius, t.type
  FROM elements AS e
  JOIN properties AS p USING(atomic_number)
  JOIN types AS t USING(type_id)
  WHERE e.$SEARCH_COLUMN = '$1';
")

if [[ -z "$RESULT" ]]
then
  echo "I could not find that element in the database."
else
  IFS="|" read ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE <<< "$RESULT"
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi
