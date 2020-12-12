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

let find_path graph forbidden_nodes source sink =
  let rec dfs visited node = 
    if node = sink then Some empty_path else
    let neighbors = List.filter 
      (fun (node, lbl) -> not (List.mem node visited) && lbl != 0) 
      (out_arcs graph node)
    in
    match neighbors with
    | [] -> None
    | (next, _) :: rest ->
      match dfs (next::visited) next with
      | None -> dfs (next::visited) node
      | Some path -> Some (next :: path)
  in
  match dfs forbidden_nodes source with
  | Some path -> Some (source :: path)
  | None -> None

let find_bottleneck path graph =
  let rec loop path graph bottleneck =
    match path with
    | a :: b :: rest -> 
      min 
      (loop (b::rest) graph (abs (Option.get (find_arc graph a b)))) 
      bottleneck
    | last :: rest -> bottleneck
    | [] -> bottleneck
  in
  loop path graph Int.max_int

let update_residual_graph graph path bottleneck =
  let rec loop graph path bottleneck = 
    match path with
    | a :: b :: rest ->
      add_arc (loop graph (b::rest) bottleneck) a b (-bottleneck)
    | last :: [] -> graph
    | [] -> graph
  in
  let forward_updated_graph = loop graph path bottleneck in
  let backward_updated_graph = loop forward_updated_graph (List.rev path) (-bottleneck) in
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
      while_path_exists updated_residual_graph (flow + bottleneck)
    | None -> flow
   in
   let max_flow = while_path_exists graph 0 in
   max_flow
