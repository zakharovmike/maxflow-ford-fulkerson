open Graph
open Gfile

(* A path is a list of nodes. *)
type path

(* The empty path. *)
val empty_path: path

(* Prints path
 * ex: 0 2 3 5 7 *)
val print_path: path -> unit

(* find_path gr forbidden id1 id2 
 *   returns None if no path can be found.
 *   returns Some p if a path p from id1 to id2 has been found. 
 *
 *  forbidden is a list of forbidden nodes (they have already been visited)
*)
val find_path: int graph -> id list -> id -> id -> path option

(* find_bottleneck path graph
 *   returns the minimum capacity along the path in graph *)
val find_bottleneck: path -> int graph -> int

(* update_residual_graph graph path flow
 *   returns a graph where the flow has been added along the path in graph *)
val update_residual_graph: int graph -> path -> int -> int graph

(* get_max_flow graph source sink
 *   returns the max flow between the source and the sink on the given graph *)
val get_max_flow: int graph -> id -> id -> int

(* Same as get_max_flow but also creates text and graphviz files of the final graph *)
val get_max_flow_with_output_graph: int graph -> id -> id -> Gfile.path -> int
