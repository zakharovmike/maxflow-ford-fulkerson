open Gfile
open Tools
open Ford_fulkerson_algorithm

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and source = int_of_string Sys.argv.(2)
  and sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in

  (* Export initial graph in dot format to visualize with Graphviz *)
  let () = export "initial.gv" graph in

  (* Convert to int graph and find its max flow from source to sink *)
  let int_graph = gmap graph int_of_string in
  let flow = get_max_flow_with_output_graph int_graph source sink outfile in
  Printf.printf "\nmax flow from %d to %d: %d\n%!" source sink flow ;

  ()

