# file: Makefile.tpl		G. Moody		24 May 2000
#				Last revised:		5 June 2000
# This section of the Makefile should not need to be changed.

INCLUDES = $(INCDIR)/wfdb/wfdb.h $(INCDIR)/wfdb/ecgcodes.h \
 $(INCDIR)/wfdb/ecgmap.h
COMPAT_INCLUDES = $(INCDIR)/ecg/db.h $(INCDIR)/ecg/ecgcodes.h \
 $(INCDIR)/ecg/ecgmap.h
HFILES = wfdb.h ecgcodes.h ecgmap.h wfdblib.h
CFILES = wfdbinit.c annot.c signal.c calib.c wfdbio.c
OFILES = wfdbinit.o annot.o signal.o calib.o wfdbio.o
MFILES = Makefile makefile.dos

# `make' or `make all':  build the WFDB library
all:	$(OFILES)
	$(BUILDLIB) $(OFILES)

# `make install':  install the WFDB library and headers
install:	$(INCLUDES) $(LIBDIR) all
	cp $(WFDBLIB) $(LIBDIR) 
	$(SETLPERMISSIONS) $(LIBDIR)/$(WFDBLIB)
	$(MAKE) lib-post-install

uninstall:
	../uninstall.sh $(INCDIR)/wfdb $(HFILES)
	../uninstall.sh $(INCDIR)
	../uninstall.sh $(LIBDIR) $(WFDBLIB)
	$(MAKE) lib-post-uninstall
	../uninstall.sh $(LIBDIR)

# `make compat':  install the includes needed for source compatibility with
# applications written for pre-version 10.0.0 versions of this library
compat:		$(INCLUDES) $(COMPAT_INCLUDES)

# `make clean':  also remove previously compiled versions of the library
clean:
	rm -f $(WFDBLIB) $(SWFDBLIB) $(OFILES) *~

# `make TAGS':  make an `emacs' TAGS file
TAGS:		$(HFILES) $(CFILES)
	@etags $(HFILES) $(CFILES)

# `make listing':  print a listing of WFDB library sources
listing:
	$(PRINT) README $(MFILES) $(HFILES) $(CFILES)

# Rules for creating installation directories
$(INCDIR):
	mkdir -p $(INCDIR); $(SETDPERMISSIONS) $(INCDIR)
$(INCDIR)/wfdb:	$(INCDIR)
	mkdir -p $(INCDIR)/wfdb; $(SETDPERMISSIONS) $(INCDIR)/wfdb
$(INCDIR)/ecg:	$(INCDIR)
	mkdir -p $(INCDIR)/ecg; $(SETDPERMISSIONS) $(INCDIR)/ecg
$(LIBDIR):
	mkdir -p $(LIBDIR); $(SETDPERMISSIONS) $(LIBDIR)

# Rules for installing the include files
$(INCDIR)/wfdb/wfdb.h:		$(INCDIR)/wfdb wfdb.h
	cp -p wfdb.h $(INCDIR)/wfdb; $(SETPERMISSIONS) $(INCDIR)/wfdb/wfdb.h
$(INCDIR)/wfdb/ecgcodes.h:	$(INCDIR)/wfdb ecgcodes.h
	cp -p ecgcodes.h $(INCDIR)/wfdb
	$(SETPERMISSIONS) $(INCDIR)/wfdb/ecgcodes.h
$(INCDIR)/wfdb/ecgmap.h:		$(INCDIR)/wfdb ecgmap.h
	cp -p ecgmap.h $(INCDIR)/wfdb
	$(SETPERMISSIONS) $(INCDIR)/wfdb/ecgmap.h

# Rules for installing the compatibility (pre-10.0.0) include files
$(INCDIR)/ecg/db.h:		$(INCDIR)/ecg db.h
	cp -p db.h $(INCDIR)/ecg; $(SETPERMISSIONS) $(INCDIR)/ecg/db.h
$(INCDIR)/ecg/ecgcodes.h:	$(INCDIR)/ecg $(INCDIR)/wfdb/ecgcodes.h
	ln -s $(INCDIR)/wfdb/ecgcodes.h $(INCDIR)/ecg/ecgcodes.h
$(INCDIR)/ecg/ecgmap.h:		$(INCDIR)/ecg $(INCDIR)/wfdb/ecgmap.h
	ln -s $(INCDIR)/wfdb/ecgmap.h $(INCDIR)/ecg/ecgmap.h

# Prerequisites for the library modules
wfdbinit.o:	wfdb.h wfdblib.h wfdbinit.c
annot.o:	wfdb.h ecgcodes.h ecgmap.h wfdblib.h annot.c
signal.o:	wfdb.h wfdblib.h signal.c
calib.o:	wfdb.h wfdblib.h calib.c
wfdbio.o:	wfdb.h wfdblib.h wfdbio.c
