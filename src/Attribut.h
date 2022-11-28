

#ifndef ATTRIBUT_H
#define ATTRIBUT_H
#include <stdlib.h>



typedef enum {INT,FLOA} type;

struct  symbol_value_type {

  char* nom;
  type type;
  int adresse; 

};

typedef struct  symbol_value_type* symbol_value_type;

symbol_value_type creer_symbol_value_type();

int adresse_suivante();

symbol_value_type copy_symbol_value_type(symbol_value_type);

symbol_value_type exp_arith(symbol_value_type , symbol_value_type , char*);



#endif