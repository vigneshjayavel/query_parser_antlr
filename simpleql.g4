grammar SimpleQL;

// NOTE: The following grammar is based on SQLite's simple select statement
// https://www.sqlite.org/lang_select.html

parse
 : ( simple_select_stmt | error )* EOF
 ;

error
 : UNEXPECTED_CHAR
   {raise Exception("UNEXPECTED_CHAR=" + $UNEXPECTED_CHAR.text)}
 ;

simple_select_stmt
 : select_core ( K_ORDER K_BY ordering_term ( ',' ordering_term )* )?
   ( K_LIMIT expr ( ( K_OFFSET | ',' ) expr )? )?
 ;

select_core
 : K_SELECT ( K_DISTINCT | K_ALL )? result_column ( ',' result_column )*
   ( K_FROM ( table_or_subquery ( ',' table_or_subquery )* | join_clause ) )?
   ( K_WHERE expr )?
   ( K_GROUP K_BY expr ( ',' expr )* ( K_HAVING expr )? )?
 ;

/*
    SQLite understands the following binary operators, in order from highest to
    lowest precedence:

    ||
    *    /    %
    +    -
    <<   >>   &    |
    <    <=   >    >=
    =    ==   !=   <>   IS   IS NOT   IN   LIKE   GLOB   MATCH   REGEXP
    AND
    OR
*/
expr
 : literal_value
 | BIND_PARAMETER
 | ( ( database_name '.' )? table_name '.' )? column_name
 | unary_operator expr
 | expr '||' expr
 | expr ( '*' | '/' | '%' ) expr
 | expr ( '+' | '-' ) expr
 | expr ( '<<' | '>>' | '&' | '|' ) expr
 | expr ( '<' | '<=' | '>' | '>=' ) expr
 | expr ( '=' | '==' | '!=' | '<>' | K_IS | K_IS K_NOT | K_IN | K_LIKE | K_GLOB | K_MATCH | K_REGEXP ) expr
 | expr K_AND expr
 | expr K_OR expr
 | function_name '(' ( K_DISTINCT? expr ( ',' expr )* | '*' )? ')'
 | '(' expr ')'
 | expr K_NOT? ( K_LIKE | K_GLOB | K_REGEXP | K_MATCH ) expr ( K_ESCAPE expr )?
 | expr ( K_ISNULL | K_NOTNULL | K_NOT K_NULL )
 | expr K_IS K_NOT? expr
 | expr K_NOT? K_BETWEEN expr K_AND expr
 ;

ordering_term
 : expr ( K_ASC | K_DESC )?
 ;


result_column
 : '*'
 | table_name '.' '*'
 | expr ( K_AS? column_alias )?
 ;

table_or_subquery
 : ( database_name '.' )? table_name ( K_AS? table_alias )?
 | '(' ( table_or_subquery ( ',' table_or_subquery )*
       | join_clause )
   ')' ( K_AS? table_alias )?
 ;

join_clause
 : table_or_subquery ( join_operator table_or_subquery join_constraint )*
 ;

join_operator
 : ','
 | K_NATURAL? ( K_LEFT K_OUTER? | K_INNER | K_CROSS )? K_JOIN
 ;

join_constraint
 : K_ON expr
 ;

literal_value
 : NUMERIC_LITERAL
 | STRING_LITERAL
 | K_NULL
 | K_CURRENT_TIME
 | K_CURRENT_DATE
 | K_CURRENT_TIMESTAMP
 ;

unary_operator
 : '-'
 | '+'
 | '~'
 | K_NOT
 ;

column_alias
 : IDENTIFIER
 | STRING_LITERAL
 ;

keyword
 : K_ALL
 | K_AND
 | K_AS
 | K_ASC
 | K_BETWEEN
 | K_BY
 | K_CROSS
 | K_CURRENT_DATE
 | K_CURRENT_TIME
 | K_CURRENT_TIMESTAMP
 | K_DATABASE
 | K_DESC
 | K_DISTINCT
 | K_ESCAPE
 | K_FROM
 | K_FULL
 | K_GLOB
 | K_GROUP
 | K_HAVING
 | K_IN
 | K_INNER
 | K_IS
 | K_ISNULL
 | K_JOIN
 | K_LEFT
 | K_LIKE
 | K_LIMIT
 | K_MATCH
 | K_NATURAL
 | K_NOT
 | K_NOTNULL
 | K_NULL
 | K_OFFSET
 | K_ON
 | K_OR
 | K_ORDER
 | K_OUTER
 | K_REGEXP
 | K_ROW
 | K_SELECT
 | K_TABLE
 | K_USING
 | K_WHERE
 ;

function_name
 : any_name
 ;

database_name
 : any_name
 ;

table_name 
 : any_name
 ;

column_name 
 : any_name
 ;

table_alias
 : any_name
 ;

any_name
 : IDENTIFIER 
 | keyword
 | STRING_LITERAL
 | '(' any_name ')'
 ;

// http://www.sqlite.org/lang_keywords.html
K_ALL : A L L;
K_AND : A N D;
K_AS : A S;
K_ASC : A S C;
K_BETWEEN : B E T W E E N;
K_BY : B Y;
K_CROSS : C R O S S;
K_CURRENT_DATE : C U R R E N T '_' D A T E;
K_CURRENT_TIME : C U R R E N T '_' T I M E;
K_CURRENT_TIMESTAMP : C U R R E N T '_' T I M E S T A M P;
K_DATABASE : D A T A B A S E;
K_DESC : D E S C;
K_DISTINCT : D I S T I N C T;
K_ESCAPE : E S C A P E;
K_FROM : F R O M;
K_FULL : F U L L;
K_GLOB : G L O B;
K_GROUP : G R O U P;
K_HAVING : H A V I N G;
K_IN : I N;
K_INNER : I N N E R;
K_IS : I S;
K_ISNULL : I S N U L L;
K_JOIN : J O I N;
K_LEFT : L E F T;
K_LIKE : L I K E;
K_LIMIT : L I M I T;
K_MATCH : M A T C H;
K_NATURAL : N A T U R A L;
K_NOT : N O T;
K_NOTNULL : N O T N U L L;
K_NULL : N U L L;
K_OFFSET : O F F S E T;
K_ON : O N;
K_OR : O R;
K_ORDER : O R D E R;
K_OUTER : O U T E R;
K_REGEXP : R E G E X P;
K_ROW : R O W;
K_SELECT : S E L E C T;
K_TABLE : T A B L E;
K_USING : U S I N G;
K_WHERE : W H E R E;

IDENTIFIER
 : '"' (~'"' | '""')* '"'
 | '`' (~'`' | '``')* '`'
 | '[' ~']'* ']'
 | [a-zA-Z_] [a-zA-Z_0-9]* // TODO check: needs more chars in set
 ;

NUMERIC_LITERAL
 : DIGIT+ ( '.' DIGIT* )? ( E [-+]? DIGIT+ )?
 | '.' DIGIT+ ( E [-+]? DIGIT+ )?
 ;

BIND_PARAMETER
 : '?' DIGIT*
 | [:@$] IDENTIFIER
 ;

STRING_LITERAL
 : '\'' ( ~'\'' | '\'\'' )* '\''
 ;

SPACES
 : [ \u000B\t\r\n] -> channel(HIDDEN)
 ;

UNEXPECTED_CHAR
 : .
 ;

fragment DIGIT : [0-9];

fragment A : [aA];
fragment B : [bB];
fragment C : [cC];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment G : [gG];
fragment H : [hH];
fragment I : [iI];
fragment J : [jJ];
fragment K : [kK];
fragment L : [lL];
fragment M : [mM];
fragment N : [nN];
fragment O : [oO];
fragment P : [pP];
fragment Q : [qQ];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];
fragment V : [vV];
fragment W : [wW];
fragment X : [xX];
fragment Y : [yY];
fragment Z : [zZ];