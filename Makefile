.PHONY: all clean doc

all:
	jbuilder build @install

clean:
	jbuilder clean

test:
	jbuilder runtest

cleanall:
	jbuilder uninstall && jbuilder clean

install:
	jbuilder install

uninstall:
	jbuilder uninstall

doc:
	jbuilder build @doc
