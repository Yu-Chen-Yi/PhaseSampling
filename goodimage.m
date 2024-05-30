function goodimage(xlabel_name,ylabel_name,title_name,fontsize)
xlabel(xlabel_name);
ylabel(ylabel_name);
title(title_name);
set(gca,'Fontname','times new roman');set(gca,'Fontweight','bold');set(gca,'fontsize',fontsize);
colormap jet;colorbar;
end