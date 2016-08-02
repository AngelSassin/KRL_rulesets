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
}