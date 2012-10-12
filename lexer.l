%{
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <readline/readline.h>
#include <readline/history.h>

#include "parser.tab.h"

#ifdef YY_FLEX_SUBMINOR_VERSION
#define yy_current_buffer YY_CURRENT_BUFFER
#endif

#define YY_NO_UNPUT
#define YY_INPUT(buf, result, max_size)  yy_input(buf, &result, max_size) 

#define MAXNAMES 64
#define MAXWORDLEN  32

    static char g_name[MAXNAMES][MAXWORDLEN];
    static int  g_nameindex = 0;
    static char *g_command = 0;
    static char *add_name_table(char *name)
    {
        if (g_nameindex < MAXNAMES)
        {
            strncpy(g_name[g_nameindex], name, MAXWORDLEN);
            g_name[g_nameindex][MAXWORDLEN - 1] = '\0';
            return g_name[g_nameindex++];
        }

        fprintf(stderr,"Can't use more than %d names, '%s' discarded!\n", MAXNAMES, name);

        return g_name[g_nameindex];
    }

    void clear_name_table(void)
    {
        g_nameindex = 0;
    }

    
%}

%option

integer  [0-9]+
ident    [a-zA-Z]+[a-zA-Z0-9_-]*
%%


{integer}		{
			yylval.ival = atoi(yytext);
			return _INT_;
		}
{ident}		{
			int token;
			token = find_token(yytext);
			
			if (token > 0)
			{
				return token;
			}
			yylval.sptr = add_name_table(yytext);
			
			return _NAME_;
		}
[\r\n]		{
			return EOS;
		}

%%

int yywrap(void)
{
	return 1;
}

int hy_is_interactive(void)
{
	return yy_current_buffer->yy_is_interactive;
}

int hy_switch_to_file(FILE* fp)
{
	yy_switch_to_buffer(yy_create_buffer(fp, YY_BUF_SIZE));

	return 0;
}

int hy_switch_to_buffer(char *cmd)
{
	if(cmd)
		yy_switch_to_buffer(yy_scan_string(cmd));

	return 0;
}


