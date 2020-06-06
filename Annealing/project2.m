Nodes = load('Nodes2.txt');
Links = load('Links2.txt');
L = load('L2.txt');
nNodes = size(Nodes,1);
nLinks = size(Links,1);
G = graph(L);
time = 300;

for i = 1:10
    n = 14
    p0 = 0.7
    pF = 0.01
    [result, result_nodes] = Annealing(G, n, time, p0, pF);
    result
    result_nodes
end

