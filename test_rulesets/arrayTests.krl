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

	rule splitTest {
		pre {
			testString = "a,b,c;d,e;f;g,h;i,j";
			testSplit = testString.split("re/,;/");
		}
		{
			noop();
		}
		always {
			log("Done with #{testSplit}");
		}
	}

}