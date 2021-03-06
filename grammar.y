%{
import java.lang.Math;
import java.io.*;
import java.util.StringTokenizer;
%}

%union{
	Node node;

}

%token NUMBER
%token<char*> VARIABLE
%token<float> DECIMAL
%token<node> INTEGER FLOAT
%token<node> IF WHILE
%token<node> OP_ASSIGN OP_SUM OP_SUB OP_MUL OP_DIV OP_MODULO OP_PLUS_ONE OP_SUB_ONE
%token<node> OP_OR OP_AND OP_NEG OP_DIST OP_LT OP_GT OP_LE OP_GE
%token<node> LOG SIN COS TAN GRAFICAR

%right OP_ASSIGN
%left OP_SUM OP_SUB
%left OP_MUL OP_DIV
%left OP_NEG OP_AND OP_OR
%left LOG
%left GRAFICAR

%start begin

%%

begin: line
	{
		root = $1;
		//TODO: print all lines on tree function
	};

conditional: IF '(' expr ')' line
	{
		$$ = newNode(NULL,if);
		addNode($$,$3);
		addNode($$,$5);
	};

ciclo: WHILE '(' expr ')' line
	{
		$$ = newNode(NULL,while);
		addNode($$,$3);
		addNode($$,$5);
	};

line: expr ';'
	{
		$$ = newNode(NULL,';');
		addNode($$,$1);
	};
	| INTEGER VARIABLE OP_ASSIGN expr ';'
	{
		$$ = newNode(NULL,'=');
		addNode($$,$4);
	}
	| FLOAT VARIABLE OP_ASSIGN expr ';'
	{
		$$ = newNode(NULL,'=');
		addNode($$,$4);
	}
	| VARIABLE OP_ASSIGN expr ';'
	{
		$$ = newNode(NULL,'=')
		addNode($$,$3);
	}
	| '{' multilines '}'
	{
		$$ = newNode(NULL,"multi");
		addNode($$,$2);
	};

multilines: line
	{
		$$ = newNode(NULL,"multi");
		addNode($$,$1);
	}
	| line multilines
	{
		$$ = newNode(NULL,"multi");
		addNode($$,$1);
		addNode($$,$2);
	};

expr: NUMBER
	{
		$$ = newNode($1,"int");
	}
	| DECIMAL
	{
		$$ = newNode($1,"float");
	}
	| expr OP_SUM expr
	{
		$$ = newNode(NULL,'+');
		addNode($$,$1);
		addNode($$,$3);
	}
	| expr OP_SUB expr
	{
		$$ = newNode(NULL,'-');
		addNode($$,$1);
		addNode($$,$3);
	}
	| expr OP_DIV expr
	{
		$$ = newNode(NULL,'/');
		addNode($$,$1);
		addNode($$,$3);
	}
	| expr OP_MUL expr
	{
		$$ = newNode(NULL,'*');
		addNode($$,$1);
		addNode($$,$3);
	}
	| MOD '(' expr ')'
	{
		$$ = newNode(NULL,"mod");
		addNode($$,$3);
	}
	| LOG '(' expr ')'
	{
		$$ = newNode(NULL,"log");
		addNode($$,$3);
	}
	| SIN '(' expr ')'
	{
		$$ = newNode(NULL,"sin");
		addNode($$,$3);
	}
	| COS '(' expr ')'
	{
		$$ = newNode(NULL,"cos");
		addNode($$,$3);
	}
	| TAN '(' expr ')'
	{
		$$ = newNode(NULL,"tan");
		addNode($$,$3);
	};