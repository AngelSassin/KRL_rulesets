ruleset manage_fleet {

	global {
		vehicles = function() {
			x = 5;
			x;
		}
	}
	
	rule create_vehicle {
		select when car new_vehicle
		pre {
     		attributes = {}
          	.put(["Prototype_rids"],"") // rulesets needed at install, semicolon separated
          	.put(["name"],"Pico_System_Child") // name for child
          	;
    	}
    	{	
      		event:send({"cid":meta:eci()}, "wrangler", "child_creation")  // wrangler os event.
      		with attrs = attributes.klog("attributes: "); // needs a name attribute for child
    	}
    	always {
      		log("create child for " + child);
    	}
	}

	rule delete_vehicle {
		select when car unneeded_vehicle
		pre {
			name = 
		}
		{
			noop();
		}
		always {

		}
	}


}