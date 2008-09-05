# Copyright 2008 Roy Marples <roy@marples.name>

# Setup some good default CFLAGS
CFLAGS?=	-Os

# Default to using the C99 standard
CSTD?=		c99
_CSTD_SH=	if test -n "${CSTD}"; then echo "-std=${CSTD}"; else echo ""; fi
_CSTD!=		${_CSTD_SH}
CFLAGS+=	${_CSTD}$(shell ${_CSTD_SH})

# Try and use some good cc flags if we're building from git
# We don't use -pedantic as it will warn about our perfectly valid
# use of %m in our logger.
_CCFLAGS=	-Wall -Wextra -Wimplicit -Wshadow -Wformat=2 \
		-Wmissing-prototypes -Wmissing-declarations \
		-Wmissing-noreturn -Wmissing-format-attribute \
		-Wredundant-decls  -Wnested-externs \
		-Winline -Wwrite-strings -Wcast-align -Wcast-qual -Wpointer-arith \
		-Wdeclaration-after-statement -Wsequence-point
_CC_FLAGS_SH=	if ! test -d .git; then echo ""; else for f in ${_CCFLAGS}; do \
		if ${CC} $$f -S -o /dev/null -xc /dev/null >/dev/null 2>&1; \
		then printf "%s" "$$f "; fi \
		done; fi
_CC_FLAGS!=	${_CC_FLAGS_SH}
CFLAGS+=	${_CC_FLAGS}$(shell ${_CC_FLAGS_SH})

_GGDB_SH=	if test "${DEBUG}" = "yes"; then echo "-ggdb -DDEBUG"; else echo ""; fi
_GGDB!=		${_GGDB_SH}
GGDB=		${_GGDB}$(shell ${_GGDB_SH})
CFLAGS+=	${GGDB}
