/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    NUM = 258,                     /* NUM  */
    ID = 259,                      /* ID  */
    FLOAT = 260,                   /* FLOAT  */
    STRING = 261,                  /* STRING  */
    PV = 262,                      /* PV  */
    LPAR = 263,                    /* LPAR  */
    RPAR = 264,                    /* RPAR  */
    LET = 265,                     /* LET  */
    IN = 266,                      /* IN  */
    VIR = 267,                     /* VIR  */
    IF = 268,                      /* IF  */
    THEN = 269,                    /* THEN  */
    ELSE = 270,                    /* ELSE  */
    ISLT = 271,                    /* ISLT  */
    ISGT = 272,                    /* ISGT  */
    ISLEQ = 273,                   /* ISLEQ  */
    ISGEQ = 274,                   /* ISGEQ  */
    ISEQ = 275,                    /* ISEQ  */
    AND = 276,                     /* AND  */
    OR = 277,                      /* OR  */
    NOT = 278,                     /* NOT  */
    BOOL = 279,                    /* BOOL  */
    PLUS = 280,                    /* PLUS  */
    MOINS = 281,                   /* MOINS  */
    MULT = 282,                    /* MULT  */
    DIV = 283,                     /* DIV  */
    EQ = 284,                      /* EQ  */
    CONCAT = 285,                  /* CONCAT  */
    UNA = 286                      /* UNA  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define NUM 258
#define ID 259
#define FLOAT 260
#define STRING 261
#define PV 262
#define LPAR 263
#define RPAR 264
#define LET 265
#define IN 266
#define VIR 267
#define IF 268
#define THEN 269
#define ELSE 270
#define ISLT 271
#define ISGT 272
#define ISLEQ 273
#define ISGEQ 274
#define ISEQ 275
#define AND 276
#define OR 277
#define NOT 278
#define BOOL 279
#define PLUS 280
#define MOINS 281
#define MULT 282
#define DIV 283
#define EQ 284
#define CONCAT 285
#define UNA 286

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 34 "myml.y"

 int val_int;
 char* val_string;
 float val_float;

#line 135 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
