open Graph

(* Clone nodes by iterating on a graph's nodes and adding them to a new empty graph. *)
let clone_nodes gr = n_fold gr (fun acc_gr id -> new_node acc_gr id) empty_graph

(* Map on all of a graph's arcs with the provided function f and 
 * copy them into a new graph that contains only the nodes of the original graph. *)
let gmap gr f = e_fold 
    gr 
    (fun acc_gr id1 id2 lbl -> new_arc acc_gr id1 id2 (f lbl)) 
    (clone_nodes gr)

let add_arc gr id1 id2 lbl = 
  let existing_arc_label = find_arc gr id1 id2 in

  match existing_arc_label with
  | Some v -> new_arc gr id1 id2 (v + lbl)
  | None -> new_arc gr id1 id2 lbl
