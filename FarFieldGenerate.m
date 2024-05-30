function [FarField] = FarFieldGenerate(NearField,z,scale,sampling_number)
n = 1;
k = 2*pi/NearField.lambda*n;
[x,y]=meshgrid(NearField.x,NearField.y);
kersi = linspace(0,+scale,sampling_number);
ita = linspace(0,+scale,sampling_number);
% ita = logspace(0,log10(scale+1),(sampling_number-1)/2+1)-1;
% ita = [-fliplr(ita(2:end)) ita];
[Kersi,Ita] = meshgrid(kersi,ita);
U=zeros(length(kersi),length(Ita));
for a = 1:length(kersi)
    for b = 1:length(ita)
                r01 = sqrt(z^2+(Kersi(a,b)-x).^2+(Ita(a,b)-y).^2);
                U(a,b) = U(a,b) + sum(sum(z/(1j*NearField.lambda)*NearField.u.*exp(1j*k.*r01)./r01./r01));
    end
    if a==round(length(kersi)*1/10)
    disp('10% completed')
    elseif a==round(length(kersi)*2/10)
    disp('20% completed')
    elseif a==round(length(kersi)*4/10)
    disp('40% completed')
    elseif a==round(length(kersi)*6/10)
    disp('60% completed')
    elseif a==round(length(kersi)*8/10)
    disp('80% completed')
    elseif a==round(length(kersi)*10/10)
    disp('100% completed')
    end 
end
U = [flipud(fliplr(U(:,:))) , flipud(U(:,2:end)); fliplr(U(2:end,2:end)) , U(2:end,:)];
kersi = [-fliplr(kersi(2:end)),kersi];
ita = kersi;
FarField.z = z;
FarField.U = U;
FarField.x = kersi;
FarField.y = ita;
Focal_Spot = figure();
set(Focal_Spot,'Name','Focal_Spot','numberTitle','off','Units','normalized','Position',[0.7 0.2 0.3 0.4]);
set(0, 'DefaultFigureRenderer', 'painters');
imagesc(FarField.x,FarField.y,abs(FarField.U').^2)
    xtickangle(90)
    ax = gca;
    ax.XAxis.Exponent = 0;
    ax.YAxis.Exponent = 0;
    axis square
    set(gca,'ydir', 'normal' )
    xlabel("x (\mum)")
    ylabel("y (\mum)")
    title("z = "+FarField.z+"\mum")
    colormap jet
    colorbar
end