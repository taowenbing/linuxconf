DEBUG = 1
FIXED = 0
FREE = 0
PROG = x
######################################################################
SRC_FILES = x.c
FTNMOD_SRC_FILES  =

OBJ_FILES = \
  $(foreach file,$(sort $(SRC_FILES)),$(OBJ_DIR)/$(basename $(notdir $(file))).o)
FTNMOD_OBJ_FILES = \
  $(foreach file,$(sort $(FTNMOD_SRC_FILES)),$(OBJ_DIR)/$(basename $(notdir $(file))).o)
OBJ_DIR = objs_f
######################################################################
###OBJ_DIR = objs
###OBJ_FILES = $(CSRCS:%.c=$(OBJ_DIR)/%.o)
######################################################################
#
# Deduce include directories from the source file list. The sort function
# removes duplicates and is used to construct a set.
#
INCLUDE_DIRS = $(sort $(foreach file,$(SRC_FILES),$(dir $(file))))

CC = gcc
FC = gfortran
AS = gcc -c
ASM = nasm
LD = ld
RM = rm -f

CFLAGS = -Wall -pipe -std=gnu99 $(addprefix -I,$(sort $(INCLUDE_DIRS)))
FFLAGS = -Wall -pipe -Wno-tabs
ASFLAGS = -Wall -pipe
ASMFLAGS = -felf64 -s $(addprefix -I,$(sort $(INCLUDE_DIRS)))
LDFLAGS =
ifneq ($(DEBUG),0)
CFLAGS += -g
FFLAGS += -g
ASFLAGS += -g
ASMFLAGS += -g -O0
else
all objs: CFLAGS += -O2 -march=native -mfpmath=sse
all objs: FFLAGS += -Ofast -march=native -mfpmath=sse -msse3 \
    -funroll-loops --param max-unroll-times=4
all objs: ASFLAGS += -O2
all objs: ASMFLAGS += -Ox
debug: CFLAGS += -g
debug: FFLAGS += -g
debug: ASFLAGS += -g
debug: ASMFLAGS += -g -O0
endif
## fortran
#ifdef FNTFIXED_SRCS_F
#FFLAGS += -ffixed-form
#endif
ifneq ($(FIXED),0)
FFLAGS += -ffixed-form
endif
ifneq ($(FREE),0)
FFLAGS += -ffree-form
endif
######################################################################
.PHONY: all debug objs depend clean distclean run
all debug: $(OBJ_DIR) $(PROG)
objs: $(OBJ_DIR) $(OBJ_FILES)
$(OBJ_FILES): $(FTNMOD_OBJ_FILES)

$(OBJ_DIR):
	mkdir $@

$(PROG): $(OBJ_FILES)
ifeq ($(CC),gcc)
	$(CC) -o $@ $^ $(LDFLAGS)
else
	$(FC) -o $@ $^ $(FTNMOD_OBJ_FILES) $(LDFLAGS)
endif

#
# VPATH is the search path for files. This trick allows a single %.cpp rule to
# be matched against files in sub-directories of Src/.
#
VPATH = $(INCLUDE_DIRS)

$(OBJ_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(OBJ_DIR)/%.o: %.f90
	$(FC) $(FFLAGS) -c -o $@ $<

$(OBJ_DIR)/%.o: %.f
	$(FC) $(FFLAGS) -c -o $@ $<

$(OBJ_DIR)/%.o: %.for
	$(FC) $(FFLAGS) -c -o $@ $<

$(OBJ_DIR)/%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

$(OBJ_DIR)/%.o: %.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

depend::
	@$(RM) depend; \
	for c in $(SRCS); do \
		$(CC) $(CFLAGS) -MM $$c >> depend; \
	done

sinclude depend

run clean:
	$(RM) $(OBJ_FILES) $(FTNMOD_OBJ_FILES)

distclean: clean
	$(RM) $(PROG)
