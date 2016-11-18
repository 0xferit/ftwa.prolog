:- use_module(plGraphViz).

export_graph_to_gv_file(
     graph([vertex(1,[]),vertex(2,[])],[edge(1,2,[])],[]),
     File,
     [method(sfdp),output(png)]
   ).
   File = 'PATH/plGraphViz/data/tmp.png'
