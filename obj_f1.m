function [err] =obj_f1(SD,ED,wE)
% SD is simulation data
% ED is experimental data

xE = ED(:,1);
yE = ED(:,2);

[~,ia, ~]=unique(xE);
xE = xE(ia);
yE = yE(ia);

xS = SD(:,1);
yS = SD(:,2);
[~,ia, ~]=unique(xS);

xS = xS(ia);
yS = yS(ia);


ySreduced = interp1(xS,yS,linspace(min(xS),max(xS),2319));
xSreduced = interp1(xS,xS,linspace(min(xS),max(xS),2319));

yE2linear = interp1(xE,yE,xSreduced);
yE2linear(isnan(yE2linear)) = 0;

nd = length(xSreduced);
err = norm(ySreduced-yE2linear)/nd;

% plot(xSreduced, ySreduced,'b-o' ); hold on
% plot(xSreduced, yE2linear,'r-o' )
% legend('Sim','Exp')


%% penalty factor
wS = max(SD(:,1));
if wS < wE
    gamma = (wE/wS)^2;
else
    gamma = (wS/wE)^2;
end
err=err*gamma;


