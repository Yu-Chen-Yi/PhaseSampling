function [FarField] = XZ_FarFieldGenerate(NearField,Z,scale,sampling_number)
n = 1;
k = 2*pi/NearField.lambda*n;
[x,y]=meshgrid(NearField.x,NearField.y);
kersi = linspace(-scale,scale,sampling_number);
ita = linspace(-scale,+scale,sampling_number);
% ita = logspace(0,log10(scale+1),(sampling_number-1)/2+1)-1;
% ita = [-fliplr(ita(2:end)) ita];
[Kersi,Ita] = meshgrid(kersi,ita);
U=zeros(length(kersi),1);
Uz = [];
for c = 1:length(Z)
    z = Z(c);
for a = 1:length(kersi)
    for b = (sampling_number-1)/2+1:(sampling_number-1)/2+1
                r01 = sqrt(z^2+(Kersi(a,b)-x).^2+(Ita(a,b)-y).^2);
                U(a,1) = U(a,1) + sum(sum(z/(1j*NearField.lambda)*NearField.u.*exp(1j*k.*r01)./r01./r01));
    end

end
    if c==round(length(Z)*1/10)
    disp('10% completed')
    elseif c==round(length(Z)*2/10)
    disp('20% completed')
%     elseif a==round(length(kersi)*3/10)
%     disp('30% completed')
    elseif c==round(length(Z)*4/10)
    disp('40% completed')
%     elseif a==round(length(kersi)*5/10)
%     disp('50% completed')
    elseif c==round(length(Z)*6/10)
    disp('60% completed')
%     elseif a==round(length(kersi)*7/10)
%     disp('70% completed')
    elseif c==round(length(Z)*8/10)
    disp('80% completed')
%     elseif a==round(length(kersi)*9/10)
%     Disp('90% completed')
    elseif c==round(length(Z)*10/10)
    disp('100% completed')
    end
Uz = [Uz,U];
end
FarField.U = Uz;
FarField.x = kersi;
FarField.y = ita;
FarField.z = Z;
Focal_Spot = figure();
set(Focal_Spot,'Name','Focal_Spot','numberTitle','off','Units','normalized','Position',[0.7 0.2 0.3 0.4]);
set(0, 'DefaultFigureRenderer', 'painters');
imagesc(FarField.x,FarField.z,abs(FarField.U)'.^2)
    xtickangle(90)
    ax = gca;
    ax.XAxis.Exponent = 0;
    ax.YAxis.Exponent = 0;
    axis square
    set(gca,'ydir', 'normal' )
    xlabel("x (\mum)")
    ylabel("z (\mum)")
%     title("z = "+FarField.z+"\mum")
    colormap jet
    colorbar
end