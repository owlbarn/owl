CXXFLAGS0 = -shared -fPIC -ansi -pedantic -W -Wall
CXXFLAGS1 = -shared -fPIC -ansi -pedantic -Wno-extern-c-compat -Wno-c++11-long-long

all:
	g++ -I . ${CXXFLAGS1} libowl_eigen.cpp -o libowl_eigen.so
clean:
	rm -rf *.o *.so
