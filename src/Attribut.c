

#include "Attribut.h"



attribut creer_attribut() {
    attribut a = malloc(sizeof(attribut));
    return a;
};

int adresse = 0;
void adresse_suivante(attribut a) {
    a->adresse = adresse;
    adresse++;
};
