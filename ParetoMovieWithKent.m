clc
clear
close all
%%
scriptPath = mfilename('fullpath');
[Sdir,~,~] = fileparts(scriptPath);
global ScriptDir
ScriptDir = Sdir;
%%
load([ScriptDir,'\..\Results\archive.mat'],'archive','init','F_archive','F_total','P_total','number_of_ND','F_min','F_max')
n_archive=size(init,2);
P_init=init(n_archive).P_init;
P_bar=archive(n_archive).P_bar;
F_Pbar_new=F_archive(n_archive).F_Pbar_new;

%%
par=figure();

set(par,'PaperSize',[100 50])
writerobj=VideoWriter('Pareto.avi','Motion JPEG AVI' );
writerobj.FrameRate=4;
writerobj.Quality = 100;
img = imread('kent.jpg');
open(writerobj)

%%pause
for i=1:n_archive
    P_init=init(i).P_init;
    P_bar=archive(i).P_bar;
    F_Pbar_new=F_archive(i).F_Pbar_new;
    kent_info =find(P_bar(:,1)==50 & P_bar(:,2)==0.31);
    hold on
    if i == 1
       
        Pareto=plot(F_Pbar_new(:,1),F_Pbar_new(:,2),'*','linewidth',1.5,'markeredgecolor','r','markersize',5);
        xlabel('f1');
        ylabel('f2');
        set(1,'Position',[75          78        1282         872]);
     
        
        axis([1500,4000,0,500])
        
        writeVideo(writerobj,getframe(1))
    end
    %%
    newplot
    %image([(F_Pbar_new(kent_info,1)-0.13e4),F_Pbar_new(kent_info,1)],[F_Pbar_new(kent_info,2),(F_Pbar_new(kent_info,2)-28)],img);
    set(Pareto,'XData',F_Pbar_new(1:21,1),'YData',F_Pbar_new(1:21,2))
    title(['MOOP Project -Iteration: ',num2str(i)])
    
    
     %fr(Counter)=getframe;
    writeVideo(writerobj,getframe(1))
    F_Pbar_new=[];
    P_init=[];
    P_bar=[];
    kent_info=[];
    hold off
%      pause
end
close(writerobj)
% pause
% movie(fr)
winopen('Pareto.avi')
