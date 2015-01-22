function children=genetic_operator(parent,N,N_bar,M,xU,xL)
pp=1;
    cross_prob=0.8;% 0.7453;%0.7722;
    mutation_prob=0.2;%0.0778;
    eta_crossover= 10;%6.5824;%24.9758;
    eta_mutation=10;%69.8100;%92.3575;
    was_crossover = 0;
    was_mutation = 0;
   % parent= mating_pool;
    
    while pp<=N_bar
        
        if rand(1)<cross_prob
            
            child1=[];
            child2=[];
            
            parent_1=round(N_bar*rand(1));
            if parent_1 < 1
            parent_1 = 1;
            end 
            
            parent_2=round(N_bar*rand(1));
            if parent_2 < 1
                parent_2 = 1;
            end
            
            while isequal(parent(parent_1,:),parent(parent_2,:))
                parent_2=round(N_bar*rand(1));
                if parent_2 < 1
                parent_2 = 1;
                end
            end
            
                parent_1=parent(parent_1,:);
                parent_2=parent(parent_2,:);
                
            for j=1:M
                
                    u(j) = rand(1);
                if u(j) <= 0.5
                    bq(j) = (2*u(j))^(1/(eta_crossover+1));
                else
                    bq(j) = (1/(2*(1 - u(j))))^(1/(eta_crossover+1));
                end
                % Generate the jth element of first child
                child1(j) = ...
                    0.5*(((1 + bq(j))*parent_1(j)) + (1 - bq(j))*parent_2(j));
                % Generate the jth element of second child
                child2(j) = ...
                    0.5*(((1 - bq(j))*parent_1(j)) + (1 + bq(j))*parent_2(j));
                
                
                
                 
           % [child1, child2]=mSBX(eta_crossover,parent_1,parent_2);
            
            
                if child1(j) > xU(j)
                    child1(j) = xU(j);
                elseif child1(j) < xL(j)
                    child1(j) = xL(j);
                end
                if child2(j) > xU(j)
                    child2(j) = xU(j);
                elseif child2(j) < xL(j)
                    child2(j) = xL(j);
                end
                
                %child1(j)=child1;
                %child2(j)=child2;
                
            end
            
            was_crossover = 1;
            was_mutation = 0;
        else
         
            parent_3=round(N_bar*rand(1));
            if parent_3 < 1
            parent_3 = 1;
            end 
            
            for j = 1 : M
               r(j) = rand(1);
               if r(j) < 0.5
                   delta(j) = (2*r(j))^(1/(eta_mutation+1)) - 1;
               else
                   delta(j) = 1 - (2*(1 - r(j)))^(1/(eta_mutation+1));
               end

               child3(j) = parent(parent_3,j) + delta(j);

               if child3(j) > xU(j)
                   child3(j) = xU(j);
               elseif child3(j) < xL(j)
                   child3(j) = xL(j);
               end
             end
           
            was_mutation = 1;
            was_crossover = 0;
       end
        
        
        if was_crossover
        child(pp,:) = child1;
        child(pp+1,:) = child2;
        was_cossover = 0;
        pp = pp + 2;
    elseif was_mutation
        child(pp,:) = child3;
        was_mutation = 0;
        pp = pp + 1;
        end
    end
 children=child;
