open! Core
open OUnit2
open Ir
module Sys = Sys_unix

let _ =
  Sys.getcwd () |> print_endline;
  Sys.chdir "benchmarks";
  let json_files = 
    Sys.readdir "."
    |> Array.to_list
    |> List.filter ~f:(fun x -> Filename.check_suffix x ".json") in
  List.iter json_files
    ~f:(fun file ->
      let ic = In_channel.create file in
      let prog = ic |> Yojson.Basic.from_channel |> Bril.of_json in
      let tests = List.map prog ~f:(fun f -> f |> Func.clean |> DomTest.test_all) in
      Filename.chop_extension file >::: (List.concat tests) |> run_test_tt_main;
      In_channel.close ic)
