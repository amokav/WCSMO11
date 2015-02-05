clear
clc
close all
scriptPath = mfilename('fullpath');
[Sdir,~,~] = fileparts(scriptPath);
global ScriptDir
ScriptDir = Sdir;
expData1 = load([ScriptDir,'\..\ExperimentalData\exp1_res.mat']);
ED1 = expData1.exp1_res;
expData2 = load([ScriptDir,'\..\ExperimentalData\exp2_res.mat']);
ED2 = expData2.exp2_res;
ED1=[ED1(:,2),ED1(:,1)];
% ED2=[ED2(:,2),ED2(:,1)];
load([ScriptDir,'\..\Results\archiveMOD2penaltyNot ConsideredGen4'])%,'archive','init','F_archive','F_total','P_total','number_of_ND','SimData','F_min','F_max')
%load('data2')
load([ScriptDir,'\..\Results\KentInfo.mat'])
gen=size(init,2);
nDoE=number_of_ND(gen).nd_counter;
nplot=5%ceil(sqrt(nDoE));
F_Pbar_new=F_archive(gen).F_Pbar_new;
wexp=0.1;
xfigure(1)
for i= 1:nDoE
    SD1 = [SimDataElite(gen).SDi(i).MOD1];
    err1(i) =obj_f1(SD1,ED1,wexp);
    subplot(nplot,nplot,i)
    hp1 = plot(SD1(:,1),SD1(:,2),'-bo',ED1(:,1),ED1(:,2),'-ro');
    set(hp1, 'MarkerSize', 2)
    title([err1(i)])

end
subplot(nplot,nplot,i+1)
SDkent1=SDKent.MOD1;
errK1 =obj_f1(SDkent1,ED1,wexp);
hpkent1=plot(SDkent1(:,1),SDkent1(:,2),'-bo',ED1(:,1),ED1(:,2),'-ro');
set(hpkent1, 'MarkerSize', 2)
title(errK1)
%% Mod2
xfigure(2)
err2 = [];
vexp = 0.07;
for i= 1:nDoE
    SD2 = [SimDataElite(gen).SDi(i).MOD2];
    err2(i) = obj_f2(SD2,ED2,vexp);
    
    subplot(nplot,nplot,i)
    hp2 = plot(SD2(:,1),SD2(:,2),'-bo',ED2(:,1),ED2(:,2),'-ro');
    set(hp2, 'MarkerSize', 2)
    title(err2(i))

end

% load('data2')
subplot(nplot,nplot,i+1)
 %load([ScriptDir,'\..\ExperimentalData\kent_mod2.mat']);
 %SDkent2=fem_enf_data;
SDkent2=SDKent.MOD2;
errK2 = obj_f2(SDkent2,ED2,vexp);
hpkent2=plot(SDkent2(:,1),SDkent2(:,2),'-bo',ED2(:,1),ED2(:,2),'-ro');
set(hpkent2, 'MarkerSize', 2)
title(errK2)
