#!/bin/bash

echo -e "\n~~~~~ My Salon ~~~~~"

PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo -e "\nWelcome to My Salon, how can I help you?\n"
  AVAILABLE_SERVICES=$($PSQL "SELECT * FROM services")
  if [[ -z $AVAILABLE_SERVICES ]]
  then
    echo -e "\nSorry, services aren't available."
  else
    echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
    do
      echo "$SERVICE_ID) $SERVICE_NAME"
    done
  fi

  echo -e "\nWhich service would you like to choose?"
  read SERVICE_ID_SELECTED

  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")

  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ || -z $SERVICE_NAME ]]
  then
    MAIN_MENU "Invalid serivce, please choose again."
  else
    BOOK_SERVICE $SERVICE_ID_SELECTED "$SERVICE_NAME"
  fi
}

BOOK_SERVICE() {
  SERVICE_NAME=$(echo $2 | sed 's/^ *//')

  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'" | sed 's/^ *//')
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nLooks like you're a new customer, What's your name?"
    read CUSTOMER_NAME
    INSERT_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")

    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
    read SERVICE_TIME
  else
    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
    read SERVICE_TIME
  fi
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  INSERT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $1, '$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."

}

MAIN_MENU