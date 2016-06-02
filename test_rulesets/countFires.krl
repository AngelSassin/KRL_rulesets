ruleset countFires {
	meta {
		name "Count Fires"
		description << Count times a rule fires >>
		author "Nicholas Angell"
		sharing on
		provides getCount
	}

	global {
		getCount = function() {
			ent:count;
		}
	}

	rule count {
		select when do_main night_fire
		pre {
			c = ent:count + 1;
		}
		{
			send_directive("night_fire detected")
				with count = c;
		}
		fired {
			set ent:count c;
		}
	}

	rule createSchedule {
		select when begin scheduling
		pre {
			do_main = "do_main";
			c = ent:count;
		}
		{
			send_directive("night_fire scheduled")
				with count = c;
		}
		fired {
			schedule do_main event night_fire repeat "0 * * * *";
		}
	}
}