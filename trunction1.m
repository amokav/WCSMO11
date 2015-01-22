function [Pbar_new, Fit_Pbar_new,F_Pbar_new]=trunction1(N,Pbar_new,distance,Fit_Pbar_new,F_Pbar_new,n_elimination)
   for i=1:n_elimination 
    first=0;
    second=0;
    min=1;
        while isequal(first,second)   
            [mm nn]=sort(distance,2);
            [ff hh]=sort(mm,1);
            first=nn(hh(min,2),2);
            second=nn(hh(min+1,2),2);
            min=min+2;
%             shall be deleted
            if min>=length(distance)
            first=1;
            second=2;
            eliminate=round(length(distance)*rand(1));
            if eliminate<1
                eliminate=1;
            end
            end
        end
    eliminate=0;
    for j=3:N
        if mm(first,j)<mm(second,j)
            eliminate=first;
            break
        elseif mm(first,j)>mm(second,j)
            eliminate=second;
            break
        else
            continue
        end
    end
    
    if eliminate==0;
        eliminate=nn(hh(1,2),2);
    end
    
    distance(eliminate,:)=[];
    distance(:,eliminate)=[];
    Pbar_new(eliminate,:)=[];
    Fit_Pbar_new(eliminate,:)=[];
    F_Pbar_new(eliminate,:)=[];
   end
    
    
        