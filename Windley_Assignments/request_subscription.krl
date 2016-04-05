ruleset request_subscription {
	
	meta {
		name "request_subscription"
    	description <<
      		Fleet Subscription Assignment
      		>>
    	author "Nicholas Angell"
    	use module b507199x5 alias wrangler_api
    }

    rule childToParent {
    	select when wrangler init_events
    	pre {
       		parent_results = wrangler_api:parent();
       		parent = parent_results{'parent'};
       		parent_eci = parent[0]; // eci is the first element in tuple 
       		attrs = {}.put(["name"],event:attr("name"))
                      .put(["name_space"],"Fleet_Management")
                      .put(["my_role"],"vehicle")
                      .put(["your_role"],"fleet")
                      .put(["target_eci"],parent_eci.klog("Target Eci: "))
                      .put(["channel_type"],"Lab2_Pico_Systems")
                      .put(["attrs"],"success")
                      ;
    	}
    	{
     		noop();
    	}
    	always {
      		raise wrangler event "subscription"
      			attributes attrs;
    	}
  	}
}