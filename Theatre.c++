// ----------------------------
// projects/theatre/Theatre.c++
// Copyright (C) 2015
// CS Hui
// ----------------------------

// --------
// includes
// --------

#include <cassert>  // assert
#include <iostream> // endl, istream, ostream
#include <sstream>  // istringstream
#include <string>   // getline, string
#include <utility>  // make_pair, pair
#include <deque>
#include <functional>
#include <map>
#include <climits>
#include <set>
#include <vector>
#include <math.h>
//#include <gmpxx.h>

//include "Theatre.h

using namespace std;
using BNUM = unsigned long long;
	
// -------------
// gcd
// -------------
//template <typename T>
BNUM comb(int n, int r) {
	BNUM rc = 1;
	
	if (r > (n >> 2)) {
		r = n - r; }
	for (int i=1; i<=r; i++) {
		rc = rc * (n-r+i) / i; }
		
	return rc; }
	
// -------------
// theatre_solve
// -------------

void theatre_solve (istream& r, ostream& w) {
    int  n, m, t;				// inputs: bouy, girls, players
    int  i, s, l;					// start and last
    BNUM result = 0;
	
	r >> n >> m >> t;

	if (t > n) { 
		s = t - n; }
	else {
		s = 1; }
	if ((t - m) < 4) {
		l = t - 4; }
	else {
		l = m; }
		
	for (i=s; i<=l; i++) {
		result += comb(m, i) * comb(n, t-i); }

	w << result << endl; 

}
	
// ----
// main
// ----

int main () {
    using namespace std;
//    cout << "main" << endl;
    theatre_solve(cin, cout);
    return 0;}


