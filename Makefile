CC = cc
CFLAGS = -lnsl -ltirpc
CFLAGSINIT = -lnsl -ltirpc -g -o
RPG = rpcgen
RPGFLAGS = -a -C
EXECUTABLECLIENT = rls
EXECUTABLESERVER= dir_svc

all: init 

comp: rls.c dir_proc.c
	$(CC) -g rls.c dir_clnt.c dir_xdr.o -o $(EXECUTABLECLIENT) $(CFLAGS)
	$(CC) dir_svc.c dir_proc.c dir_xdr.o -o $(EXECUTABLESERVER) $(CFLAGS)

init: dir.x
	printf "\n\nAfter the execution of the next command, try:\n\n\n make -f Makefile.dir\n\n And edit the Makefile.dir according to your glibc system software configuration.\nFor example, in my machine, I needed to add the -ltirpc flag to make things work.\n\n\nOnce thats done,  enter \n\nmake comp\n\nTo compile the client and server packages.\n\n"
	$(RPG) $(RPGFLAGS) dir.x

clean:
	rm -rf *.o *.out *.gch $(EXECUTABLECLIENT) $(EXECUTABLESERVER)
#leaks:
#	valgrind --leak-check=yes --track-origins=yes -s ./$(EXECUTABLE)