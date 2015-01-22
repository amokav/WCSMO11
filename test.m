clear
disp('Do stuff')
scriptPath = mfilename('fullpath');
[ScriptDir,ScriptName,ScriptExt] = fileparts(scriptPath);
dataFile = [ScriptDir,'\..\CurrentRun\Results\data.txt']

fid = fopen(dataFile);
tline = fgetl(fid);
line = 0;
while ischar(tline)
    disp(tline)
    line = line +1;
    tline = fgetl(fid);
end
fclose(fid);
disp([num2str(line),' lines read.'])

exit