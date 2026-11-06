# IP2Location.io OCaml SDK — IP Geolocation, Domain WHOIS & Hosted Domain Lookup

[![GitHub repository](https://img.shields.io/badge/GitHub-ip2location--io--ocaml-181717?logo=github)](https://github.com/ip2location/ip2location-io-ocaml)
[![Documentation](https://img.shields.io/badge/docs-Read%20the%20Docs-blue)](https://ip2location-io-ocaml.readthedocs.io/en/latest/index.html)

**IP2Location.io OCaml SDK** (`ip2locationio`) is an OCaml library for retrieving **IPv4 and IPv6 geolocation, network and IP intelligence data** through the [IP2Location.io API](https://www.ip2location.io/). It also supports **domain WHOIS lookup** and **hosted domain lookup**, allowing OCaml applications to access IP and domain information without manually implementing the API requests.

**Quick links:** [Get an API key](https://www.ip2location.io/pricing) · [Developer documentation](https://ip2location-io-ocaml.readthedocs.io/en/latest/index.html) · [API reference](https://ip2location-io-ocaml.readthedocs.io/en/latest/code.html) · [Official repository](https://github.com/ip2location/ip2location-io-ocaml)

## Features

- **IPv4 and IPv6 geolocation:** Retrieve available country, region, district, city, ZIP/postal code, latitude, longitude and time zone.
- **Network and ASN information:** Access available ASN, AS name, ISP, associated domain, connection type and usage type.
- **Time zone and localization data:** Retrieve time zone information and request translated continent, country, region and city names on eligible plans.
- **Proxy and security signals:** Access available proxy, VPN, Tor, data center, crawler and related signals, along with fraud scores where included in the API response.
- **Additional IP intelligence:** Retrieve supported carrier, country, weather/elevation and advertising category fields.
- **Domain WHOIS lookup:** Query available domain registration dates, registrar, nameservers and contact information.
- **Domain utilities:** Extract a domain name from a URL or get a domain extension.
- **Hosted domains:** Look up domains hosted on an IP address with page-based pagination.
- **OCaml JSON responses:** Lookups return an HTTP status code and JSON data that can be inspected with `Yojson.Basic.Util`.

> **Plan availability:** Fields and security signals vary by API plan and queried IP address. Translation data is available on Plus and Security plans. See [plan details](https://www.ip2location.io/pricing) and the [OCaml API reference](https://ip2location-io-ocaml.readthedocs.io/en/latest/code.html).

## SDK modules

The OCaml quickstart demonstrates the following modules and functions:

| Module or function | Description |
| --- | --- |
| [`Configuration.init api_key`](https://ip2location-io-ocaml.readthedocs.io/en/latest/quickstart.html) | Creates the configuration from your API key. |
| [`Ip_geolocation.lookup config ip lang`](https://ip2location-io-ocaml.readthedocs.io/en/latest/quickstart.html) | Retrieves geolocation and available network/security data for an IPv4 or IPv6 address. |
| [`Domain_whois.lookup config domain`](https://ip2location-io-ocaml.readthedocs.io/en/latest/quickstart.html) | Retrieves available domain WHOIS information. |
| [`Domain_whois.get_domain_name url`](https://ip2location-io-ocaml.readthedocs.io/en/latest/quickstart.html) | Extracts a domain name from a URL. |
| [`Domain_whois.get_domain_extension domain`](https://ip2location-io-ocaml.readthedocs.io/en/latest/quickstart.html) | Gets the domain extension. |
| [`Hosted_domain.lookup config ip page`](https://ip2location-io-ocaml.readthedocs.io/en/latest/quickstart.html) | Retrieves hosted domains using an IP address and page number. |

These are **OCaml module and function names**, which differ from the class-style names used in the API reference prose.

## API access and query limits

IP2Location.io offers keyless geolocation requests through its REST API and a Free plan with an API key:

| API service | Keyless (no API key) | Free plan (with API key) |
| --- | --- | --- |
| IP Geolocation API | **1,000 queries/day** | **50,000 queries/month** |
| Domain WHOIS API | — | **500 queries/month** |
| Hosted Domain API | — | **50 queries/month** |

- **Keyless access:** Available directly through the limited [IP Geolocation REST API](https://www.ip2location.io/ip2location-documentation), with a daily quota reset at **00:00 UTC**. The OCaml SDK documentation requires an API key and the examples below use one.
- **Free plan:** Register for a free API key to use the published monthly quotas.
- **Attribution:** Keyless and Free-plan usage require attribution. Consult the [pricing page](https://www.ip2location.io/pricing) for current conditions.
- **Paid plans:** Refer to [pricing](https://www.ip2location.io/pricing) for increased quotas and additional fields.

For authentication, keyless access and API rate limits, see the [IP Geolocation API documentation](https://www.ip2location.io/ip2location-documentation).

## Requirements

- **OCaml 4.13 or later**, according to the repository's [`ip2locationio.opam`](https://github.com/ip2location/ip2location-io-ocaml/blob/main/ip2locationio.opam).
- **Dune 3.4 or later**.
- [opam](https://opam.ocaml.org/) for managing the OCaml environment and dependencies.
- Project dependencies declared in the package: `lwt`, `cohttp`, `cohttp-lwt-unix`, `uri`, and `yojson` (version 1.6.0 or later).
- An [IP2Location.io API key](https://www.ip2location.io/pricing) for SDK calls and network access to the API services.

## Installation

The official repository documents building with `dune build`. The following workflow uses **opam and Dune** to set up the dependencies from the repository's package definition.

### 1. Clone the SDK

```bash
git clone https://github.com/ip2location/ip2location-io-ocaml.git
cd ip2location-io-ocaml
```

### 2. Install dependencies

With OCaml and opam already installed, use an appropriate opam switch (OCaml 4.13 or newer), then install dependencies described in the local `.opam` file:

```bash
opam install . --deps-only
```

If your shell is not configured for the active opam switch, run `eval $(opam env)` on Linux/macOS before building. The command above installs dependencies; it does not publish or install the SDK as a separate package in another project.

### 3. Build the SDK

```bash
dune build
```

This is the compilation command documented in the [official quickstart](https://ip2location-io-ocaml.readthedocs.io/en/latest/quickstart.html).

### 4. Configure your API key

For application code, prefer reading an API key from your environment rather than committing it to source control.

**Linux / macOS:**

```bash
export IP2LOCATION_API_KEY='YOUR_API_KEY'
```

**Windows Command Prompt:**

```bat
set IP2LOCATION_API_KEY=YOUR_API_KEY
```

The official examples pass a literal key to `Configuration.init`; the environment-variable approach below is an application-level adaptation, not an additional SDK method.

## Quickstart: IP geolocation lookup

The official quickstart uses `Configuration.init` and `Ip_geolocation.lookup`, which returns an HTTP status code and parsed JSON. The example below retains those documented calls while taking the API key from an environment variable.

Create an OCaml executable in a Dune project that depends on the `ip2locationio` and `yojson` libraries:

```ocaml
open Printf
open Ip2locationio

let () =
  let api_key = Sys.getenv "IP2LOCATION_API_KEY" in
  let config = Configuration.init api_key in
  let code, json = Ip_geolocation.lookup config "8.8.8.8" "" in
  if code = 200 then begin
    let open Yojson.Basic.Util in
    printf "IP: %s\n" (json |> member "ip" |> to_string);
    printf "Country: %s\n" (json |> member "country_name" |> to_string);
    printf "City: %s\n" (json |> member "city_name" |> to_string)
  end else
    printf "HTTP Code: %d\n" code
```

For example, when adding a `lookup.ml` file to an existing Dune project with the SDK available, its `dune` executable stanza can include:

```lisp
(executable
 (name lookup)
 (libraries ip2locationio yojson))
```

Run it from the project root with:

```bash
dune exec ./lookup.exe
```

**Setup note:** This executable example assumes the OCaml project can resolve the `ip2locationio` library (for instance, when developed within the SDK source tree or after installing the package into the active opam switch). The repository's documented minimal build command is `dune build`; adapt the executable name and location to your project.

The returned JSON fields depend on the IP address and plan. See the [OCaml API field reference](https://ip2location-io-ocaml.readthedocs.io/en/latest/code.html).

## OCaml responses and JSON fields

Unlike SDKs that return model objects directly, the documented OCaml lookups return a pair such as `code, json`. Check the HTTP status before extracting the response with `Yojson.Basic.Util`. Optional JSON fields can be `Null`; check them before using strict converters such as `to_string`, `to_int`, or `to_bool`.

All the following lookup examples assume:

```ocaml
open Printf
open Ip2locationio

let config = Configuration.init (Sys.getenv "IP2LOCATION_API_KEY")
```

These are independent snippets to place in your own program after the shared initialization.

## More usage examples

### Request translated location names

The third argument to `Ip_geolocation.lookup` is a language code. The official quickstart uses `"es"` for Spanish, with translation support on **Plus and Security** plans.

```ocaml
let code, json = Ip_geolocation.lookup config "8.8.8.8" "es" in
if code = 200 then
  print_endline (Yojson.Basic.pretty_to_string json)
```

Use `""` when translated names are not needed.

### Inspect ASN and ISP information

The documented geolocation response can include `asn`, `as`, `isp` and plan-dependent `as_info` details.

```ocaml
let code, json = Ip_geolocation.lookup config "8.8.8.8" "" in
if code = 200 then begin
  let open Yojson.Basic.Util in
  let show key =
    match member key json with
    | `String value -> value
    | _ -> "N/A"
  in
  printf "ASN: %s\n" (show "asn");
  printf "AS: %s\n" (show "as");
  printf "ISP: %s\n" (show "isp")
end
```

This shorter extraction example is adapted from the response fields in the official geolocation quickstart.

### Inspect available proxy indicators

Some proxy fields are unavailable for certain plans or responses. The following additional example checks the nested JSON object before reading the flags.

```ocaml
let code, json = Ip_geolocation.lookup config "8.8.8.8" "" in
if code = 200 then begin
  let open Yojson.Basic.Util in
  let proxy = member "proxy" json in
  if proxy <> `Null then begin
    let show_flag name =
      match member name proxy with
      | `Bool value -> string_of_bool value
      | _ -> "N/A"
    in
    printf "VPN: %s\n" (show_flag "is_vpn");
    printf "Tor: %s\n" (show_flag "is_tor")
  end else
    print_endline "Proxy details unavailable."
end
```

### Look up domain WHOIS information

`Domain_whois.lookup` is demonstrated in the official quickstart. WHOIS attributes, including registration and contact data, may be absent or redacted.

```ocaml
let code, json = Domain_whois.lookup config "google.com" in
if code = 200 then begin
  let open Yojson.Basic.Util in
  let show key =
    match member key json with
    | `String value -> value
    | _ -> "N/A"
  in
  printf "Domain: %s\n" (show "domain");
  printf "Created: %s\n" (show "create_date");
  printf "Expires: %s\n" (show "expire_date");
  let registrar = member "registrar" json in
  (match member "name" registrar with
   | `String name -> printf "Registrar: %s\n" name
   | _ -> print_endline "Registrar: N/A")
end
```

See the [WHOIS API reference](https://ip2location-io-ocaml.readthedocs.io/en/latest/code.html) for other fields, including nameservers.

### Extract a domain name or extension

The official quickstart includes these helper functions, which do not require a network lookup:

```ocaml
let domain_name = Domain_whois.get_domain_name "https://www.example.com/exe" in
printf "Domain name: %s\n" domain_name;

let extension = Domain_whois.get_domain_extension "example.com" in
printf "Domain extension: %s\n" extension
```

The OCaml documentation demonstrates **domain name and extension helpers**; it does not document Punycode conversion helpers for this SDK.

### Find domains hosted on an IP address

`Hosted_domain.lookup` accepts a configuration, IP address and page number. The official quickstart uses page `1`.

```ocaml
let code, json = Hosted_domain.lookup config "8.8.8.8" 1 in
if code = 200 then begin
  let open Yojson.Basic.Util in
  let total_domains = json |> member "total_domains" |> to_int in
  printf "Total domains: %d\n" total_domains;
  (match member "domains" json with
   | `List domains ->
       List.iter
         (function `String domain -> print_endline domain | _ -> ())
         domains
   | _ -> ())
end
```

Request page `2`, `3`, and so on when more pages are available. Responses may include `page`, `per_page` and `total_pages`.

## OCaml and Dune troubleshooting

- **Missing package or module:** Confirm the active opam switch and install dependencies using `opam install . --deps-only` from the cloned SDK directory. Use `opam exec -- dune build` if your shell is not configured for the switch.
- **Dune version mismatch:** The `.opam` manifest requires Dune 3.4 or later; verify with `dune --version`.
- **Missing API key:** Check that `IP2LOCATION_API_KEY` is defined in the shell that runs the executable. The official code uses `Configuration.init "YOUR_API_KEY"` as a simpler alternative.
- **Unexpected missing fields:** API plans and IP addresses may return different JSON structures. Check for `Null` values before calling strict JSON conversion functions.
- **Non-200 status:** The official samples examine the returned HTTP status code and, for 400/401 responses, the API's `error.error_message` field. Check the API key, quota and request before retrying.

## Common use cases

- **Website and application localization:** Choose suggested region-aware language, content or currency using approximate IP location.
- **Traffic analytics:** Enrich application events with country, city, ASN and ISP data.
- **Security review:** Consider available proxy, VPN, Tor and other signals as part of a broader risk assessment, not the sole basis for blocking users.
- **Domain research:** Retrieve domain registration dates, registrar information and nameservers from WHOIS results.
- **Network and hosting research:** Investigate ASNs, ISPs and domains hosted on specific IP addresses.

## Documentation and support

- [OCaml SDK quickstart and official sample code](https://ip2location-io-ocaml.readthedocs.io/en/latest/quickstart.html)
- [OCaml API reference and response fields](https://ip2location-io-ocaml.readthedocs.io/en/latest/code.html)
- [Official GitHub repository](https://github.com/ip2location/ip2location-io-ocaml)
- [OCaml package manifest and dependencies](https://github.com/ip2location/ip2location-io-ocaml/blob/main/ip2locationio.opam)
- [IP2Location.io API plans and query limits](https://www.ip2location.io/pricing)
- [IP Geolocation API documentation](https://www.ip2location.io/ip2location-documentation)
- [Report an OCaml SDK issue or request a feature](https://github.com/ip2location/ip2location-io-ocaml/issues)
- [API and account support](https://www.ip2location.io/contact-us)

## License

Licensed under the **MIT License**. See [LICENSE](./LICENSE).
