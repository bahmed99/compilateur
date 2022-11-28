

#include "Attribut.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

attribut creer_attribut() {
    attribut a = malloc(sizeof(attribut));
    return a;
};

int adresse = 0;
int adresse_suivante() {
    return adresse++;
};

attribut copy_attribut(attribut x) {
  attribut a;
  a  = malloc (sizeof(attribut));
  memcpy(a,x,sizeof(attribut));
  return a;
}


