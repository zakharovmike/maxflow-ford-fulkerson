open Graph

(* Clone a graph keeping only its nodes  *)
val clone_nodes: 'a graph -> 'b graph

(* Map all arcs of a graph by a provided function *)
val gmap: 'a graph -> ('a -> 'b) -> 'b graph

(* Add n to the label of the arc from id1 to id2.
 * Create an arc from id1 to id2 with value n if one does not already exist. *)
val add_arc: int graph -> id -> id -> int -> int graph
