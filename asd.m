scriptPath = mfilename('fullpath');
[Sdir,~,~] = fileparts(scriptPath);
ScriptDir = Sdir;
expData1 = load([ScriptDir,'\..\ExperimentalData\exp1_res.mat']);
ED1 = expData1.exp1_res;
expData2 = load([ScriptDir,'\..\ExperimentalData\exp2_res.mat']);
ED2 = expData2.exp2_res;
ED1=[ED1(:,2),ED1(:,1)];
