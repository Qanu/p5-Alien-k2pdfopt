ifdef COMSPEC
	# Windows
	EXEEXT := .exe
	PATHSEP := ;
	SO := dll
	CP := copy
else
	EXEEXT :=
	PATHSEP := :
	SO := so
	CP := cp

	CFLAGS+= -fPIC
endif

prefix ?= /usr/local
bindir ?= $(prefix)/bin
libdir ?= $(prefix)/lib
incdir ?= $(prefix)/include

CFLAGS+= -I willuslib -I k2pdfoptlib
LDLIBS+= -lm

INSTALL_LIBS := libk2pdfopt.a libwillus.a
INSTALL_APPS := k2pdfopt$(EXEEXT) kindlepdfviewer/k2view$(EXEEXT)

all: $(INSTALL_APPS)

kindlepdfviewer/k2view$(EXEEXT): kindlepdfviewer/k2view.c libk2pdfopt.a libwillus.a

k2pdfopt$(EXEEXT): k2pdfopt.c libk2pdfopt.a libwillus.a

install: all
	install -d $(DESTDIR)$(incdir)

	install willuslib/*.h $(DESTDIR)$(incdir)
	install k2pdfoptlib/*.h $(DESTDIR)$(incdir)

	install -d $(DESTDIR)$(libdir)
	install $(INSTALL_LIBS) $(DESTDIR)$(libdir)

	install -d $(DESTDIR)$(bindir)
	install $(INSTALL_APPS) $(DESTDIR)$(bindir)

LIBWILLUS_SRC := $(wildcard willuslib/*.c)
LIBWILLUS_OBJ := $(patsubst %.c,%.o,$(LIBWILLUS_SRC))

libwillus.a: $(LIBWILLUS_OBJ)
	$(AR) $(ARFLAGS) $@ $^

LIBK2PDFOPT_SRC := $(wildcard k2pdfoptlib/*.c)
LIBK2PDFOPT_OBJ := $(patsubst %.c,%.o,$(LIBK2PDFOPT_SRC))
libk2pdfopt.a: $(LIBK2PDFOPT_OBJ)
	$(AR) $(ARFLAGS) $@ $^

clean:
	$(RM) willuslib/*.o
	$(RM) k2pdfoptlib//*.o
	$(RM) libwillus.a
	$(RM) libk2pdfopt.a
	$(RM) k2view

