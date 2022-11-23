

#ifndef ATTRIBUT_H
#define ATTRIBUT_H
#include <stdlib.h>



typedef enum {INT} symb_value_type;

struct ATTRIBUT {

  char* nom;
  symb_value_type type;
  int int_val;
  int adresse; 

};

typedef struct ATTRIBUT *attribut;

attribut creer_attribut();

void adresse_suivante(attribut a);

#endif