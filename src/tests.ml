open OUnit2
open Gfile
open Tools
open Ford_fulkerson_algorithm

(* Graphs from: https://www-m9.ma.tum.de/graph-algorithms/flow-ford-fulkerson/index_en.html *)
let graph1 = from_file "graphs/graph1" (* european capitals *)
let graph2 = from_file "graphs/graph2" (* corman rotated *)
let graph3 = from_file "graphs/graph3" (* graph 2 *)
let graph4 = from_file "graphs/graph4" (* c1 *)


let int_graph1 = gmap graph1 int_of_string 
let int_graph2 = gmap graph2 int_of_string 
let int_graph3 = gmap graph3 int_of_string 
let int_graph4 = gmap graph4 int_of_string 

let test_graph1_1 _ = OUnit2.assert_equal 25 (get_max_flow int_graph1 0 5)
let test_graph1_2 _ = OUnit2.assert_equal 16 (get_max_flow int_graph1 0 4)
let test_graph1_3 _ = OUnit2.assert_equal 10 (get_max_flow int_graph1 0 3)
let test_graph1_4 _ = OUnit2.assert_equal 0 (get_max_flow int_graph1 1 2)

let test_graph2_1 _ = OUnit2.assert_equal 23 (get_max_flow int_graph2 0 5)
let test_graph2_2 _ = OUnit2.assert_equal 14 (get_max_flow int_graph2 0 4)
let test_graph2_3 _ = OUnit2.assert_equal 19 (get_max_flow int_graph2 0 3)

let test_graph3_1 _ = OUnit2.assert_equal 7 (get_max_flow int_graph3 0 5)
let test_graph3_3 _ = OUnit2.assert_equal 5 (get_max_flow int_graph3 0 3)

let test_graph4_1 _ = OUnit2.assert_equal 31 (get_max_flow int_graph4 0 7)
let test_graph4_2 _ = OUnit2.assert_equal 23 (get_max_flow int_graph4 0 6)
let test_graph4_3 _ = OUnit2.assert_equal 32 (get_max_flow int_graph4 0 4)
let test_graph4_4 _ = OUnit2.assert_equal 21 (get_max_flow int_graph4 0 3)
let test_graph4_5 _ = OUnit2.assert_equal 38 (get_max_flow int_graph4 0 1)
let test_graph4_6 _ = OUnit2.assert_equal 9 (get_max_flow int_graph4 2 5)
let test_graph4_7 _ = OUnit2.assert_equal 26 (get_max_flow int_graph4 2 7)
let test_graph4_8 _ = OUnit2.assert_equal 0 (get_max_flow int_graph4 3 1)

let suite = 
  "max flows">:::
  [
    "graph1 :: 0 -> 5">:: test_graph1_1;
    "graph1 :: 0 -> 4">:: test_graph1_2;
    "graph1 :: 0 -> 3">:: test_graph1_3;
    "graph1 :: 1 -> 2">:: test_graph1_4;

    "graph2 :: 0 -> 5">:: test_graph2_1;
    "graph2 :: 0 -> 4">:: test_graph2_2;
    "graph2 :: 0 -> 3">:: test_graph2_3;

    "graph3 :: 0 -> 5">:: test_graph3_1;
    "graph3 :: 0 -> 3">:: test_graph3_3;

    "graph4 :: 0 -> 7">:: test_graph4_1;
    "graph4 :: 0 -> 6">:: test_graph4_2;
    "graph4 :: 0 -> 4">:: test_graph4_3;
    "graph4 :: 0 -> 3">:: test_graph4_4;
    "graph4 :: 0 -> 1">:: test_graph4_5;
    "graph4 :: 2 -> 5">:: test_graph4_6;
    "graph4 :: 2 -> 7">:: test_graph4_7;
    "graph4 :: 3 -> 1">:: test_graph4_8;
  ]

let _ = run_test_tt_main suite

