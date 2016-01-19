ruleset track_trips {
	meta {
		name "track_trips"
		description <<
			Single Picos assignment: track_trips
			>>
		author "Nicholas Angell"
	}

	rule process_trip {
		select when car new_trip
		pre {
			mileage = event:attr("mileage")
		}
		{
			send_directive("trip") with
				length = mileage
		}
	}
}