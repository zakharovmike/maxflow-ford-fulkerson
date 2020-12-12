open Graph

(* A path is a list of nodes. *)
type path

(* The empty graph. *)
val empty_path: path

val print_path: path -> unit

(* find_path gr forbidden id1 id2 
 *   returns None if no path can be found.
 *   returns Some p if a path p from id1 to id2 has been found. 
 *
 *  forbidden is a list of forbidden nodes (they have already been visited)
*)
val find_path: int graph -> id list -> id -> id -> path option

val find_bottleneck: path -> int graph -> int

val update_residual_graph: int graph -> path -> int -> int graph

(* get_max_flow graph source sink
 * returns the max flow between the source and the sink on the given graph.
*)
val get_max_flow: int graph -> id -> id -> int
