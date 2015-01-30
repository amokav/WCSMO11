clear all
close all
clc

scriptPath = mfilename('fullpath');
[Sdir,~,~] = fileparts(scriptPath);
global ScriptDir 
ScriptDir = Sdir;

expData2 = load([ScriptDir,'\..\..\ExperimentalData\exp2_res.mat']);
ED2 = expData2.exp2_res;

load([ScriptDir,'\..\..\Results\archive.mat'])%,'archive','init','F_archive','F_total','P_total','number_of_ND','SimData','F_min','F_max')


gen=size(init,2);
nDoE=number_of_ND(gen).nd_counter;
nplot=ceil(sqrt(nDoE+1));
wexp=0.1;


for i= 1:length(SimDataElite(gen).SDi)
    x1=SimDataElite(gen).SDi(i).MOD2(:,1);
    y1=SimDataElite(gen).SDi(i).MOD2(:,2);

    err1 = obj_f2([x1,y1],ED2)

end
