#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~Clip & Curl~~\n"

MAIN_MENU() {
echo "Welcome to the Clip & Curl. Please choose from the following options:"
echo -e "\n1) Cut\n2) Color\n3) Perm\n4) Exit"
read SERVICE_ID_SELECTED

case $SERVICE_ID_SELECTED in
  1) CUSTOMER_INFO ;;
  2) CUSTOMER_INFO ;;
  3) CUSTOMER_INFO ;;
  4) EXIT ;;
  *) MAIN_MENU "Please choose a valid option." ;;
esac
}

CUSTOMER_INFO() {
echo -e "\nPlease enter your phone number."
read CUSTOMER_PHONE
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
if [[ -z $CUSTOMER_NAME ]]
then
  #ask for name
  echo -e "What is your name?"
  read CUSTOMER_NAME
  INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
fi

CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'")

#ask for time for service
echo -e "What time would you like to schedule your appointment?"
read SERVICE_TIME
#get customer_id
INSERT_TIME_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ('$CUSTOMER_ID','$SERVICE_ID_SELECTED','$SERVICE_TIME')")

echo -e "I have put you down for a$SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."

}

EXIT() {
 echo -e "OK. See you."
}

MAIN_MENU
