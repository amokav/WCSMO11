function F=CalcObj(nfilMOD1,nfilMOD2,viz)
global ScriptDir


% delete([ScriptDir,'\..\CurrentRun\Results\Results_Data_MOD1_combine.txt'])
% delete([ScriptDir,'\..\CurrentRun\Results\Results_Data_MOD2_combine.txt'])
for i=1:nfilMOD1
%     filename=[ScriptDir,'\..\CurrentRun\Results\Results_Data_MOD1_', num2str(i), '.txt'];
%     fid = fopen(filename);
%     F = fileread(filename);
%     fclose(fid);
%     Results_Data_MOD2_comb= fopen([ScriptDir,'\..\CurrentRun\Results\Results_Data_MOD1_combine.txt'], 'a+');
%     fprintf(Results_Data_MOD2_comb,F);
%     fclose(Results_Data_MOD2_comb);
filenameMOD1=[ScriptDir,'\..\CurrentRun\Results\Results_Data_MOD1_', num2str(i), '.txt'];
f1(i)=ObjFcnDev1_1genperfil_auto(filenameMOD1,viz);
end

% filenameMOD1=[ScriptDir,'\..\CurrentRun\Results\Results_Data_MOD1_combine.txt'];
% f1=ObjFcnDev1_auto(filenameMOD1);

for i=1:nfilMOD2
%     filename=[ScriptDir,'\..\CurrentRun\Results\Results_Data_MOD2_', num2str(i), '.txt'];
%     fid = fopen(filename);
%     F = fileread(filename);
%     fclose(fid);
%     Results_Data_MOD2_comb= fopen([ScriptDir,'\..\CurrentRun\Results\Results_Data_MOD2_combine.txt'], 'a+');
%     fprintf(Results_Data_MOD2_comb,F);
%     fclose(Results_Data_MOD2_comb);
filenameMOD2=[ScriptDir,'\..\CurrentRun\Results\Results_Data_MOD2_', num2str(i), '.txt'];
f2(i)=ObjFcnDev2_1genperfil_auto(filenameMOD2,viz);
end
% filenameMOD2=[ScriptDir,'\..\CurrentRun\Results\Results_Data_MOD2_combine.txt'];
% f2=ObjFcnDev2_auto(filenameMOD2);
F=[f1',f2'];






