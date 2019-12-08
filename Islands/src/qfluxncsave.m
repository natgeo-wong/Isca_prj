home = pwd;
cd /Users/natgeo-wong/Codes/Isca/Isca_src/src/extra/python/scripts/gfdl_grid_files;

finfo = ncinfo('t85.nc');

lon  = ncread('t85.nc','lon');  nlon = numel(lon);
lat  = ncread('t85.nc','lat');  nlat = numel(lat);
lonb = ncread('t85.nc','lonb'); nlonb = numel(lonb);
latb = ncread('t85.nc','latb'); nlatb = numel(latb);

cd(home);

oqflux = genqflux(30,16,lon,lat);
mqflux = qflux2zero(oqflux,lon,lat,[178,182,-2,2]);
nqflux = newqflux(oqflux,mqflux);

fnc = 'qflux_1x1.nc'; rmfile(fnc);

nccreate(fnc,'lon','Dimensions',{'lon',nlon});
nccreate(fnc,'lat','Dimensions',{'lat',nlat});
nccreate(fnc,'lonb','Dimensions',{'lonb',nlonb});
nccreate(fnc,'latb','Dimensions',{'latb',nlatb});
nccreate(fnc,'ocean_qflux','Dimensions',{'lon',nlon,'lat',nlat});

ncwrite(fnc,'lon',lon);
ncwrite(fnc,'lat',lat);
ncwrite(fnc,'lonb',lonb);
ncwrite(fnc,'latb',latb);
ncwrite(fnc,'ocean_qflux',nqflux);

close all; figure();
plot(sind(lat),oqflux(1,:),'k');
hold on; plot(sind(lat),nqflux(1,:),':k'); hold off;
ylim([-40 40]); grid on; box on;