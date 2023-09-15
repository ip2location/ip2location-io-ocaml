module Configuration :
  sig
    type config = {
      source_version : string;
      api_key : string;
      format: string;
      source: string;
    }
    val init : string -> config
  end
module Ip_geolocation :
  sig
    val lookup :
      Configuration.config -> string -> string -> int * Yojson.Basic.t
  end
module Domain_whois :
  sig
    val lookup :
      Configuration.config -> string -> int * Yojson.Basic.t
    val get_domain_name :
      string -> string
    val get_domain_extension :
      string -> string
  end
