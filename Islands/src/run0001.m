home = pwd;
cd /Volumes/CliNat-Isca/isca_out/Islands/T85L30-RRTM-RAS/;

lon = ncread('./control/run0001/atmos_daily.nc','lon'); nlon = numel(lon);
lat = ncread('./control/run0001/atmos_daily.nc','lat'); nlat = numel(lat);
pre = ncread('./control/run0001/atmos_daily.nc','pfull'); 
pre(end+1) = 1000; npre = numel(pre)+1;
lon(end+1) = lon(1)+360; [mlat,mlon] = meshgrid(lat,lon);
pm = 24 * 3600;

%%
%prcpcon = ncread('./control/run0001/atmos_daily.nc','precipitation') * pm;
%prcp5x5 = ncread('./5x5/run0001/atmos_daily.nc','precipitation') * pm;
prcp1x1 = ncread('./1x1/run0001/atmos_daily.nc','precipitation') * pm;

%tsfccon = ncread('./control/run0001/atmos_daily.nc','t_surf');
%tsfc5x5 = ncread('./5x5/run0001/atmos_daily.nc','t_surf');
%tsfc1x1 = ncread('./1x1/run0001/atmos_daily.nc','t_surf');

%tseq1x1 = ncread('./1x1/run0001/atmos_daily.nc','t_surf',[1,61,1],[Inf,8,Inf]);
%taeq1x1 = ncread('./1x1/run0001/atmos_daily.nc','temp',[1,61,1,1],[Inf,8,Inf,Inf]);
%tseq1x1 = reshape(tseq1x1,nlon,8,1,[]); teq1x1 = cat(3,taeq1x1,tseq1x1);
%teq1x1  = mean(teq1x1,2); teq1x1 = reshape(teq1x1,nlon,[],360);

cd(home);

%%
%prcpcon(end+1,:,:) = prcpcon(1,:,:); tsfccon(end+1,:,:) = tsfccon(1,:,:);
%prcp5x5(end+1,:,:) = prcp5x5(1,:,:); tsfc5x5(end+1,:,:) = tsfc5x5(1,:,:);
prcp1x1(end+1,:,:) = prcp1x1(1,:,:); %tsfc1x1(end+1,:,:) = tsfc1x1(1,:,:);
%teq1x1(end+1,:,:) = teq1x1(1,:,:);

%%
%dp5c = (prcp5x5+fliplr(prcp5x5))/2 - (prcpcon+fliplr(prcpcon))/2;
%dp1c = (prcp1x1+fliplr(prcp1x1))/2 - (prcpcon+fliplr(prcpcon))/2;
%dp51 = (prcp5x5+fliplr(prcp5x5))/2 - (prcp1x1+fliplr(prcp1x1))/2;
%dt5c = (tsfc5x5+fliplr(tsfc5x5))/2 - (tsfccon+fliplr(tsfccon))/2;
%dt1c = (tsfc1x1+fliplr(tsfc1x1))/2 - (tsfccon+fliplr(tsfccon))/2;
%dt51 = (tsfc5x5+fliplr(tsfc5x5))/2 - (tsfc1x1+fliplr(tsfc1x1))/2;

%%
close all; fig_resize(3.5,2.5); [ ppre,plon ] = meshgrid(pre,lon);
[ col,~,~ ] = cpal_extract('drywet',30,0,0);

for ii = 350
    m_proj('Equidistant Cylindrical','lon',[0 360],'lat',[-90 90]);
    m_contourf(mlon,mlat,prcp1x1(:,:,ii),0:2:60,'linestyle','none');
    %contourf(plon,ppre,teq1x1(:,:,ii),155:2:305,'linestyle','none');
    map_1x1a('k','linewidth',1);
    m_grid('tickdir','out','linewi',2,...
        'xtick',60:60:300,'ytick',-60:30:60,...
        'xticklabels',[],'yticklabels',[],'XaxisLocation','middle');
    view(0,-90); grid on; box on;
    caxis([0 60]); colormap(gca,col); %colorbar;
    title('Surface Temperature Anomaly / K');
end

saveas(gcf,'../figures/background','png');

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