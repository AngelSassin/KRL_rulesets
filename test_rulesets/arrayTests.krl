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
		select when test splitTest
		pre {
			testString = "a,b,c;d,e;f;g,h;i,j";
			testSplit = testString.split("re/,/");
		}
		{
			send_directive("Split")
				with text = "#{testSplit}";
		}
	}

}