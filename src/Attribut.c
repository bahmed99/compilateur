

#include "Attribut.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

symbol_value_type creer_symbol_value_type() {
    symbol_value_type a = malloc(sizeof(symbol_value_type));
    return a;
};

int adresse = 0;
int adresse_suivante() {
    return adresse++;
};

int label = 0;
int label_suivant() {
    return label++;
};

symbol_value_type copy_symbol_value_type(symbol_value_type x) {
  symbol_value_type a;
  a  = malloc (sizeof(symbol_value_type));
  memcpy(a,x,sizeof(symbol_value_type));
  return a;
}


// symbol_value_type exp_arith(symbol_value_type x, symbol_value_type y, char op) {
//     symbol_value_type a = creer_symbol_value_type();
//     a->type = x->type;
//      if(a->type==INT){
//         if(strcmp(op,"+")==0){
//             a->int_val=x->int_val+y->int_val;
//         }
//         else if(strcmp(op,"-")==0){
//             a->int_val=x->int_val-y->int_val;
//         }
//         else if(strcmp(op,"*")==0){
//             a->int_val=x->int_val*y->int_val;
//         }
//         else if(strcmp(op,"/")==0){
//             a->int_val=x->int_val/y->int_val;
//         }
       
//     }
//     else if(x->type==FLOA){
//         if(strcmp(op,"+")==0){
//             a->float_val=x->float_val+y->float_val;
//         }
//         else if(strcmp(op,"-")==0){
//             a->float_val=x->float_val-y->float_val;
//         }
//         else if(strcmp(op,"*")==0){
//             a->float_val=x1->float_val*x2->float_val;
//         }
//         else if(strcmp(op,"/")==0){
//             a->float_val=x1->float_val/x2->float_val;
//         }
//     }
//   return a;
// }

