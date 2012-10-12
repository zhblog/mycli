all = cli

YACC = bison -d -v
LEX = flex

objs = main.o readline.o lookup.o rpc_cli.o   

CFLAGS = -Wall 

$(all):parser.c lexer.c $(objs)
	gcc -I. -o $@ $^ -lreadline
%.c: %.l
	$(LEX) -t $^ > $@

%.c: %.y
	$(YACC) $^
	$(Q)mv parser.tab.c $@

clean:
	$(RM) lexer.c parser.c
	$(RM) *.o
	$(RM) $(all)
	$(RM) parser.out* 
	$(RM) parser.t*
	$(RM) *~ 
