ruleset arrayTests {
	meta {
		name "arrayTests"
		description <<
		Testing arrays
		>>
		author "Nicholas Angell"
		provides testIndex, list_bootstrap, get_appinfo, list_callback
		sharing on
	}

	global {
		testIndex = function(i) {
			c = [1, 2, 3, 4, 5];
			x = c.index(i);
			x;
		}
		list_bootstrap = function(appECI){
			pci:list_bootstrap(appECI);
		}
		get_appinfo = function(appECI){
			pci:get_appinfo(appECI);
		}
		list_callback = function(appECI){
			pci:list_callback(appECI);
		}
		addPCIbootstraps = defaction(appECI,bootstrapRids){
			boot = bootstrapRids.map(function(rid) { 
				pci:add_bootstrap(appECI, rid); 
				}).klog(">>>>>> bootstrap add result >>>>>>>");
			send_directive("pci bootstraps updated.")
			with rulesets = list_bootstrap(appECI); // is this working?
		}
		removeBS = function(appECI){//,bootstrapRids){
			boots = list_bootstrap(appECI);
			boot = boots.map(function(rid) { 
				pci:remove_bootstrap(appECI, rid); 
				}).klog(">>>>>> bootstrap removed result >>>>>>>");
			boots;
		}
		removeCB = function(appECI){//,PCIcallbacks){
			calls = list_callback(appECI);
			boot = calls.map(function(url) { 
				pci:remove_callback(appECI, url); 
				}).klog(">>>>>> callback remove result >>>>>>>");
			calls;
		}
		update_app = defaction(app_eci,app_data,bootstrap_rids){
			remove_appinfo = pci:remove_appinfo(app_eci);
			add_info = pci:add_appinfo(app_eci,{
				"icon": app_data{"app_image_url"},
				"name": app_data{"app_name"},
				"description": app_data{"app_description"},
				"info_url": app_data{"info_page"},
				"declined_url": app_data{"app_declined_url"},
				"developer_secret": app_data{"appSecret"}
				});
			remove_bs = removeBS(app_eci);
			remove_cb = removeCB(app_eci);
			add_callback = pci:add_callback(app_eci, app_data{"app_callback_url"}); 
			addPCIbootstraps(app_eci,bootstrap_rids);
		};
	}

	rule splitTest {
		select when test splitTest
		pre {
			testString = "a,b,c;d,e;f;g,h;i,j";
			testSplit = testString.split(re/[,;]+/).klog("Split String");
			testSplit7 = testSplit[7];
		}
		{
			send_directive("Split")
			with text = "#{testSplit7}";
		}
	}

	rule updateClient {
		select when test updateClient
		pre {
			app_data_attrs={
				"info_page": "q",
				"bootstrap_rids": "w",
				"app_name": "e",
				"app_description": "r",
				"app_image_url": "t",
				"app_callback_url": "y".split(re/;/),
				"app_declined_url": "u",
				"appSecret": "rAN5qd+AMvg0FFr7GFKYJuT6r4yylque1Q9x6PLjVU0"
			};
			identifier = "24A64F0A-1ED5-11E6-9716-94D6E71C24E1";
			app_data = (app_data_attrs);// keep app secrets for update// need to see what the real varibles are named........
			bootstrap_rids = app_data{"bootstrap_rids"}.split(re/;/).klog(">>>>>> bootstrap in >>>>>>>");
		}
		{
			update_app(identifier,app_data,bootstrap_rids);
		}
	}

}