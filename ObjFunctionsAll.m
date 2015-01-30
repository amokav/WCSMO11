
nF = 40*(14+14);
F1 = zeros(nF,1);
F2 = zeros(nF,1);
c = 1;
wexp=0.1;
for ig = 109:122
    for ip = 1:40
        SD1 = [SimData(ig).SDi(ip).MOD1];
        F1(c) = obj_f1(SD1,ED1,wexp);
        c = c+1;
    end  
end
for ig = 109:122
    for ip = 1:40
        SD1 = [SimDataElite(ig).SDi(ip).MOD1];
        F1(c) = obj_f1(SD1,ED1,wexp);
        c = c+1;
    end  
end

c = 1;
for ig = 109:122
    for ip = 1:40
        SD1 = [SimData(ig).SDi(ip).MOD2];
        F2(c) = obj_f1(SD1,ED1,wexp);
        c = c+1;
    end  
end
for ig = 109:122
    for ip = 1:40
        SD1 = [SimDataElite(ig).SDi(ip).MOD2];
        F2(c) = obj_f1(SD1,ED1,wexp);
        c = c+1;
    end  
end

[F1,F2]

save('ObjectiveFunctions','F1','F2')
