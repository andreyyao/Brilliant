
module G: Util.Sig.Unlabelled with type v = string and type VS.Elt.t = string

type t = G.t

val dominators: Ir.Func.t -> t

val bfs: string list -> t -> t

(*
val to_dot: oc:Stdio.Out_channel.t -> nodes:(string list) ->
             t -> unit
                  *)
