open! Core
open Ir
open Util

(**[Next] is fall through*)
type edge_lbl = True | False | Jump | Next

module G: Sig.Labelled
       with type v = string
        and type e = edge_lbl

type block_t = string * Instr.t Array.t
(**[(block_name, instrs)]*)

type t = {
  graph : G.t; (*The control flow graph*)
  args : Instr.dest list;
  order : string list; (*Blocks in original order*)
  ret_type : Bril_type.t option;
  func_name : string; (*Name of function this cfg represents*)
  map : block_t SM.t; (*yeah*)
}

val of_func : Func.t -> t
val to_func : t -> Func.t
val to_dot : names_only:bool -> Out_channel.t -> t -> unit