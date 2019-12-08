function nqflux = newqflux (oqflux,mqflux)

nlat = size(oqflux,2); nqflux = oqflux * 0;
for ii = 1 : nlat
    
    oqfii = mean(oqflux(:,ii)); mqfii = mean(mqflux(:,ii));
    if oqfii ~= mqfii
          nqflux(:,ii) = mqflux(:,ii) * oqfii / mqfii;
    else, nqflux(:,ii) = mqflux(:,ii);
    end
    
end

end