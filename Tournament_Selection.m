% Pbar_new=[3 2;1 3;4 5;2 4;3 1;4 5];
% Fit_Pbar_new=[
% N_bar+
%     pool_size=N_bar;
%     tour_size=2;
%     population_selection=Pbar_new;
%     Fit=Fit_Pbar_new;

function mating_pool=Tournament_Selection(population_selection,pool_size,tour_size,Fit)
[pop_size n_variable]=size(population_selection);
mating_pool=[];
for i=1:pool_size
    
    for j=1:tour_size
        
% Select an individual at random
        candid(j) = round(pop_size*rand(1));
        % Make sure that the array starts from one.
        if candid(j) == 0
            candid(j) = 1;
        end
        if j > 1
            % Make sure that same candidate is not choosen.
            while ~isempty(find(candid(1 : j - 1) == candid(j), 1))
                candid(j) = round(pop_size*rand(1));
                if candid(j) == 0
                    candid(j) = 1;
                end
            end
        end
    end
    
    for j=1:tour_size
        Fit_candid(j)=Fit(candid(j));
    end
    
    min_candid=find(Fit_candid==min(Fit_candid));
    mating_pool(i,:)=population_selection(candid(min_candid(1)),:);
end
        