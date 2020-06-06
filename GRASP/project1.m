Nodes = load('Nodes2.txt');
Links = load('Links2.txt');
L = load('L2.txt');
nNodes = size(Nodes,1);
nLinks = size(Links,1);
G = graph(L);
time = 300;

n = 14
for i = 1:10
    r = 2
    [result, result_nodes] = Grasp(G, n, r, time);
    result
    result_nodes
end
