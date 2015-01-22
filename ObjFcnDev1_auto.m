function f1=ObjFcnDev1_auto(filename)
global ScriptDir
expData2 = load([ScriptDir,'\..\ExperimentalData\exp1_res.mat']);
ED1 = expData2.exp1_res;
ED1=[ED1(:,2),ED1(:,1)];
MOD1 = readResultData(filename,0);
nG = length(MOD1);
nplot=ceil(sqrt(nG+1));
wexp=0.1;

figure(1)
for ig = 1:nG
    SDi = [MOD1(ig).strain, MOD1(ig).stress];
    err(ig) = obj_f1(SDi,ED1,wexp,0);
    subplot(nplot,nplot,ig)
    hp = plot(SDi(:,1),SDi(:,2),'-bo',ED1(:,1),ED1(:,2),'-ro');
    set(hp, 'MarkerSize', 2)
    title([err(ig)])
end
subplot(nplot,nplot,ig+1)
KD1 = load([ScriptDir,'\..\ExperimentalData\kent_mod1.mat']);
KD1 = KD1.kent_DCB_data;
hp = plot(KD1(:,1),KD1(:,2),'-bo',ED1(:,1),ED1(:,2),'-ro');
set(hp, 'MarkerSize', 2)
errK = obj_f1(KD1,ED1,wexp,0);
title([errK])
f1=err';






