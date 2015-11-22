CXX        := g++-4.8
#CXX        := gcc
CXXFLAGS   := -pedantic -std=c++11 -Wall
LDFLAGS    := -lgtest -lgtest_main -pthread
GCOV       := gcov-4.8
GCOVFLAGS  := -fprofile-arcs -ftest-coverage
GPROF      := gprof
GPROFFLAGS := -pg
VALGRIND   := valgrind

clean:
	rm -f *.gcda
	rm -f *.gcno
	rm -f *.gcov
	rm -f RunTheatre
	rm -f RunTheatre.tmp
	rm -f TestTheatre
	rm -f TestTheatre.tmp
	rm -f solution
	rm -f *~

config:
	git config -l

scrub:
	make  clean
	rm -f  Theatre.log
	rm -rf theatre-tests
	rm -rf html
	rm -rf latex

status:
	make clean
	@echo
	git branch
	git remote -v
	git status

test: RunTheatre.tmp TestTheatre.tmp

solution: solution.cpp
	$(CXX) $(CXXFLAGS) $(GCOVFLAGS) solution.cpp -o solution

shi: shi.cpp
	$(CXX) $(CXXFLAGS) $(GCOVFLAGS) shi.cpp -o shi

#RunTheatre: Theatre.h Theatre.c++ RunTheatre.c++
#	$(CXX) $(CXXFLAGS) $(GCOVFLAGS) Theatre.c++ RunTheatre.c++ -o RunTheatre
RunTheatre: Theatre.c++
	$(CXX) $(CXXFLAGS) $(GCOVFLAGS) Theatre.c++ -o RunTheatre

RunTheatre.tmp: RunTheatre
	./RunTheatre < RunTheatre.in > RunTheatre.tmp
	diff -w RunTheatre.tmp RunTheatre.out

#TestTheatre: Theatre.h Theatre.c++ TestTheatre.c++
TestTheatre: TestTheatre.c++
	$(CXX) $(CXXFLAGS) $(GCOVFLAGS) TestTheatre.c++ -o TestTheatre $(LDFLAGS)

TestTheatre.tmp: TestTheatre
	$(VALGRIND) ./TestTheatre                                       >  TestTheatre.tmp 2>&1
	$(GCOV) -b Theatre.c++     | grep -A 5 "File 'Theatre.c++'"     >> TestTheatre.tmp
	$(GCOV) -b TestTheatre.c++ | grep -A 5 "File 'TestTheatre.c++'" >> TestTheatre.tmp
	cat TestTheatre.tmp
