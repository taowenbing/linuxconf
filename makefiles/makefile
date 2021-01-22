# NetBSD bmake
DEBUG= 1
PROG= ${.CURDIR}/${SRCS:[1]:T:R}

SRCS=  main.c csapp.c
FORMOD_SRCS= 

OBJS= ${SRCS:T:N*.h:R:S/$/.o/}
.if empty(FORMOD_SRCS)
FORMOD_OBJS=
.else
FORMOD_OBJS= ${FORMOD_SRCS:T:R:S/$/.o/}
.endif
_objdir = ${.CURDIR}/objs
.if !exists(${_objdir}/) 
_objdir_made != echo ${_objdir}/; mkdir -p ${_objdir}
.endif
_allsrcs= ${SRCS} ${FORMOD_SRCS}
SRC_DIRS= ${_allsrcs:H:O:u:%=${.CURDIR}/%}
.OBJDIR: ${_objdir}
.PATH: ${SRC_DIRS}
.NOPATH: ${OBJS} ${FORMOD_OBJS}

CC = gcc
CXX = g++
CXX.c=
FC = gfortran
FC.c=
AS := ${CC} -c
ASM = nasm
JASM = uasm
LEX = flex
YACC = bison
LD = ld
LD.c=
JLD = jwlink
JLD.c=
RM = rm -f

CFLAGS = -Wall -pipe #${SRC_DIRS:%=-I%}
CXXFLAGS = -Wall -pipe ${SRC_DIRS:%=-I%}
FFLAGS = -Wall -pipe -Wno-tabs
AFLAGS = -Wall -pipe
ASMFLAGS = -felf64
JASMFLAGS = -q -elf64
LDFLAGS =
JLDFLAGS = op q
.if defined(com)
JLDFLAGS += sys com
.else
JLDFLAGS += sys dos
.endif
BLDFLAGS= -e _start -Ttext=${BINARY_ORG} -N -S --oformat binary
BINARY_ORG = 0x0

.if make(all)
CFLAGS += -O2 -march=native -mfpmath=sse
CXXFLAGS += -O2
FFLAGS += -Ofast -march=native -mfpmath=sse -msse3 \
    -funroll-loops --param max-unroll-times=4
AFLAGS += -O2
ASMFLAGS += -Ox
.elif ${DEBUG} != 0
CFLAGS += -g
CXXFLAGS += -g
FFLAGS += -g
AFLAGS += -g
ASMFLAGS += -g -O0
JASMFLAGS += -Zi
#JLDFLAGS += d d
.endif

.PHONY: all objs run clean cleandep
FOR_SUFFIXES?= .f .for .f90
.SUFFIXES: ${FOR_SUFFIXES} .asm .l .y
all: ${PROG}
objs: ${OBJS}

.if empty(FORMOD_OBJS)
.if !empty(FC.c)
CC=${FC}
.elif !empty(CXX.c)
CC = ${CXX}
.endif
.if !empty(LD.c)
${PROG}: ${OBJS}
.if empty(JLD.c)
	${LD} -o ${.TARGET} ${.ALLSRC} ${BLDFLAGS}
.else
	${JLD} n ${.TARGET} ${JLDFLAGS} f {${.ALLSRC}}
.endif
.else
${PROG}: ${OBJS}
	${CC} -o ${.TARGET} ${.ALLSRC} ${LDFLAGS}
.endif
.else
.ORDER: ${FORMOD_OBJS} ${OBJS}
${OBJS}: ${FORMOD_OBJS}
${PROG}: ${FORMOD_OBJS} ${OBJS}
	${FC} -o ${.TARGET} ${.ALLSRC} ${LDFLAGS}
.endif

.c.o:
	${CC} ${CFLAGS} -o ${.TARGET} -c ${.IMPSRC}

.cc.o .C.o:
	${CXX} ${CXXFLAGS} -o ${.TARGET} -c ${.IMPSRC}

${FOR_SUFFIXES:%=%.o}:
	${FC} ${FFLAGS} -o ${.TARGET} -c ${.IMPSRC}

.s.o .S.o:
	${AS} ${AFLAGS} -o ${.TARGET} -c ${.IMPSRC}

.asm.o:
	${JASM} ${JASMFLAGS} -Fo ${.TARGET} ${.IMPSRC}

.l.o:
	${LEX} -o ${.PREFIX}.c ${.IMPSRC}
	${CC} ${CFLAGS} -o ${.TARGET} -c ${.PREFIX}.c
	@${RM} ${.PREFIX}.c

.y.o:
	${YACC} -d -o ${.PREFIX}.c ${.IMPSRC}
	${CC} ${CFLAGS} -o ${.TARGET} -c ${.PREFIX}.c
	@${RM} ${.PREFIX}.c

clean:
	${RM} ${OBJS} ${FORMOD_OBJS}

run: ${PROG}
	@${PROG}

# generated dependency files
_depsrcs=${SRCS:M*.c}
.if !empty(_depsrcs)
_depsrcs:=${_depsrcs:T:R:S/$/.d/}
cleandep: clean
	${RM} ${_depsrcs}
.if defined(gendep)
CFLAGS_MD?=-MMD
CFLAGS_MF?=-MF ${.TARGET:T:R}.d -MT ${.TARGET:T:R}.o
CFLAGS+= ${CFLAGS_MD} ${CFLAGS_MF}
.endif
.for d in ${_depsrcs}
.dinclude "$d"
.endfor
.endif
