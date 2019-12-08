home = pwd;
cd /Volumes/CliNat-Isca/isca_out/Islands/T85L30-RRTM-RAS/;

lon = ncread('./control/run0003/atmos_daily.nc','lon'); nlon = numel(lon);
lat = ncread('./control/run0003/atmos_daily.nc','lat'); nlat = numel(lat);
lon(end+1) = lon(1)+360; [mlat,mlon] = meshgrid(lat,lon);

%%
prcp5x5 = zeros(nlon,nlat,2);
prcpcon = zeros(nlon,nlat,2);
prcp1x1 = zeros(nlon,nlat,2);
for ii = 2 : 3, jj = num2str(ii);
    
    prcpcon(:,:,ii-1) = mean(ncread(['./control/run000' jj '/atmos_daily.nc'],'t_surf'),3);
    prcp5x5(:,:,ii-1) = mean(ncread(['./clarge/run000' jj '/atmos_daily.nc'],'t_surf'),3);
    prcp1x1(:,:,ii-1) = mean(ncread(['./1x1/run000' jj '/atmos_daily.nc'],'t_surf'),3);
    
end

%prcp5x5 = prcp5x5 * 24*3600;
%prcpcon = prcpcon * 24*3600;
%prcp1x1 = prcp1x1 * 24*3600;
cd(home);

%%
prcp5x5(end+1,:,:) = prcp5x5(1,:,:);
prcpcon(end+1,:,:) = prcpcon(1,:,:);
prcp1x1(end+1,:,:) = prcp1x1(1,:,:);

%%
d5con = (prcp5x5+fliplr(prcp5x5))/2 - (prcpcon+fliplr(prcpcon))/2;
d1con = (prcp1x1+fliplr(prcp1x1))/2 - (prcpcon+fliplr(prcpcon))/2;
d51   = (prcp5x5+fliplr(prcp5x5))/2 - (prcp1x1+fliplr(prcp1x1))/2;

%%
close all; figure(); [ col,~,~ ] = cpal_extract('RdBu_r',100,0,0);
m_proj('mollweide','clon',180);
m_contourf(mlon,mlat,mean(d51,3),-10:0.2:10,'linestyle','none');
%map_1x1a('k','linewidth',1);
m_grid('tickdir','out','linewi',2,...
    'xtick',60:60:300,'ytick',-60:30:60,...
    'xticklabels',[],'yticklabels',[],'XaxisLocation','middle');
caxis([-10 10]); colormap(gca,col); colorbar;
title('t_surf Rate Difference mm/day');

function map_plotsqr (breg,varargin)

blon = breg(1); elon = breg(2); blat = breg(3); elat = breg(4);
    
x = [ linspace(blon,elon,101) linspace(elon,elon,101) ...
      linspace(elon,blon,101) linspace(blon,blon,101) ];
y = [ linspace(blat,blat,101) linspace(blat,elat,101) ...
      linspace(elat,elat,101) linspace(elat,blat,101) ];
hold on; m_plot(x,y,varargin{:}); hold off;
    
end

function map_5x5a(varargin)

map_plotsqr([168,172,-2,2],varargin{:});
map_plotsqr([178,182,-2,2],varargin{:});
map_plotsqr([188,192,-2,2],varargin{:});
map_plotsqr([173,177,3,7],varargin{:});
map_plotsqr([183,187,3,7],varargin{:});
map_plotsqr([173,177,-3,-7],varargin{:});
map_plotsqr([183,187,-3,-7],varargin{:});
map_plotsqr([168,172,8,12],varargin{:});
map_plotsqr([178,182,8,12],varargin{:});
map_plotsqr([188,192,8,12],varargin{:});
map_plotsqr([168,172,-8,-12],varargin{:});
map_plotsqr([178,182,-8,-12],varargin{:});
map_plotsqr([188,192,-8,-12],varargin{:});
    
end

function map_1x1a(varargin)

map_plotsqr([178,182,-2,2],varargin{:});
    
end