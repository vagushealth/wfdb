# file: Makefile.tpl		G. Moody	  23 May 2000
#				Last revised:	13 December 2001
# This section of the Makefile should not need to be changed.

DBFILES = 100s.dat 100s.atr *.hea *list wfdbcal

all:
	@echo Nothing to be made in `pwd`.

install:	$(DBDIR) $(DBDIR)/pipe $(DBDIR)/tape
	cp $(DBFILES) $(DBDIR)
	cp pipe/* $(DBDIR)/pipe
	cp tape/* $(DBDIR)/tape
	-cd $(DBDIR); $(SETPERMISSIONS) $(DBFILES)
	-cd $(DBDIR); ln -sf wfdbcal dbcal
	-cd $(DBDIR)/pipe; $(SETPERMISSIONS) *
	-cd $(DBDIR)/tape; $(SETPERMISSIONS) *

uninstall:
	../uninstall.sh $(DBDIR) $(DBFILES) dbcal

$(DBDIR):
	mkdir $(DBDIR); $(SETDPERMISSIONS) $(DBDIR)
$(DBDIR)/pipe:
	mkdir $(DBDIR)/pipe; $(SETDPERMISSIONS) $(DBDIR)/pipe
$(DBDIR)/tape:
	mkdir $(DBDIR)/tape; $(SETDPERMISSIONS) $(DBDIR)/tape

listing:
	$(PRINT) README Makefile makefile.dos

clean:
	rm -f *~