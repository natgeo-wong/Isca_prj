function qflux = qflux2zero(qflux,lon,lat,breg)

blon = breg(1); elon = breg(2); blat = breg(3); elat = breg(4);

ilon = (lon>blon) & (lon<elon); ilat = (lat>blat) & (lat<elat);
qflux(ilon,ilat) = 0;

end