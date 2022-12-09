
%{

  // header included in y.tab.h
#include "Attribut.h"  
#include "Table_des_symboles.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

FILE * file_in = NULL;
FILE * file_out = NULL;

FILE * file_funcall =NULL;
  
extern int yylex();
extern int yyparse();

int static label = 0;
int static offset = 0;
int static offset_func=1;
int get_label(){
  return label++;
}

int static detect_funcall = 0;
int static nb_param = 0;

void yyerror (char* s) {
   printf("\n%s\n",s);
 }



%}


%union {
 int val_int;
 char* val_string;
 float val_float;
}
%token <val_int> NUM 
%token <val_string> ID 
%token <val_float> FLOAT 

%type <val_int>  then else 
%type <val_string>  comp fun_id

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

def_id : LET ID EQ exp    { if(detect_funcall==0) {set_symbol_value($2, offset++);}else{set_symbol_value($2, offset_func++);}}     
;

def_fun : LET fun_head EQ exp {stdout = file_funcall;printf("return;\n}\n");detect_funcall=0;}
;

fun_head : ID LPAR id_list RPAR {stdout = file_funcall;printf("void call_%s(){\n",$1); };

id_list : ID {nb_param=1;detect_funcall=1;set_symbol_value($1, offset_func++);}
| id_list VIR ID {nb_param=nb_param+1;detect_funcall=1;set_symbol_value($3, offset_func++);}
;


exp : arith_exp 
| let_exp
;

arith_exp : MOINS arith_exp %prec UNA
| arith_exp MOINS arith_exp {if(detect_funcall==0) 
{
 stdout=file_out;
} 
else{
  stdout = file_funcall; 
  
}
 printf("SUBI \n");}
| arith_exp PLUS arith_exp 
{if(detect_funcall==0) 
{
 stdout=file_out;
} 
else{
  stdout = file_funcall; 
  
}
 printf("ADDI \n");}
| arith_exp DIV arith_exp 
| arith_exp MULT arith_exp 
{if(detect_funcall==0) 
{stdout=file_out;
  }
else{
  stdout = file_funcall; 

}
printf("MULTI \n");
}
| arith_exp CONCAT arith_exp
| atom_exp 
;

atom_exp : NUM { if(detect_funcall==0){ stdout=file_out;printf("LOADI %d \n", $1);}
else{stdout=file_funcall ;printf("LOADI %d \n", $1);}}
| FLOAT        {printf("LOADI %f \n", $1) ;}
| STRING    
| ID      {
      if(detect_funcall==1){
         if(get_symbol_value($1)==-1)
          {
          printf("erreur : %s non declarée \n" , $1);
          exit (-1);
          }
          else{
          stdout = file_funcall; 
          symb_value_type x = get_symbol_value($1);printf("LOAD (fp + %d)\n", x);

          }
         
      }else {
          stdout=file_out;
            if(get_symbol_value($1)==-1)
          {
          printf("erreur : %s non declarée \n" , $1);
          exit (-1);
          }
          else
          {
          symb_value_type x = get_symbol_value($1);printf("LOAD (fp + %d)\n", x);
          }}
      }
         
| control_exp
| funcall_exp 
| LPAR exp RPAR
;

control_exp : if_exp
;


if_exp : if cond then atom_exp else atom_exp {printf("L%d:\n",$5);}


if : IF 
cond : LPAR bool RPAR ;


then : THEN {  int l = get_label();
  printf("IFN L%d\n",l);
  $$=l;
  };
else : ELSE {
  int l=get_label();
  printf("GOTO L%d\n",l);
  printf("L%d:\n",$<val_int>-1 );
  $$=l;
  }
   



let_exp : let_def IN atom_exp {if(detect_funcall==0)
{                             stdout=file_out;
                                offset--; 
                                remove_symbol_value();
}
                            else{
                              
                              stdout=file_funcall;}
                              printf("DRCP\n"); 
                              offset_func--;
                              remove_symbol_value();
                              
                               }
| let_def IN let_exp
;

funcall_exp : fun_id LPAR arg_list RPAR 
{if(detect_funcall==0) 
{stdout=file_out; printf("CALL call_%s\n",$1);printf("RESTORE %d\n",nb_param);}
else{
  stdout=file_funcall; printf("CALL call_%s\n",$1);printf("RESTORE %d\n",nb_param);}
}
;

fun_id : ID {printf("SAVEFP\n");}

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
int main (int argc, char* argv[]) {
  /* The code below is just a standard usage example.
     Of cours, it can be changed at will.

     for instance, one could grab input and ouput file names 
     in command line arguements instead of having them hard coded */
  file_funcall = fopen (argv[3], "w");

  stderr = stdin;
   file_out = fopen(argv[2], "w");
  /* opening target code file and redirecting stdout on it */
   /*file_out = fopen("test.p","w");*/
 stdout = file_out; 
  file_in = fopen (argv[1], "r");

 /* openng source code file and redirecting stdin from it */
  /*file_in = fopen("test.ml","r"); */
 stdin = file_in; 

 /* As a starter, on may comment the above line for usual stdin as input */
 
 yyparse ();

 /* any open file shall be closed */
 fclose(file_out);
 fclose(file_in);
 
 return 1;
} 

