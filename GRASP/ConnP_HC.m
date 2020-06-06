function [result, result_nodes] = ConnP_HC(G,n,start_nodes,time)
    t = tic;
    result = inf;
    nNodes = numnodes(G);
    result_nodes = start_nodes;
    counter = 0;

    while toc(t) < time
        others= setdiff(1:nNodes,result_nodes);
        D = [result_nodes(randperm(n,n-1)) others(randperm(nNodes-n,1))];
        ConNP = ConnectedNP(G,D);
        if (ConNP < result)
            result_nodes = D;
            result = ConNP; 
        end
        counter = counter + 1;
    end
end

