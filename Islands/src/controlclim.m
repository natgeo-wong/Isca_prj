clear all; clc;

load lonlat.mat; nlon = numel(lon); nlat = numel(lat);
lon(end+1) = lon(1)+360; [ mlat,mlon ] = meshgrid(lat,lon);

RASfol = '/Volumes/CliNat-Isca/isca_out/Islands/T85L30-RRTM-RAS/';
QEBfol = '/Volumes/CliNat-Isca/isca_out/Islands/T85L30-RRTM-SBM/';

%%
prcpRAS = zeros(nlon,nlat,2); prcpQEB = zeros(nlon,nlat,2);
tempRAS = zeros(nlon,nlat,2); tempQEB = zeros(nlon,nlat,2);
for ii = 2 : 3
    
    prcpRAS(:,:,ii-1) = mean(ncread(ncname(RASfol,ii),'precipitation'),3);
    prcpQEB(:,:,ii-1) = mean(ncread(ncname(QEBfol,ii),'precipitation'),3);
    tempRAS(:,:,ii-1) = mean(ncread(ncname(RASfol,ii),'t_surf'),3);
    tempQEB(:,:,ii-1) = mean(ncread(ncname(QEBfol,ii),'t_surf'),3);
    
end

prcpRAS = mean(prcpRAS,3); prcpQEB = mean(prcpQEB,3);
tempRAS = mean(tempRAS,3); tempQEB = mean(tempQEB,3);

%%
prcpRAS = prcpRAS * 24*3600; prcpQEB = prcpQEB * 24*3600;
tempRAS = tempRAS - 273.15;  tempQEB = tempQEB - 273.15;

prcpRAS = hemsym(prcpRAS); prcpQEB = hemsym(prcpQEB);
tempRAS = hemsym(tempRAS); tempQEB = hemsym(tempQEB);

prcpRAS = lonextend(prcpRAS); prcpQEB = lonextend(prcpQEB);
tempRAS = lonextend(tempRAS); tempQEB = lonextend(tempQEB);

%%
close all; fig_resize(1.9,1);
[ pcol,~,~ ] = cpal_extract('drywet',20,0,0);
[ tcol,~,~ ] = cpal_extract('RdBu_r',20,0,0);

subplot(4,5,[1,2,6,7]);
m_proj('mollweide','clon',180);
m_contourf(mlon,mlat,prcpRAS,0:0.5:10,'linestyle','none');
m_grid('tickdir','out','linewi',1,...
    'xtick',60:60:300,'ytick',-60:30:60,...
    'xticklabels',[],'yticklabels',[],'XaxisLocation','middle');
colormap(gca,pcol); caxis([0 10]);
title(['Relaxed Arakawa-Schubert' newline]);
ylabel('Precipitation / mm day^{-1}','fontweight','bold','fontsize',11);

subplot(4,5,[3,4,8,9]);
m_proj('mollweide','clon',180);
m_contourf(mlon,mlat,prcpQEB,0:0.5:10,'linestyle','none');
m_grid('tickdir','out','linewi',1,...
    'xtick',60:60:300,'ytick',-60:30:60,...
    'xticklabels',[],'yticklabels',[],'XaxisLocation','middle');
colormap(gca,pcol); caxis([0 10]);
title(['Quasi-Equilibrium Betts-Miller' newline]);

subplot(4,5,[11,12,16,17]);
m_proj('mollweide','clon',180);
m_contourf(mlon,mlat,tempRAS,-50:5:50,'linestyle','none');
m_grid('tickdir','out','linewi',1,...
    'xtick',60:60:300,'ytick',-60:30:60,...
    'xticklabels',[],'yticklabels',[],'XaxisLocation','middle');
colormap(gca,tcol); caxis([-50 50]);
ylabel(['Surface Temperature / ' sprintf('%c',char(176)) 'C'],...
    'fontweight','bold','fontsize',11);

subplot(4,5,[13,14,18,19]);
m_proj('mollweide','clon',180);
m_contourf(mlon,mlat,tempQEB,-50:5:50,'linestyle','none');
m_grid('tickdir','out','linewi',1,...
    'xtick',60:60:300,'ytick',-60:30:60,...
    'xticklabels',[],'yticklabels',[],'XaxisLocation','middle');
colormap(gca,tcol); caxis([-50 50]);

subplot(4,5,[5,10]);
colormap(gca,pcol); caxis([0 10]); colorbar('west'); axis off;

subplot(4,5,[15,20]);
colormap(gca,tcol); caxis([-50 50]); colorbar('west'); axis off;

saveas(gcf,'controlclim','png');

%%

function fnc = ncname (fol,ii)
jj = num2str(ii); fnc = [ fol './control/run000' jj '/atmos_daily.nc' ];
end

function data = hemsym (data)
data = (data + fliplr(data))/2;
end

function data = lonextend(data)
data(end+1,:) = data(1,:);
end