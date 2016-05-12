ruleset arrayTests {
	meta {
		name "arrayTests"
		description <<
			Testing arrays
			>>
		author "Nicholas Angell"
		provides testIndex
		sharing on
	}

	global {
		testIndex = function(i) {
			c = [1, 2, 3, 4, 5];
			x = c.index(i);
			x;
		}
	}

}