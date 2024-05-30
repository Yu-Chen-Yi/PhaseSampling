clear
clc
close all
sap = 0.5:0.5:4.5;
I = [];
color = fliplr(jet(length(sap)));
LG = [];
for i = 1:length(sap)
sampling = sap(i); %um
Parameter.Diameter = 100;
Parameter.lambda = 0.94;
Parameter.focal_length = 100;
Parameter.pixel_number = 401;
[NearField] = PhaseSampling(Parameter,sampling,1,0);
saveas(gcf,"Phase_Sampling="+sampling+".png")
%%
NearField.u = NearField.u_Sampling;
z = 100;
scale = 3;
sampling_number = 101;
[FarField] = FarFieldGenerate(NearField,z,scale,sampling_number);
caxis([0 2.3e7])
title ("Pixel="+sampling+", z="+z+"\mum")
saveas(gcf,"Sampling="+sampling+".png")
figure(100)
I = [I;abs(FarField.U((sampling_number-1)/2+1,:)).^2];
plot(FarField.x,abs(FarField.U((sampling_number-1)/2+1,:)).^2,'linewidth',1,'color',color(i,:))
hold on
LG = [LG "Pixel="+sampling+"\mum"]
end
legend(LG)
goodplot('x (\mum)',"Intensity (a.u.)","z = 100\mum")
saveas(gcf,"PSF_Sampling.png")
% %%
% NearField.u = NearField.u_Sampling;
% z = [];
% z = [z 10:10:50];
% z = [z 55:5:70];
% z = [z 72:2:90];
% z = [z 91:1:110];
% z = [z 112:2:170];
% scale = 15;
% sampling_number = 101;
% [FarField] = XZ_FarFieldGenerate(NearField,z,scale,sampling_number);
% %%
% NearField.u = NearField.u_origin;
% z = 100;
% scale = 3;
% sampling_number = 101;
% [FarField] = FarFieldGenerate(NearField,z,scale,sampling_number);
% %%
% NearField.u = NearField.u_origin;
% z = [];
% z = [z 10:10:50];
% z = [z 55:5:70];
% z = [z 72:2:90];
% z = [z 91:1:110];
% z = [z 112:5:250];
% scale = 15;
% sampling_number = 51;
% [FarField] = XZ_FarFieldGenerate(NearField,z,scale,sampling_number);