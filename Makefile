.PHONY: all clean doc

all:
	jbuilder build @install

clean:
	jbuilder clean

cleanall:
	jbuilder uninstall && jbuilder clean

install:
	jbuilder install

uninstall:
	jbuilder uninstall

doc:
	jbuilder build @doc
