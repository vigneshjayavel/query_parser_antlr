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
 : K_SELECT selected_column ( ',' selected_column )*
   ( K_FROM table_name )
   ( K_WHERE boolean_expr )?
   ( K_GROUP K_BY grouping_terms ( K_HAVING boolean_expr )? )?
   ( K_ORDER K_BY ordering_terms )?
   ( K_LIMIT limit_value ( ( K_OFFSET | ',' ) offset_value )? )?
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
boolean_expr
 : literal_value
 | BIND_PARAMETER
 | column_name
 | unary_operator boolean_expr
 | boolean_expr '||' boolean_expr
 | boolean_expr ( '*' | '/' | '%' ) boolean_expr
 | boolean_expr ( '+' | '-' ) boolean_expr
 | boolean_expr ( '<<' | '>>' | '&' | '|' ) boolean_expr
 | boolean_expr ( '<' | '<=' | '>' | '>=' ) boolean_expr
 | boolean_expr ( '=' | '==' | '!=' | '<>' | K_IS | K_IS K_NOT | K_IN | K_LIKE ) boolean_expr
 | boolean_expr K_AND boolean_expr
 | boolean_expr K_OR boolean_expr
 | function_name '(' ( K_DISTINCT? boolean_expr ( ',' boolean_expr )* | '*' )? ')'
 | '(' boolean_expr ')'
 | boolean_expr K_NOT? K_LIKE boolean_expr
 | boolean_expr ( K_ISNULL | K_NOTNULL | K_NOT K_NULL )
 | boolean_expr K_IS K_NOT? boolean_expr
 | boolean_expr K_NOT? K_BETWEEN boolean_expr K_AND boolean_expr
 ;

 ordering_terms
 : ordering_term ( ',' ordering_term )*
 ;

ordering_term
 : order_by_column order?
 ;

order
 : K_ASC | K_DESC
 ;

selected_column
 : '*'
 | table_name '.' '*'
 | column_name
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

limit_value
 : NUMERIC_LITERAL
 ;

offset_value
 : NUMERIC_LITERAL
 ;

keyword
 : K_AND
 | K_ASC
 | K_BETWEEN
 | K_BY
 | K_CURRENT_DATE
 | K_CURRENT_TIME
 | K_CURRENT_TIMESTAMP
 | K_DESC
 | K_DISTINCT
 | K_FROM
 | K_GROUP
 | K_HAVING
 | K_IN
 | K_IS
 | K_ISNULL
 | K_LIKE
 | K_LIMIT
 | K_NOT
 | K_NOTNULL
 | K_NULL
 | K_OFFSET
 | K_OR
 | K_ORDER
 | K_SELECT
 | K_TABLE
 | K_WHERE
 ;

function_name
 : any_name
 ;

table_name 
 : any_name
 ;

column_name 
 : (table_name '.')? any_name
 | any_name
 ;

order_by_column
 : column_name
 ;

grouping_terms
 : group_by_column ( ',' group_by_column )*
 ;

group_by_column
 : column_name
 ;

any_name
 : IDENTIFIER 
 | keyword
 | STRING_LITERAL
 | '(' any_name ')'
 ;

// http://www.sqlite.org/lang_keywords.html
K_AND : A N D;
K_ASC : A S C;
K_BETWEEN : B E T W E E N;
K_BY : B Y;
K_CURRENT_DATE : C U R R E N T '_' D A T E;
K_CURRENT_TIME : C U R R E N T '_' T I M E;
K_CURRENT_TIMESTAMP : C U R R E N T '_' T I M E S T A M P;
K_DESC : D E S C;
K_DISTINCT : D I S T I N C T;
K_FROM : F R O M;
K_GROUP : G R O U P;
K_HAVING : H A V I N G;
K_IN : I N;
K_IS : I S;
K_ISNULL : I S N U L L;
K_LIKE : L I K E;
K_LIMIT : L I M I T;
K_NOT : N O T;
K_NOTNULL : N O T N U L L;
K_NULL : N U L L;
K_OFFSET : O F F S E T;
K_OR : O R;
K_ORDER : O R D E R;
K_SELECT : S E L E C T;
K_TABLE : T A B L E;
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