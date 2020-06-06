function [best_result, best_nodes] = Grasp(G,n,r,time)
    t = tic;
    [init_nodes] = GreedyRandomized(G,n,r);   
    [best_result, best_nodes] = ConnP_SAHC(G,n,init_nodes,time-toc(t));
    %[best_result, best_nodes] = ConnP_SAHC2(G,n,init_nodes,time-toc(t));
    %[best_result, best_nodes] = ConnP_HC(G,n,init_nodes,time/10);
    result = inf;
    nodes = [];
    while toc(t) < time
        nodes = GreedyRandomized(G,n,r);
        [result, nodes] = ConnP_SAHC(G,n,nodes,time-toc(t));
        %[result, nodes] = ConnP_SAHC2(G,n,nodes,time-toc(t));
        %[result, nodes] = ConnP_HC(G,n,nodes,time/10);
        if (result < best_result)
            best_result = result;
            best_nodes = nodes;
        end
    end
end

function [result_nodes] = GreedyRandomized(G, n, r)
    E = 1:numnodes(G);
    result_nodes = [];
    for i = 1:n
        R = [];
        for j = E
            R = [R; j ConnectedNP(G, [result_nodes j])];
        end
        R = sortrows(R,2, 'MissingPlacement', 'last');
        e = R(randi(r),1);
        result_nodes = [result_nodes e];
        E = setdiff(E,e);
    end
end