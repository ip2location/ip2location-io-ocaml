open Printf
open Ip2locationio

exception Ws_exception of string

let my_config = Configuration.init "YOUR_API_KEY";;

let my_ip = "8.8.8.8";;
let my_lang = "fr";; (* language only supported in Plus and Security plans, so leave as blank if not needed *)
let code, json = Ip_geolocation.lookup my_config my_ip my_lang;;

let open Yojson.Basic.Util in
if code == 200
then
begin
  let ip = json |> member "ip" |> to_string in
  printf "ip: %s\n" ip;
  let country_code = json |> member "country_code" |> to_string in
  printf "country_code: %s\n" country_code;
  let country_name = json |> member "country_name" |> to_string in
  printf "country_name: %s\n" country_name;
  let region_name = json |> member "region_name" |> to_string in
  printf "region_name: %s\n" region_name;
  let city_name = json |> member "city_name" |> to_string in
  printf "city_name: %s\n" city_name;
  let latitude = json |> member "latitude" |> to_float in
  printf "latitude: %f\n" latitude;
  let longitude = json |> member "longitude" |> to_float in
  printf "longitude: %f\n" longitude;
  let zip_code = json |> member "zip_code" |> to_string in
  printf "zip_code: %s\n" zip_code;
  let time_zone = json |> member "time_zone" |> to_string in
  printf "time_zone: %s\n" time_zone;
  let asn = json |> member "asn" |> to_string in
  printf "asn: %s\n" asn;
  let as_name = json |> member "as" |> to_string in
  printf "as: %s\n" as_name;
  let isp = if json |> member "isp" = `Null then "N/A" else json |> member "isp" |> to_string in
  printf "isp: %s\n" isp;
  let domain = if json |> member "domain" = `Null then "N/A" else json |> member "domain" |> to_string in
  printf "domain: %s\n" domain;
  let net_speed = if json |> member "net_speed" = `Null then "N/A" else json |> member "net_speed" |> to_string in
  printf "net_speed: %s\n" net_speed;
  let idd_code = if json |> member "idd_code" = `Null then "N/A" else json |> member "idd_code" |> to_string in
  printf "idd_code: %s\n" idd_code;
  let area_code = if json |> member "area_code" = `Null then "N/A" else json |> member "area_code" |> to_string in
  printf "area_code: %s\n" area_code;
  let weather_station_code = if json |> member "weather_station_code" = `Null then "N/A" else json |> member "weather_station_code" |> to_string in
  printf "weather_station_code: %s\n" weather_station_code;
  let weather_station_name = if json |> member "weather_station_name" = `Null then "N/A" else json |> member "weather_station_name" |> to_string in
  printf "weather_station_name: %s\n" weather_station_name;
  let mcc = if json |> member "mcc" = `Null then "N/A" else json |> member "mcc" |> to_string in
  printf "mcc: %s\n" mcc;
  let mnc = if json |> member "mnc" = `Null then "N/A" else json |> member "mnc" |> to_string in
  printf "mnc: %s\n" mnc;
  let mobile_brand = if json |> member "mobile_brand" = `Null then "N/A" else json |> member "mobile_brand" |> to_string in
  printf "mobile_brand: %s\n" mobile_brand;
  let elevation = if json |> member "elevation" = `Null then 0 else json |> member "elevation" |> to_int in
  printf "elevation: %d\n" elevation;
  let usage_type = if json |> member "usage_type" = `Null then "N/A" else json |> member "usage_type" |> to_string in
  printf "usage_type: %s\n" usage_type;
  let address_type = if json |> member "address_type" = `Null then "N/A" else json |> member "address_type" |> to_string in
  printf "address_type: %s\n" address_type;
  let district = if json |> member "district" = `Null then "N/A" else json |> member "district" |> to_string in
  printf "district: %s\n" district;
  let ads_category = if json |> member "ads_category" = `Null then "N/A" else json |> member "ads_category" |> to_string in
  printf "ads_category: %s\n" ads_category;
  let ads_category_name = if json |> member "ads_category_name" = `Null then "N/A" else json |> member "ads_category_name" |> to_string in
  printf "ads_category_name: %s\n" ads_category_name;
  let is_proxy = json |> member "is_proxy" |> to_bool in
  printf "is_proxy: %b\n" is_proxy;
  let fraud_score = if json |> member "fraud_score" = `Null then 0 else json |> member "fraud_score" |> to_int in
  printf "fraud_score: %d\n" fraud_score;
  
  (* continent addon *)
  if (member "continent" json) <> `Null
  then
  begin
    let continent_name = json |> member "continent" |> member "name" |> to_string in
    printf "continent_name: %s\n" continent_name;
    let continent_code = json |> member "continent" |> member "code" |> to_string in
    printf "continent_code: %s\n" continent_code;
    let continent_hemisphere = json |> member "continent" |> member "hemisphere" |> to_list |> List.map (fun x -> x |> to_string) in
    print_endline "continent_hemisphere:";
    List.iter (fun x -> x |> print_endline) continent_hemisphere;
    if (json |> member "continent" |> member "translation" |> member "lang") <> `Null
    then
    begin
      let continent_translation_lang = json |> member "continent" |> member "translation" |> member "lang" |> to_string in
      printf "continent_translation_lang: %s\n" continent_translation_lang;
      let continent_translation_value = json |> member "continent" |> member "translation" |> member "value" |> to_string in
      printf "continent_translation_value: %s\n" continent_translation_value;
    end;
  end;
  
  (* country addon *)
  if (member "country" json) <> `Null
  then
  begin
    let country_name = json |> member "country" |> member "name" |> to_string in
    printf "country_name: %s\n" country_name;
    let country_alpha3_code = json |> member "country" |> member "alpha3_code" |> to_string in
    printf "country_alpha3_code: %s\n" country_alpha3_code;
    let country_numeric_code = json |> member "country" |> member "numeric_code" |> to_int in
    printf "country_numeric_code: %d\n" country_numeric_code;
    let country_demonym = json |> member "country" |> member "demonym" |> to_string in
    printf "country_demonym: %s\n" country_demonym;
    let country_flag = json |> member "country" |> member "flag" |> to_string in
    printf "country_flag: %s\n" country_flag;
    let country_capital = json |> member "country" |> member "capital" |> to_string in
    printf "country_capital: %s\n" country_capital;
    let country_total_area = json |> member "country" |> member "total_area" |> to_int in
    printf "country_total_area: %d\n" country_total_area;
    let country_population = json |> member "country" |> member "population" |> to_int in
    printf "country_population: %d\n" country_population;
    let country_tld = json |> member "country" |> member "tld" |> to_string in
    printf "country_tld: %s\n" country_tld;
    let country_currency_code = json |> member "country" |> member "currency" |> member "code" |> to_string in
    printf "country_currency_code: %s\n" country_currency_code;
    let country_currency_name = json |> member "country" |> member "currency" |> member "name" |> to_string in
    printf "country_currency_name: %s\n" country_currency_name;
    let country_currency_symbol = json |> member "country" |> member "currency" |> member "symbol" |> to_string in
    printf "country_currency_symbol: %s\n" country_currency_symbol;
    let country_language_code = json |> member "country" |> member "language" |> member "code" |> to_string in
    printf "country_language_code: %s\n" country_language_code;
    let country_language_name = json |> member "country" |> member "language" |> member "name" |> to_string in
    printf "country_language_name: %s\n" country_language_name;
    if (json |> member "country" |> member "translation" |> member "lang") <> `Null
    then
    begin
      let country_translation_lang = json |> member "country" |> member "translation" |> member "lang" |> to_string in
      printf "country_translation_lang: %s\n" country_translation_lang;
      let country_translation_value = json |> member "country" |> member "translation" |> member "value" |> to_string in
      printf "country_translation_value: %s\n" country_translation_value;
    end;
  end;
  
  (* region addon *)
  if (member "region" json) <> `Null
  then
  begin
    let region_name = json |> member "region" |> member "name" |> to_string in
    printf "region_name: %s\n" region_name;
    let region_code = json |> member "region" |> member "code" |> to_string in
    printf "region_code: %s\n" region_code;
    if (json |> member "region" |> member "translation" |> member "lang") <> `Null
    then
    begin
      let region_translation_lang = json |> member "region" |> member "translation" |> member "lang" |> to_string in
      printf "region_translation_lang: %s\n" region_translation_lang;
      let region_translation_value = json |> member "region" |> member "translation" |> member "value" |> to_string in
      printf "region_translation_value: %s\n" region_translation_value;
    end;
  end;
  
  (* city addon *)
  if (member "city" json) <> `Null
  then
  begin
    let city_name = json |> member "city" |> member "name" |> to_string in
    printf "city_name: %s\n" city_name;
    if (json |> member "city" |> member "translation" |> member "lang") <> `Null
    then
    begin
      let city_translation_lang = json |> member "city" |> member "translation" |> member "lang" |> to_string in
      printf "city_translation_lang: %s\n" city_translation_lang;
      let city_translation_value = json |> member "city" |> member "translation" |> member "value" |> to_string in
      printf "city_translation_value: %s\n" city_translation_value;
    end
  end;
  
  (* time_zone_info addon *)
  if (member "time_zone_info" json) <> `Null
  then
  begin
    let time_zone_info_olson = json |> member "time_zone_info" |> member "olson" |> to_string in
    printf "time_zone_info_olson: %s\n" time_zone_info_olson;
    let time_zone_info_current_time = json |> member "time_zone_info" |> member "current_time" |> to_string in
    printf "time_zone_info_current_time: %s\n" time_zone_info_current_time;
    let time_zone_info_gmt_offset = json |> member "time_zone_info" |> member "gmt_offset" |> to_int in
    printf "time_zone_info_gmt_offset: %d\n" time_zone_info_gmt_offset;
    let time_zone_info_is_dst = json |> member "time_zone_info" |> member "is_dst" |> to_bool in
    printf "time_zone_info_is_dst: %b\n" time_zone_info_is_dst;
    let time_zone_info_sunrise = json |> member "time_zone_info" |> member "sunrise" |> to_string in
    printf "time_zone_info_sunrise: %s\n" time_zone_info_sunrise;
    let time_zone_info_sunset = json |> member "time_zone_info" |> member "sunset" |> to_string in
    printf "time_zone_info_sunset: %s\n" time_zone_info_sunset;
  end;
  
  (* geotargeting addon *)
  if (member "geotargeting" json) <> `Null
  then
  begin
    let geotargeting_metro = json |> member "geotargeting" |> member "metro" |> to_string in
    printf "geotargeting_metro: %s\n" geotargeting_metro;
  end;
  
  (* proxy addon *)
  if (member "proxy" json) <> `Null
  then
  begin
    let proxy_last_seen = json |> member "proxy" |> member "last_seen" |> to_int in
    printf "proxy_last_seen: %d\n" proxy_last_seen;
    let proxy_proxy_type = json |> member "proxy" |> member "proxy_type" |> to_string in
    printf "proxy_proxy_type: %s\n" proxy_proxy_type;
    let proxy_threat = json |> member "proxy" |> member "threat" |> to_string in
    printf "proxy_threat: %s\n" proxy_threat;
    let proxy_provider = json |> member "proxy" |> member "provider" |> to_string in
    printf "proxy_provider: %s\n" proxy_provider;
    let proxy_is_vpn = json |> member "proxy" |> member "is_vpn" |> to_bool in
    printf "proxy_is_vpn: %b\n" proxy_is_vpn;
    let proxy_is_tor = json |> member "proxy" |> member "is_tor" |> to_bool in
    printf "proxy_is_tor: %b\n" proxy_is_tor;
    let proxy_is_data_center = json |> member "proxy" |> member "is_data_center" |> to_bool in
    printf "proxy_is_data_center: %b\n" proxy_is_data_center;
    let proxy_is_public_proxy = json |> member "proxy" |> member "is_public_proxy" |> to_bool in
    printf "proxy_is_public_proxy: %b\n" proxy_is_public_proxy;
    let proxy_is_web_proxy = json |> member "proxy" |> member "is_web_proxy" |> to_bool in
    printf "proxy_is_web_proxy: %b\n" proxy_is_web_proxy;
    let proxy_is_web_crawler = json |> member "proxy" |> member "is_web_crawler" |> to_bool in
    printf "proxy_is_web_crawler: %b\n" proxy_is_web_crawler;
    let proxy_is_residential_proxy = json |> member "proxy" |> member "is_residential_proxy" |> to_bool in
    printf "proxy_is_residential_proxy: %b\n" proxy_is_residential_proxy;
    let proxy_is_spammer = json |> member "proxy" |> member "is_spammer" |> to_bool in
    printf "proxy_is_spammer: %b\n" proxy_is_spammer;
    let proxy_is_scanner = json |> member "proxy" |> member "is_scanner" |> to_bool in
    printf "proxy_is_scanner: %b\n" proxy_is_scanner;
    let proxy_is_botnet = json |> member "proxy" |> member "is_botnet" |> to_bool in
    printf "proxy_is_botnet: %b\n" proxy_is_botnet;
  end
end
else if (code == 400 || code == 401) && ((member "error" json) <> `Null)
then
begin
  let error_message = json |> member "error" |> member "error_message" |> to_string in
  raise (Ws_exception ("error_message: " ^ error_message));
end
else
  raise (Ws_exception ("HTTP Code: " ^ (Int.to_string code)))

let my_domain = "google.com";;
let code, json = Domain_whois.lookup my_config my_domain;;

let open Yojson.Basic.Util in
if code == 200
then
begin
  let domain = json |> member "domain" |> to_string in
  printf "domain: %s\n" domain;
  let domain_id = json |> member "domain_id" |> to_string in
  printf "domain_id: %s\n" domain_id;
  let status = json |> member "status" |> to_string in
  printf "status: %s\n" status;
  let create_date = json |> member "create_date" |> to_string in
  printf "create_date: %s\n" create_date;
  let update_date = json |> member "update_date" |> to_string in
  printf "update_date: %s\n" update_date;
  let expire_date = json |> member "expire_date" |> to_string in
  printf "expire_date: %s\n" expire_date;
  let domain_age = json |> member "domain_age" |> to_int in
  printf "domain_age: %d\n" domain_age;
  let whois_server = json |> member "whois_server" |> to_string in
  printf "whois_server: %s\n" whois_server;
  
  let registrar_iana_id = json |> member "registrar" |> member "iana_id" |> to_string in
  printf "registrar_iana_id: %s\n" registrar_iana_id;
  let registrar_name = json |> member "registrar" |> member "name" |> to_string in
  printf "registrar_name: %s\n" registrar_name;
  let registrar_url = json |> member "registrar" |> member "url" |> to_string in
  printf "registrar_url: %s\n" registrar_url;
  
  let registrant_name = json |> member "registrant" |> member "name" |> to_string in
  printf "registrant_name: %s\n" registrant_name;
  let registrant_organization = json |> member "registrant" |> member "organization" |> to_string in
  printf "registrant_organization: %s\n" registrant_organization;
  let registrant_street_address = json |> member "registrant" |> member "street_address" |> to_string in
  printf "registrant_street_address: %s\n" registrant_street_address;
  let registrant_city = json |> member "registrant" |> member "city" |> to_string in
  printf "registrant_city: %s\n" registrant_city;
  let registrant_region = json |> member "registrant" |> member "region" |> to_string in
  printf "registrant_region: %s\n" registrant_region;
  let registrant_zip_code = json |> member "registrant" |> member "zip_code" |> to_string in
  printf "registrant_zip_code: %s\n" registrant_zip_code;
  let registrant_country = json |> member "registrant" |> member "country" |> to_string in
  printf "registrant_country: %s\n" registrant_country;
  let registrant_phone = json |> member "registrant" |> member "phone" |> to_string in
  printf "registrant_phone: %s\n" registrant_phone;
  let registrant_fax = json |> member "registrant" |> member "fax" |> to_string in
  printf "registrant_fax: %s\n" registrant_fax;
  let registrant_email = json |> member "registrant" |> member "email" |> to_string in
  printf "registrant_email: %s\n" registrant_email;
  
  let admin_name = json |> member "admin" |> member "name" |> to_string in
  printf "admin_name: %s\n" admin_name;
  let admin_organization = json |> member "admin" |> member "organization" |> to_string in
  printf "admin_organization: %s\n" admin_organization;
  let admin_street_address = json |> member "admin" |> member "street_address" |> to_string in
  printf "admin_street_address: %s\n" admin_street_address;
  let admin_city = json |> member "admin" |> member "city" |> to_string in
  printf "admin_city: %s\n" admin_city;
  let admin_region = json |> member "admin" |> member "region" |> to_string in
  printf "admin_region: %s\n" admin_region;
  let admin_zip_code = json |> member "admin" |> member "zip_code" |> to_string in
  printf "admin_zip_code: %s\n" admin_zip_code;
  let admin_country = json |> member "admin" |> member "country" |> to_string in
  printf "admin_country: %s\n" admin_country;
  let admin_phone = json |> member "admin" |> member "phone" |> to_string in
  printf "admin_phone: %s\n" admin_phone;
  let admin_fax = json |> member "admin" |> member "fax" |> to_string in
  printf "admin_fax: %s\n" admin_fax;
  let admin_email = json |> member "admin" |> member "email" |> to_string in
  printf "admin_email: %s\n" admin_email;
  
  let tech_name = json |> member "tech" |> member "name" |> to_string in
  printf "tech_name: %s\n" tech_name;
  let tech_organization = json |> member "tech" |> member "organization" |> to_string in
  printf "tech_organization: %s\n" tech_organization;
  let tech_street_address = json |> member "tech" |> member "street_address" |> to_string in
  printf "tech_street_address: %s\n" tech_street_address;
  let tech_city = json |> member "tech" |> member "city" |> to_string in
  printf "tech_city: %s\n" tech_city;
  let tech_region = json |> member "tech" |> member "region" |> to_string in
  printf "tech_region: %s\n" tech_region;
  let tech_zip_code = json |> member "tech" |> member "zip_code" |> to_string in
  printf "tech_zip_code: %s\n" tech_zip_code;
  let tech_country = json |> member "tech" |> member "country" |> to_string in
  printf "tech_country: %s\n" tech_country;
  let tech_phone = json |> member "tech" |> member "phone" |> to_string in
  printf "tech_phone: %s\n" tech_phone;
  let tech_fax = json |> member "tech" |> member "fax" |> to_string in
  printf "tech_fax: %s\n" tech_fax;
  let tech_email = json |> member "tech" |> member "email" |> to_string in
  printf "tech_email: %s\n" tech_email;
  
  let billing_name = json |> member "billing" |> member "name" |> to_string in
  printf "billing_name: %s\n" billing_name;
  let billing_organization = json |> member "billing" |> member "organization" |> to_string in
  printf "billing_organization: %s\n" billing_organization;
  let billing_street_address = json |> member "billing" |> member "street_address" |> to_string in
  printf "billing_street_address: %s\n" billing_street_address;
  let billing_city = json |> member "billing" |> member "city" |> to_string in
  printf "billing_city: %s\n" billing_city;
  let billing_region = json |> member "billing" |> member "region" |> to_string in
  printf "billing_region: %s\n" billing_region;
  let billing_zip_code = json |> member "billing" |> member "zip_code" |> to_string in
  printf "billing_zip_code: %s\n" billing_zip_code;
  let billing_country = json |> member "billing" |> member "country" |> to_string in
  printf "billing_country: %s\n" billing_country;
  let billing_phone = json |> member "billing" |> member "phone" |> to_string in
  printf "billing_phone: %s\n" billing_phone;
  let billing_fax = json |> member "billing" |> member "fax" |> to_string in
  printf "billing_fax: %s\n" billing_fax;
  let billing_email = json |> member "billing" |> member "email" |> to_string in
  printf "billing_email: %s\n" billing_email;
  
  let nameservers = json |> member "nameservers" |> to_list |> List.map (fun x -> x |> to_string) in
  print_endline "nameservers:";
  List.iter (fun x -> x |> print_endline) nameservers;
end
else if (code == 400 || code == 401) && ((member "error" json) <> `Null)
then
begin
  let error_message = json |> member "error" |> member "error_message" |> to_string in
  raise (Ws_exception ("error_message: " ^ error_message));
end
else
  raise (Ws_exception ("HTTP Code: " ^ (Int.to_string code)))

let domain_name = Domain_whois.get_domain_name "https://www.example.com/exe";;
printf "domain_name: %s\n" domain_name;;

let domain_extension = Domain_whois.get_domain_extension "example.com";;
printf "domain_extension: %s\n" domain_extension;;

let my_ip = "8.8.8.8";;
let my_page = 1;;
let code, json = Hosted_domain.lookup my_config my_ip my_page;;

let open Yojson.Basic.Util in
if code == 200
then
begin
  let ip = json |> member "ip" |> to_string in
  printf "ip: %s\n" ip;
  let total_domains = json |> member "total_domains" |> to_int in
  printf "total_domains: %d\n" total_domains;
  let page = json |> member "page" |> to_int in
  printf "page: %d\n" page;
  let per_page = json |> member "per_page" |> to_int in
  printf "per_page: %d\n" per_page;
  let total_pages = json |> member "total_pages" |> to_int in
  printf "total_pages: %d\n" total_pages;
  let domains = json |> member "domains" |> to_list |> List.map (fun x -> x |> to_string) in
  print_endline "domains:";
  List.iter (fun x -> x |> print_endline) domains;
end
else if (code == 400 || code == 401) && ((member "error" json) <> `Null)
then
begin
  let error_message = json |> member "error" |> member "error_message" |> to_string in
  raise (Ws_exception ("error_message: " ^ error_message));
end
else
  raise (Ws_exception ("HTTP Code: " ^ (Int.to_string code)))
