#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

INGRESO=$1

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  
  # Si el ingreso no es un numero
  if [[ ! $INGRESO =~ ^[0-9]+$ ]]
  then
    # Si la entrada tiene mas de dos caracteres
    LARGO_CADENA_INGRESO=$(echo -n "$INGRESO" | wc -m)
    if [[ $LARGO_CADENA_INGRESO -gt 2 ]]
    then
      # Datos por nombre de elemento atomico completo
      DATO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING (type_id) WHERE name='$INGRESO'")
      if [[ -z $DATO ]]
      then
        echo "I could not find that element in the database."
      else
        echo "$DATO" | while read BAR BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_CELSIUS BAR BOILING_CELSIUS BAR TYPE
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_CELSIUS celsius and a boiling point of $BOILING_CELSIUS celsius."
        done
      fi
    else
      Datos por simbolo de elemento atomico
      DATO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING (type_id) WHERE symbol='$INGRESO'")
      if [[ -z $DATO ]]
      then
        echo "I could not find that element in the database."
      else
        echo "$DATO" | while read BAR BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_CELSIUS BAR BOILING_CELSIUS BAR TYPE
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_CELSIUS celsius and a boiling point of $BOILING_CELSIUS celsius."
        done
      fi
    fi

  else
    # Datos por numero atomico
    DATO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number=$INGRESO")
    if [[ -z $DATO ]]
    then
      echo "I could not find that element in the database."
    else
      echo "$DATO" | while read BAR BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_CELSIUS BAR BOILING_CELSIUS BAR TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_CELSIUS celsius and a boiling point of $BOILING_CELSIUS celsius."
      done
    fi
  fi
fi