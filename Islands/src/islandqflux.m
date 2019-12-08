load lonlat.mat; lon(end+1) = lon(1)+360;
[ mlat,mlon ] = meshgrid(lat,lon);
oqflux = genqflux(30,16,lon,lat);
mqflux = qflux2zero(oqflux,lon,lat,[178,182,-2,2]);
nqflux = newqflux(oqflux,mqflux);