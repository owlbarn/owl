.PHONY: all clean test doc

all:
	jbuilder build @install

clean:
	jbuilder clean

test:
	jbuilder runtest -j1 --no-buffer

install:
	jbuilder install

uninstall:
	jbuilder uninstall

doc:
	jbuilder build @doc

cleanall:
	jbuilder uninstall && jbuilder clean
	rm -rf `find . -name .merlin`
