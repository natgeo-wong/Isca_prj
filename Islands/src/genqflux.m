function qflux = genqflux(amp,width,lon,lat)

[ mlat,~ ] = meshgrid(lat,lon);

qflux = - amp * (1-2.*mlat.^2./(width.^2)) .* ...
        exp(-((mlat.^2)./(width.^2))./cosd(lat)');

end