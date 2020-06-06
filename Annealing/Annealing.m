function [best_result, best_nodes] = Annealing(G,n,time,p0,pF)
    t = tic;
    nNodes = numnodes(G);
    diff_sum = 0;
    for x = 1:100
        nodes = randperm(nNodes,n); 
        result = ConnectedNP(G,nodes);
        others = setdiff(1:nNodes,nodes);
        neig_nodes = [nodes(randperm(n,n-1)) others(randperm(nNodes-n,1))];   
        neig_result = ConnectedNP(G,neig_nodes);
        diff_sum = diff_sum + abs(result - neig_result);
    end
    diff_avg = diff_sum / 100;
        
    [nodes, best_nodes] = deal(randperm(nNodes,n)); 
    [result, best_result] = deal(ConnectedNP(G,nodes));
    
    temp = (-diff_avg) / log(p0);
    tempF = (-diff_avg) / log(pF);
    alpha = (temp-tempF) / time;
    counter = 0;
    counter_better = 0;
    counter_accept = 0;
    counter_nonaccept = 0;
    
    while toc(t) < time
        others = setdiff(1:nNodes,nodes);
        neig_nodes = [nodes(randperm(n,n-1)) others(randperm(nNodes-n,1))];   
        neig_result = ConnectedNP(G,neig_nodes);
        if result > neig_result
            result = neig_result;
            nodes = neig_nodes;
            if result < best_result
               best_result = result;
               best_nodes = nodes;
            end
            counter_better = counter_better + 1;
        elseif rand() < exp((result - neig_result)/temp)
            result = neig_result;
            nodes = neig_nodes;
            counter_accept = counter_accept + 1;
        else
            counter_nonaccept = counter_nonaccept + 1;
        end  
        temp = tempF + (alpha * (time-toc(t)));
        counter = counter + 1;
    end
    counter  
    counter_better
    counter_accept
    counter_nonaccept
end