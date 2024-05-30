clear
clc
close all
I = [];
LG = [];
Parameter.sampling = 0.4; %um
Parameter.Diameter = 100;
Parameter.lambda = 0.94;
Parameter.focal_length = 100;
Parameter.pixel_number = 401;
Parameter.imageshow1 = 1;
Parameter.imageshow2 = 1;
[NearField] = PhaseSampling(Parameter);
% saveas(gcf,"Phase_Sampling="+sampling+".png")
%%
NearField.u = NearField.u_Sampling;
z = 100;
scale = 3;
sampling_number = 51;
[FarField] = FarFieldGenerate(NearField,z,scale,sampling_number);
% caxis([0 2.3e7])
title ("Pixel="+sampling+", z="+z+"\mum")
% saveas(gcf,"Sampling="+sampling+".png")
%%
figure(100)
I = [I;abs(FarField.U((sampling_number-1)/2+1,:)).^2];
plot(FarField.x,abs(FarField.U((sampling_number-1)/2+1,:)).^2,'linewidth',1)
hold on
LG = [LG "Pixel="+sampling+"\mum"];
legend(LG)
goodplot('x (\mum)',"Intensity (a.u.)","z = 100\mum")
% saveas(gcf,"PSF_Sampling.png")