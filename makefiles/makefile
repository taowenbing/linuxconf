DEBUG = 1
PROG = $(patsubst %.c,%,$(notdir $(word 1, $(SRC_FILES))))
######################################################################
SRC_FILES = main.c

OBJ_FILES = \
  $(foreach file,$(sort $(SRC_FILES)),$(OBJ_DIR)/$(basename $(notdir $(file))).o)
OBJ_DIR = objs

#
# Deduce include directories from the source file list. The sort function
# removes duplicates and is used to construct a set.
#
INCLUDE_DIRS = $(sort $(foreach file,$(SRC_FILES),$(dir $(file))))

#
# VPATH is the search path for files. This trick allows a single %.c rule to
# be matched against files in sub-directories of src/.
#
VPATH = $(INCLUDE_DIRS)

CC = gcc
CXX = g++
AS = gcc -c
ASM = nasm
LD = ld
RM = rm -f

CFLAGS = -Wall -pipe -std=gnu99 $(addprefix -I,$(INCLUDE_DIRS))
CXXFLAGS = -Wall -pipe $(addprefix -I,$(INCLUDE_DIRS))
ASFLAGS = -Wall -pipe
ASMFLAGS = -felf64 -s $(addprefix -I,$(INCLUDE_DIRS))
LDFLAGS =

ifneq ($(DEBUG),0)
CFLAGS += -g
CXXFLAGS += -g
ASFLAGS += -g
ASMFLAGS += -g -O0
else
all o: CFLAGS += -O2 #-march=native -mfpmath=sse
all o: CXXFLAGS += -O2
all o: ASFLAGS += -O2
all o: ASMFLAGS += -Ox
debug: CFLAGS += -g
debug: CXXFLAGS += -g
debug: ASFLAGS += -g
debug: ASMFLAGS += -g -O0
endif
######################################################################
.PHONY: all debug o depend clean distclean
all debug: $(OBJ_DIR) $(PROG)
o: $(OBJ_DIR) $(OBJ_FILES)

$(OBJ_DIR):
	mkdir $@

$(PROG): $(OBJ_FILES)
	$(CC) -o $@ $^ $(LDFLAGS)

$(OBJ_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(OBJ_DIR)/%.o: %.cc
	$(CXX) $(CXXFLAGS) -c -o $@ $<

$(OBJ_DIR)/%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

$(OBJ_DIR)/%.o: %.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

depend::
	@$(RM) .depend; \
	for c in $(filter %.c %.cc,$(SRC_FILES)); do \
		$(CC) $(CFLAGS) -MM $$c >> .depend; \
	done
	@sed -i 's/\(.*\)\.o:/$(OBJ_DIR)\/\1.o:/' .depend

sinclude .depend

clean:
	$(RM) $(OBJ_FILES)

distclean: clean
	$(RM) $(PROG)
