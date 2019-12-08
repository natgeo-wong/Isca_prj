load lonlat.mat; lon(end+1) = lon(1)+360;
[ mlat,mlon ] = meshgrid(lat,lon);

%%
prcpcon = zeros(nlon,nlat,3);
prcp1x1 = zeros(nlon,nlat,3);
prcp2x2 = zeros(nlon,nlat,3);
prcp3x3 = zeros(nlon,nlat,3);
prcp5x5 = zeros(nlon,nlat,3);
prcpcsm = zeros(nlon,nlat,3);
prcpcmd = zeros(nlon,nlat,3);
prcpclg = zeros(nlon,nlat,3);
for ii = 2 : 4, jj = num2str(ii);
    
    prcp5x5(:,:,ii-1) = mean(ncread(['./5x5/run000' jj '/atmos_daily.nc'],'precipitation'),3);
    prcpcon(:,:,ii-1) = mean(ncread(['./control/run000' jj '/atmos_daily.nc'],'precipitation'),3);
    prcpclg(:,:,ii-1) = mean(ncread(['./clarge/run000' jj '/atmos_daily.nc'],'precipitation'),3);
    
end