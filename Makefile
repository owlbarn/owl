.PHONY: all clean doc

all:
	jbuilder build @install

clean:
	jbuilder clean

test:
	jbuilder runtest

install:
	jbuilder install

uninstall:
	jbuilder uninstall

doc:
	jbuilder build @doc

cleanall:
	jbuilder uninstall && jbuilder clean
	rm -rf `find . -name .merlin`
