clc
clear
close all
%%
scriptPath = mfilename('fullpath');
[Sdir,~,~] = fileparts(scriptPath);
global ScriptDir
ScriptDir = Sdir;
%%
load([ScriptDir,'\..\Results\archive.mat'],'archive','init','F_archive','F_total','P_total','number_of_ND','SimData','F_min','F_max')
n_archive=size(init,2);
P_init=init(n_archive).P_init;
P_bar=archive(n_archive).P_bar;
F_Pbar_new=F_archive(n_archive).F_Pbar_new;

%%
par=figure();

set(par,'PaperSize',[100 50])
writerobj=VideoWriter('Pareto2.avi','Motion JPEG AVI' );
writerobj.FrameRate=4;
writerobj.Quality = 100;
img = imread('kent.jpg');
open(writerobj)

%%pause
dx = 15; dy = 2;
for i=1:n_archive
    P_init=init(i).P_init;
    P_bar=archive(i).P_bar;
    F_Pbar_new=F_archive(i).F_Pbar_new;
    kent_info =find(P_bar(:,1)==50 & P_bar(:,2)==0.31);
    hold on
    other_points = setdiff(1:number_of_ND(n_archive).nd_counter,kent_info);
    no = length(other_points);
    
    if i == 1
       
        Pareto1=plot(F_Pbar_new(other_points,1),F_Pbar_new(other_points,2),'bo','linewidth',1.5,'markersize',3,'MarkerFaceColor','b');

        Pareto2=plot(F_Pbar_new(kent_info,1),F_Pbar_new(kent_info,2),'ro','linewidth',1.5,'markersize',3,'MarkerFaceColor','r');
        %PLabel2 = text(F_Pbar_new(kent_info,1)+dx,F_Pbar_new(kent_info,2)+dy, num2str(kent_info));
        xlabel('f1');
        ylabel('f2');
        set(1,'Position',[75          78        1282         872]);
     
        
        axis([1500,4000,0,500])
        
        writeVideo(writerobj,getframe(1))
    end
    %%
    try
        delete(PLabel1)
        delete(PLabel2)
    end
    PLabel1 = zeros(no,1);
    
    PLabel2=0;
    
    for j = 1:no
       PLabel1(j) = text(F_Pbar_new(other_points(j),1)+dx,F_Pbar_new(other_points(j),2)+dy, num2str(other_points(j)),'Fontsize',10) ;
    end
    PLabel2 = text(F_Pbar_new(kent_info,1)+dx,F_Pbar_new(kent_info,2)+dy, num2str(kent_info));    
    newplot
    %image([(F_Pbar_new(kent_info,1)-0.13e4),F_Pbar_new(kent_info,1)],[F_Pbar_new(kent_info,2),(F_Pbar_new(kent_info,2)-28)],img);
    title(['MOOP Project -Iteration: ',num2str(i)])
    
    Pareto1.XData = F_Pbar_new(other_points,1);
    Pareto1.YData = F_Pbar_new(other_points,2);
    
    
    
    Pareto2.XData = F_Pbar_new(kent_info,1);
    Pareto2.YData = F_Pbar_new(kent_info,2);
    
    
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
winopen('Pareto2.avi')
