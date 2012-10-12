#include <stdio.h>
#include <ctype.h>
#include <string.h>

#include "parser.tab.h"

typedef struct
    {
        char *name;
        int  token;
        unsigned match_len;
    } token_ent;

    token_ent token_table[] =
    {
    
        { "debug",			DEBUG,	1 },
        { "exit",          	EXIT,   1 },
        { "zzh",           	ZZH,	3 },
	    {  NULL,           	0,		0 }
    };

    int str_match(char *str1, char *str2, int min_match)
    {
        int len = 0;

        while ((*str1 != '\0') && (*str2 != '\0'))
        {
            if (toupper(*str1) != toupper(*str2))
            {
                /* mismatch, return */
                return 1;
            }
            str1++;
            str2++;
            len++;
        }

        if ((*str1 == '\0') && (*str2 != '\0'))
        {
            return 2;
        }
        return !(len >= min_match);
    }

    int find_token(char *input)
    {
        token_ent *token;
        token = token_table;
        while (token->match_len != 0)
        {
            if (tolower(input[0]) == token->name[0])
            {
                if (!str_match(token->name, input, token->match_len))
                {
                    return token->token;
                }
            }
            if (tolower(input[0]) < token->name[0])
                break;
            token++;
        }
        return 0;
    }
