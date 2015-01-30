function [err] =obj_f2(SD,ED,vE)
% SD is simulation data
% ED is experimental data

xE = ED(:,1);
yE = ED(:,2);

xS = SD(:,1);
yS = SD(:,2);
[~,ia, ~]=unique(xS);

xS = xS(ia);
yS = yS(ia);

% plot(xS,yS,'k-o')


ySreduced = interp1(xS,yS,linspace(min(xS),max(xS),141));
xSreduced = interp1(xS,xS,linspace(min(xS),max(xS),141));

yE2linear = interp1(xE,yE,xSreduced);

nd = length(xSreduced);


err = norm(ySreduced-yE2linear)/nd;


%% penalty factor
vS = max(SD(:,1));
gamma = 1;
% vE
% vS
if vS < vE
    gamma = (vE/vS)^2;
end
err=err*gamma;







