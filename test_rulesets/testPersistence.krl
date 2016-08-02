ruleset testPersistence {
	meta {
		name "Test Persistence"
		description << Purely to test if entity variables are per pico or per ruleset >>
		author "Nicholas Angell"
		sharing on
		provides getCount, cancelEvent, cancelAllEvents, getScheduledEvents, getHistory, getAllHistory
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
}