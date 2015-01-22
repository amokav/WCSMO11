function [err] =obj_f1(SD,ED,wexp,viz)
% SD is simulation data
% ED is experimental data
% viz = 1 to visualize
%wexp is the length of experimantal data

if viz
%     figure;
%     plot(SD(:,1),SD(:,2),'b-o',ED(:,1),ED(:,2),'r-o')
%     hold on
end

nExp = size(ED,1);

nSD = size(SD,1);
fExp = zeros(nSD,1);
for i = 1:nSD
    iS = SD(i,1);
    dS = iS(ones(nExp,1),:);
    D = dS-ED(:,1);
    [~,mind] = min(abs(D));
    fExp(i) = ED(mind,2);
%     hold on;
    
    if viz
%         iSD = [SD(i,1), SD(i,2)];
%         iED = [ED(mind,1),ED(mind,2)];
%         hp1 = plot(iED(1),iED(2),'*');
%         hp2 = plot(iSD(1),iSD(2),'o','MarkerFaceColor','y');
%         hp3 = plot([iED(1),iSD(1)],[iED(2),iSD(2)],'k-');
    end
end

fSim = SD(:,2);

ERR=abs(fExp-fSim);
err = norm(ERR);


%% penalty factor
wsim = max(SD(:,1));
if wsim < wexp
    gamma = ((wexp/wsim)*10)^2;
else
    gamma = ((wsim/wexp)*10)^2;
end
err=err*gamma;

