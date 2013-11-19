
NAME       = gcc
OBJ_SUFFIX = o

###############################################################################
TARGET = release/GreenPad.exe
INTDIR = obj/$(NAME)

all: PRE $(TARGET)

OBJS = \
 $(INTDIR)/thread.$(OBJ_SUFFIX)       \
 $(INTDIR)/log.$(OBJ_SUFFIX)          \
 $(INTDIR)/winutil.$(OBJ_SUFFIX)      \
 $(INTDIR)/textfile.$(OBJ_SUFFIX)     \
 $(INTDIR)/path.$(OBJ_SUFFIX)         \
 $(INTDIR)/cmdarg.$(OBJ_SUFFIX)       \
 $(INTDIR)/file.$(OBJ_SUFFIX)         \
 $(INTDIR)/find.$(OBJ_SUFFIX)         \
 $(INTDIR)/ctrl.$(OBJ_SUFFIX)         \
 $(INTDIR)/registry.$(OBJ_SUFFIX)     \
 $(INTDIR)/window.$(OBJ_SUFFIX)       \
 $(INTDIR)/string.$(OBJ_SUFFIX)       \
 $(INTDIR)/memory.$(OBJ_SUFFIX)       \
 $(INTDIR)/app.$(OBJ_SUFFIX)          \
 $(INTDIR)/ip_cursor.$(OBJ_SUFFIX)    \
 $(INTDIR)/ip_scroll.$(OBJ_SUFFIX)    \
 $(INTDIR)/ip_wrap.$(OBJ_SUFFIX)      \
 $(INTDIR)/ip_draw.$(OBJ_SUFFIX)      \
 $(INTDIR)/ip_ctrl1.$(OBJ_SUFFIX)     \
 $(INTDIR)/ip_text.$(OBJ_SUFFIX)      \
 $(INTDIR)/ip_parse.$(OBJ_SUFFIX)     \
 $(INTDIR)/GpMain.$(OBJ_SUFFIX)       \
 $(INTDIR)/OpenSaveDlg.$(OBJ_SUFFIX)  \
 $(INTDIR)/Search.$(OBJ_SUFFIX)       \
 $(INTDIR)/RSearch.$(OBJ_SUFFIX)      \
 $(INTDIR)/ConfigManager.$(OBJ_SUFFIX)

LIBS = \
 -lkernel32 \
 -luser32   \
 -lgdi32    \
 -lshell32  \
 -ladvapi32 \
 -lcomdlg32 \
 -lcomctl32 \
 -lole32    \
 -limm32

PRE:
	-@if [ ! -d release   ]; then   mkdir release; fi;
	-@if [ ! -d obj       ]; then   mkdir obj; fi;
	-@if [ ! -d $(INTDIR) ]; then   mkdir $(INTDIR); fi;
###############################################################################

RES = $(INTDIR)/gp_rsrc.o

VPATH    = editwing:kilib
CXXFLAGS = -fpermissive -O2 -idirafter kilib -c --input-charset=cp932
LOPT     = -mwindows 

$(TARGET) : $(OBJS) $(RES)
	g++ $(LOPT) -o$(TARGET) $(OBJS) $(RES) $(LIBS)
	strip -s $(TARGET)
$(INTDIR)/%.o: rsrc/%.rc
#	windres --language=0x411 -I rsrc $< $@
	windres -c 65001  -I rsrc $< $@
$(INTDIR)/%.o: %.cpp
	g++ $(CXXFLAGS) -o$@ $<

clean : 
	-rm $(RES)
	-rm $(OBJS)
	-rm $(TARGET)
	-rmdir $(INTDIR)
	-rmdir obj
