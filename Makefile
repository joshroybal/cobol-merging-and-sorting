CC = cobc
LFLAGS = -O2

all: csv2flat sortflat mergeflat

csv2flat: csv2flat.cbl
	$(CC) -x $< $(LFLAGS)

sortflat: sortflat.cbl
	$(CC) -x $< $(LFLAGS)

mergeflat: mergeflat.cbl
	$(CC) -x $< $(LFLAGS)

clean:
	$(RM) csv2flat sortflat mergeflat
