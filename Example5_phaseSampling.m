clear
clc
close all
I = [];
LG = [];
sampling =0; %um
sampling = 0.5; %um
Parameter.Diameter = 1000;
Parameter.lambda = 0.94;
Parameter.focal_length = 1000;
Parameter.pixel_number = 4001;
[NearField] = PhaseSampling2(Parameter,sampling,1,0);
%%
NearField.u = NearField.u_origin;
z = 1000;
scale = 3;
sampling_number = 41;
[FarField] = FarFieldGenerate(NearField,z,scale,sampling_number);

title ("Pixel = Origin, z="+z+"\mum")
saveas(gcf,"Origin.png")
figure(100)
I = [I;abs(FarField.U((sampling_number)+1,:)).^2];
plot(FarField.x,abs(FarField.U((sampling_number)+1,:)).^2,'o-','MarkerFaceColor','w','linewidth',1)
hold on
LG = [LG "Origin"]
% legend(LG)
goodplot('x (\mum)',"Intensity (a.u.)","z = 1000\mum")
% saveas(gcf,"PSF_Sampling.png")
% save("Origin.mat",'FarField');
%%
A = 3:0.5:3.5;
for i = 1:length(A)
sampling = A(i); %um
Parameter.Diameter = 1000;
Parameter.lambda = 0.94;
Parameter.focal_length = 1000;
Parameter.pixel_number = 4001;
[NearField] = PhaseSampling2(Parameter,sampling,1,0);
saveas(gcf,"Pixel="+sampling+".png")

NearField.u = NearField.u_Sampling;
z = 1000;
scale = 3;
sampling_number = 41;
[FarField] = FarFieldGenerate(NearField,z,scale,sampling_number);
% caxis([0 2.3e7])
title ("Pixel="+sampling+", z="+z+"\mum")
saveas(gcf,"PSF_Sampling="+sampling+".png")

figure(100)
I = [I;abs(FarField.U((sampling_number)+1,:)).^2];
plot(FarField.x,abs(FarField.U((sampling_number)+1,:)).^2,'o-','MarkerFaceColor','w','linewidth',1)
hold on
LG = [LG "Pixel="+sampling+"\mum"]
% legend(LG)
goodplot('x (\mum)',"Intensity (a.u.)","z = 100\mum")
% saveas(gcf,"PSF_Sampling.png")
end
hold off
set(gca, 'YScale', 'log')
x = FarField.x;
save("Data.mat",'x','I')
% %%
% I = [];
% LG = [];
% sampling = 3; %um
% Parameter.Diameter = 1000;
% % Parameter.Diameter = 100;
% Parameter.lambda = 0.94;
% Parameter.focal_length = 1000;
% Parameter.pixel_number = 4001;
% [NearField] = PhaseSampling(Parameter,sampling,0,0);
% [X,Y] = meshgrid(NearField.x,NearField.y);
% filter = X.^2 + Y.^2 < 250^2;
% NearField.u_Sampling = 1*exp(1i*angle(NearField.u_Sampling).*filter);
% Phase_1D = figure();
% set(Phase_1D,'Name','Phase_1D','numberTitle','off','Units','normalized','Position',[0 0.2 0.35 0.62]);
% subplot(2,1,1)
% plot(NearField.x(Parameter.pixel_number:end) , mod(angle(NearField.u_origin(Parameter.pixel_number,(Parameter.pixel_number:end)))/pi,2))
% goodplot("Lens radius (\mum)","Phase (\pi)","Ideal phase")
% subplot(2,1,2)
% plot(NearField.x(Parameter.pixel_number:end),mod(angle(NearField.u_Sampling(Parameter.pixel_number,(Parameter.pixel_number:end)))/pi,2))
% goodplot("Lens radius (\mum)","Phase (\pi)","Sampling = "+sampling+"\mum")
% saveas(gcf,"Phase_Sampling="+sampling+".png")
% %%
% NearField.u = NearField.u_Sampling;
% z = 100;
% scale = 3;
% sampling_number = 51;
% [FarField] = FarFieldGenerate(NearField,z,scale,sampling_number);
% % caxis([0 2.3e7])
% title ("Pixel="+sampling+", z="+z+"\mum")
% saveas(gcf,"Filter_Sampling="+sampling+".png")
% %%
% figure(100)
% I = [I;abs(FarField.U((sampling_number-1)/2+1,:)).^2];
% plot(FarField.x,abs(FarField.U((sampling_number-1)/2+1,:)).^2,'linewidth',1)
% hold on
% LG = [LG "D500_Pixel="+sampling+"\mum"]
% legend(LG)
% goodplot('x (\mum)',"Intensity (a.u.)","z = 100\mum")
% saveas(gcf,"PSF_Sampling.png")