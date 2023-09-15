(lang dune 3.4)

(name ip2locationio)

(version 1.0.0)

(generate_opam_files true)
(implicit_transitive_deps false)

(source
 (github ip2location/ip2location-io-ocaml))

(authors "IP2Location.com")

(maintainers "IP2Location.com")

(license MIT)

(documentation https://github.com/ip2location/ip2location-io-ocaml)

(package
 (name ip2locationio)
 (synopsis "IP2Location.io OCaml module to get geolocation and WHOIS data")
 (description "IP2Location.io OCaml module allows user to query for an enriched data set based on IP address and provides WHOIS lookup api that helps users to obtain domain information. ")
 (depends (ocaml (>= "4.08")) dune lwt cohttp cohttp-lwt-unix (yojson (>= "1.6.0")))
 (tags (ip2locationio geolocation)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
