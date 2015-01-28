#!/usr/bin/env bash

./scripts/clean.sh

pushd src &> /dev/null

atdgen -t -j-std har.atd
atdgen -j -j-std har.atd

ocamlfind ocamlc -c har_t.mli -package atdgen
ocamlfind ocamlc -c har_j.mli -package atdgen
ocamlfind ocamlc -c har_t.ml -package atdgen
ocamlfind ocamlc -c har_j.ml -package atdgen


ocamlfind ocamlc -c settings.ml

ocamlfind ocamlc -c http_utils.mli -package cohttp.lwt
ocamlfind ocamlc -c http_utils.ml -thread -package core,cohttp.lwt

ocamlfind ocamlc -c archive.mli -package cohttp.lwt
ocamlfind ocamlc -c archive.ml -thread -package core,cohttp.lwt

ocamlfind ocamlc -c cache.mli -thread -package core,lwt
ocamlfind ocamlc -c cache.ml -thread -package core,lwt

ocamlfind ocamlc -c network.mli -thread -package core,cohttp.lwt,lwt-zmq
ocamlfind ocamlc -c network.ml -thread -package core,cohttp.lwt,lwt-zmq,dns

ocamlfind ocamlc -c proxy.mli -package lwt
ocamlfind ocamlc -c proxy.ml -thread -package core,lwt.syntax,cohttp.lwt,lwt-zmq -syntax camlp4o


mv *.cm* ..
rm har_*.ml*

popd &> /dev/null
