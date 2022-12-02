
%{

  // header included in y.tab.h
#include "Attribut.h"  
#include "Table_des_symboles.h"
#include <stdio.h>
#include <string.h>

FILE * file_in = NULL;
FILE * file_out = NULL;
  
extern int yylex();
extern int yyparse();

void yyerror (char* s) {
   printf("\n%s\n",s);
 }



%}


%union {
 int val_int;
 char* val_string;
 float val_float;
 int num_label;
 char* char_comp;
}
%token <val_int> NUM 
%token <val_string> ID 
%token <val_float> FLOAT 

%type <val_int>  arith_exp
%type <num_label> else cond
%type <char_comp>  comp

%token  STRING 

%token PV LPAR RPAR LET IN VIR

%token IF THEN ELSE

%token ISLT ISGT ISLEQ ISGEQ ISEQ
%left ISEQ
%left ISLT ISGT ISLEQ ISGEQ
%token AND OR NOT BOOL
%left OR
%left AND




%token PLUS MOINS MULT DIV EQ
%left PLUS MOINS
%left MULT DIV
%left CONCAT
%nonassoc UNA    /* pseudo token pour assurer une priorite locale */




%start prog 
 


%%

 /* a program is a list of instruction */

prog : inst PV 

| prog inst PV 

/* a instruction is either a value or a definition (that indeed looks like an affectation) */

inst : let_def
| exp {printf("DROP \n");};



let_def : def_id
| def_fun
;

def_id : LET ID EQ exp          {
                                  if(! exister_symbol_value($2)){
                                    symbol_value_type c = creer_symbol_value_type();
                                    int x =adresse_suivante();
                                    c->adresse = x;
                                    c->nom = $2;
                                    set_symbol_value($2,c);
                                  }
                                  }     
;

def_fun : LET fun_head EQ exp {printf("Une définition de fonction\n");}
;

fun_head : ID LPAR id_list RPAR 
;

id_list : ID
| id_list VIR ID
;


exp : arith_exp 
| let_exp
;

arith_exp : MOINS arith_exp %prec UNA
| arith_exp MOINS arith_exp {printf("SUBI \n") ;$$=$1-$3;}
| arith_exp PLUS arith_exp {printf("ADDI \n") ;  $$=$1+$3;}
| arith_exp DIV arith_exp {printf("DIVI\n");$$=$1/$3;}
| arith_exp MULT arith_exp {printf("MULTI \n");$$=$1*$3;}
| arith_exp CONCAT arith_exp
| atom_exp 
;

atom_exp : NUM {printf("LOADI %d \n", $1);}
| FLOAT        {printf("LOADI %f \n", $1) ;}
| STRING    
| ID      {
          if(! exister_symbol_value($1))
          {
          printf("erreur : %s non declarée \n" , $1);
          exit (-1);
          }
          else
          {
          symbol_value_type x = get_symbol_value($1);printf("LOAD fp + %d \n", x->adresse);
          }}
| control_exp
| funcall_exp
| LPAR exp RPAR
;

control_exp : if_exp
;


if_exp : if cond then atom_exp else atom_exp {printf("L%d:\n",$5);}


if : IF 
cond : LPAR bool RPAR 
{  int l = label_suivant();
  printf("IFN L%d\n",l);
  $$=l;
  }

then : THEN ;
else : ELSE {
  int l=label_suivant();
  printf("GOTO L%d\n",l);
  printf("L%d:\n",l -1 );
  $$=l;
  }
   



let_exp : let_def IN atom_exp {printf("DRCP\n");}
| let_def IN let_exp
;

funcall_exp : ID LPAR arg_list RPAR
;

arg_list : arith_exp
| arg_list VIR  arith_exp
;

bool : BOOL
| bool OR bool
| bool AND bool
| NOT bool %prec UNA 
| exp comp exp {printf("%s\n",$2);}
| LPAR bool RPAR
;


comp :  ISLT {$$="LT";}
| ISGT {$$="GT";}
| ISLEQ {$$="LEQ";}
| ISGEQ {$$="GEQ";}
| ISEQ {$$="EQ";}
;

%% 
int main () {
  /* The code below is just a standard usage example.
     Of cours, it can be changed at will.

     for instance, one could grab input and ouput file names 
     in command line arguements instead of having them hard coded */

  stderr = stdin;
  
  /* opening target code file and redirecting stdout on it */
 file_out = fopen("test.p","w");
 stdout = file_out; 

 /* openng source code file and redirecting stdin from it */
 file_in = fopen("test.ml","r");
 stdin = file_in; 

 /* As a starter, on may comment the above line for usual stdin as input */
 
 yyparse ();

 /* any open file shall be closed */
 fclose(file_out);
 fclose(file_in);
 
 return 1;
} 

