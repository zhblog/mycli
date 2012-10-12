%{
#include <stdio.h>
#include <string.h>
#include "rpc_cli.h"
#define printPrompt()   

static int EN = 0;

void yyerror(char *s)
{
    printf("%s\n", s);
}

    
%}

%union
{
    int  ival;	
    char *sptr;
}

%token ZZH EXIT EOS DEBUG  

%token <ival> _INT_ 
%token <sptr> _NAME_   

%%

input:
	|	input line
	{
		printPrompt();
	}
	;

line:
	EOS
	{
		clear_name_table();
	}
	|	command
	|	error EOS
	{
		clear_name_table();
		yyerrok;
	}
	;

command:
	 	testcmds
	|	EXIT EOS
	{
	    YYACCEPT;
	}
;

testcmds:
	ZZH  EOS 
	{
		EN = cli_action();		
	}
    | ZZH _INT_ EOS
    {
        EN = cli_action_1($2);
    }

%%


void start_cli(char *cmd, FILE *fp)
{      
	hy_switch_to_file(stdin);
	yyparse();
}
