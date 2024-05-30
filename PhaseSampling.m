function [NearField] = PhaseSampling(Parameter)
if Parameter.sampling ==0
   check_point = 1;
   Parameter.sampling =0.5;
else
   check_point = 0;
end
D = Parameter.Diameter;
lambda = Parameter.lambda;
f = Parameter.focal_length;
x = linspace(0,D/2,Parameter.pixel_number);
y = x;
number = 2*Parameter.sampling/(Parameter.Diameter/(Parameter.pixel_number-1));
pixel = x(2) - x(1);
% number = 10;
bar = pixel*number;
[X,Y] = meshgrid(x,y);
filter = X.^2+Y.^2 < (D/2).^2;
ideal_phase = -2*pi/lambda * (sqrt(x.^2 + f^2)-f);
sawtooth_phase = ideal_phase;
origin_phase = ideal_phase;
ideal_phase(1:number/2) = sum(ideal_phase(1:number/2))/length(ideal_phase(1:number/2));
i = 0;
while number/2+1+number*(i) < length(ideal_phase)
a = number/2+1+number*i;
b = number/2+1+number*(i+1);
if b > length(ideal_phase)
    ideal_phase(a:end) = ideal_phase(round((a+end)/2));
    break
else
ideal_phase(a:b) = ideal_phase(round((a+b)/2));
end
i = i + 1;
end
if Parameter.imageshow1 ==1
Phase_1D = figure(1);
goodfigure('','w',[0 0.6 0.6 0.35])
% subplot(2,1,1)
% plot(x,mod(origin_phase/pi,2))
% goodplot("Lens radius (\mum)","Phase (\pi)","Ideal phase")
% subplot(2,1,2)
plot(x,mod(sawtooth_phase/pi - 1e-10,2),'color','k','linewidth',2)
hold on
if check_point==1
    bar = 0;
    plot(x,mod(origin_phase/pi,2),'color','r','linewidth',3)
else
    plot(x,mod(ideal_phase/pi,2),'color','r','linewidth',3)
end
hold off
goodplot2("\itLens radius (\mum)","\itPhase (\pi)","\Lambdag = "+bar+"\mum",18)
end
bar = pixel*number;
[X,Y] = meshgrid(x,y);
filter = X.^2+Y.^2 < (D/2).^2;
ideal_phase2 = -2*pi/lambda * (sqrt(X.^2 + Y.^2 + f^2)-f);
origin_phase = ideal_phase2;
n = ((length(x)-number/2)-1)/number;
% ideal_phase(1:number/2) = sum(ideal_phase(1:number/2))/length(ideal_phase(1:number/2));
% ideal_phase2(1:number/2,1:number/2) = ideal_phase2((number/2)/2,(number/2)/2);
for i = 0:n
    a = 1+number*2*i/2;
    b = 1+number*2*(i/2+0.5);
    if b>length(x)
        b = length(x);
    end
    for j = 0:n
    c = 1+number*2*j/2;
    d = 1+number*2*(j/2+0.5);
    if d>length(x)
        d = length(x);
    end
    ideal_phase2(a:b,c:d) = ideal_phase2(round((a+b)/2),round((c+d)/2));
    end
end

x = [-fliplr(x(2:end)),x];
y = x;
[X,Y] = meshgrid(x,y);
filter = X.^2 + Y.^2 < (D/2)^2;
ideal_phase2 = [flipud(fliplr(ideal_phase2(:,:))) , flipud(ideal_phase2(:,2:end)); fliplr(ideal_phase2(2:end,2:end)) , ideal_phase2(2:end,:)];
ideal_phase2 = ideal_phase2 .* filter;
origin_phase = [flipud(fliplr(origin_phase(:,:))) , flipud(origin_phase(:,2:end)); fliplr(origin_phase(2:end,2:end)) , origin_phase(2:end,:)];
origin_phase = origin_phase .* filter;
if Parameter.imageshow2 ==1
Phase_2D = figure(2);
goodfigure('','w',[0.35 0.2 0.65 0.62])
subplot(1,2,1)
imagesc(x,y,mod(origin_phase/pi,2))
shading flat
axis equal
axis square
axis tight
goodimage("\itx axis (\mum)","\ity axis (\mum)","\itIdeal phase",18)
subplot(1,2,2)
if check_point==1
    bar = 0;
    imagesc(x,y,mod(origin_phase/pi,2))
else
    imagesc(x,y,mod(ideal_phase2/pi,2))
end
shading flat
axis equal
axis square
axis tight
goodimage("\itx axis (\mum)","\ity axis (\mum)","\itSampling = "+bar+"\mum",18)
end
if check_point==1
NearField.u_Sampling = 1*exp(1i*origin_phase).*filter;
else
NearField.u_Sampling = 1*exp(1i*ideal_phase2).*filter;
end
NearField.u_origin = 1*exp(1i*origin_phase).*filter;
NearField.x = x;
NearField.y = y;
NearField.lambda = lambda;
end