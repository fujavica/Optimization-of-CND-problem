function [result result_nodes] = ConnP_SAHC2(G,n,result_nodes,time)
    t= tic;
    result= ConnectedNP(G,result_nodes);
    improved= true;
    counter= 0;
    while improved && toc(t) < time
        best_neig= [];
        value_best_neig= inf;
        for a= result_nodes
            aux= setdiff(neighbors(G,a)',result_nodes);
            for b= aux
                neig= [setdiff(result_nodes,a) b];
                value_neig= ConnectedNP(G,neig);
                if value_neig<value_best_neig
                    best_neig= neig;
                    value_best_neig= value_neig;
                end
            end
        end
        if value_best_neig < result
            result= value_best_neig;
            result_nodes= best_neig;
        else
            improved= false;
        end
        counter= counter + 1;
    end
    counter;
end