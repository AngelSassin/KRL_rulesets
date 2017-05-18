ruleset io.picolabs.edmund_api { 
  meta {
    provides decode_vin
  }


  global {
    decode_vin = function(vin) {
      base_url = "https://api.edmunds.com/v1/api/toolsrepository/vindecoder?vin=" + vin + "&fmt=json&api_key=" + account_sid;
      http:get(base_url) 
        with parseJSON = true
    }
  }


}
