open Graph
open Tools
open Gfile

type path = id list

let empty_path = []

let rec print_path = function
  | node :: rest -> 
    Printf.printf "%d " node ;
    print_path rest
  | [] -> Printf.printf "\n%!"

(* Uses depth-first search to find a path in a graph 
 * from the source to the sink while avoiding forbidden_nodes. *)
let find_path graph forbidden_nodes source sink =

  let rec dfs visited node = 
    if node = sink then Some empty_path else

    (* Find a node's adjacent nodes, avoiding:
     *  - those that have already been visited, and
     *  - those that are already saturated *)
    let neighbors = List.filter
      (fun (node, lbl) -> not (List.mem node visited) && lbl != 0) 
      (out_arcs graph node)
    in
    match neighbors with
    | [] -> None
    | (next, _) :: _ ->
      match dfs (next::visited) next with   (* Search for path from an adjacent node *)
      | None -> dfs (next::visited) node    (* If no path found, retry from parent node, avoiding that adjacent node as well *)
      | Some path -> Some (next :: path)    (* If a path has been found, contruct it on its way back up the call stack *)
  in

  match dfs forbidden_nodes source with
  | Some path -> Some (source :: path)      (* If a path is found, add the source node to it and return  *)
  | None -> None

let find_bottleneck path graph =

  let rec loop path graph bottleneck =
    match path with
    | a :: b :: rest -> 
      let capacity = Option.get (find_arc graph a b) in   (* The arc existes for sure given it's in a path *)
      min (loop (b::rest) graph capacity) bottleneck      (* min capacity bottleneck, recursively on all arcs of path *)
    | last :: rest -> bottleneck
    | [] -> bottleneck
  in

  loop path graph Int.max_int

(* The residual graph contains all forward and backward arcs after
 * the flow has been added along the path.
 * 
 * A forward arc is an original arc of the graph with its remaining capacity.
 * Instead of starting at 0 and adding flow up to at most its maximum capacity,
 * it starts at its maximum capacity and flow is subtracted, leaving the remaining capacity.
 * When remaining capacity is at 0 the arc is saturated and cannot be used.
 *
 * A backward arc (B->A) is the opposite of a forward arc (A->B), representing how much flow
 * is already going from A to B and thus how much flow can be removed from A->B.
 * All backward arcs start at 0 (non-existent) and flow is added to them.
 * If used in a path, it acts like a forward arc and its flow is subtracted.
 *)
let update_residual_graph graph path flow =

  let rec loop graph path flow = 
    match path with
    | a :: b :: rest ->
      add_arc (loop graph (b::rest) flow) a b (-flow)   (* Subtract flow from every arc along the path, leaving their remaining capacity *)
    | last :: [] -> graph
    | [] -> graph
  in

  let forward_updated_graph = loop graph path flow in                                 (* Subtract flow from forward arcs *)
  let backward_updated_graph = loop forward_updated_graph (List.rev path) (-flow) in  (* Add flow to their opposite backward arcs *)
  backward_updated_graph


(* Calculate the max flow between the source and the sink
 * on the given graph using the Ford-Fulkerson algorithm.
*)
let get_max_flow graph source sink =

  let rec while_path_exists residual_graph flow =
    match (find_path residual_graph [] source sink) with
    | Some path -> 
      let bottleneck = find_bottleneck path residual_graph in
      let updated_residual_graph = update_residual_graph residual_graph path bottleneck in
      while_path_exists updated_residual_graph (flow + bottleneck) ;
    | None -> flow
  in

  let max_flow = while_path_exists graph 0 in
  max_flow

(* Same as get_max_flow but also creates text and graphviz files of the final graph *)
let get_max_flow_with_output_graph graph source sink outfile =

  let rec while_path_exists residual_graph flow =
    match (find_path residual_graph [] source sink) with
    | Some path -> 
      let bottleneck = find_bottleneck path residual_graph in
      let updated_residual_graph = update_residual_graph residual_graph path bottleneck in
      export "final.gv" (gmap updated_residual_graph string_of_int) ;    (* Export final graph in dot format to visualize with Graphviz *)
      write_file outfile (gmap updated_residual_graph string_of_int) ;   (* Export final graph in text format *)
      while_path_exists updated_residual_graph (flow + bottleneck)
    | None -> flow
  in

  let max_flow = while_path_exists graph 0 in
  max_flow
