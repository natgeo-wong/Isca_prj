using NetCDF, MAT, Glob, Statistics, JLD2
using Seaborn

function ncname(fol::AbstractString,ii::Integer)
    fnc = "$(fol)/run000$(ii)/atmos_daily.nc"
end

function dataextractsfc(parisca::AbstractString,fol::AbstractString,nlon::Integer,nlat::Integer)

    cdir = pwd(); cd(fol); allfol = glob("run00*/"); cd(cdir); nfol = length(allfol);
    mdata = zeros(nlon,nlat,nfol-1); sdata = zeros(nlon,nlat,nfol-1);

    for ii = 2 : nfol
        mdata[:,:,ii-1] = mean(ncread(ncname(fol,ii),parisca),dims=3);
        sdata[:,:,ii-1] = std(ncread(ncname(fol,ii),parisca),dims=3);
    end

    mdata = mean(mdata,dims=3); mdata = mean(mdata,dims=1)[:]; mdata = (mdata + reverse(mdata))/2;
    sdata = mean(sdata,dims=3)/sqrt(nfol-1);
    sdata = mean(sdata,dims=1)[:]/sqrt(nlon); sdata = sdata + reverse(sdata);

    if parisca == "precipitation"; mdata = mdata*24*3600; sdata = sdata*24*3600;
    elseif parisca == "t_surf";    mdata = mdata .- 273.15;
    end

    return mdata,sdata

end

function dataextractlvl(parisca::AbstractString,fol::AbstractString,nlon::Integer,nlat::Integer)

    cdir = pwd(); cd(fol); allfol = glob("run00*/"); cd(cdir); nfol = length(allfol);
    mdata = zeros(nlon,nlat,30,nfol-1);

    for ii = 2 : nfol
        mdata[:,:,:,ii-1] = mean(ncread(ncname(fol,ii),parisca),dims=4);
    end

    mdata = mean(mdata,dims=4); mdata = mean(mdata,dims=1);
    mdata = (mdata+reverse(mdata,dims=2))/2; mdata = reshape(mdata,nlat,30);

    return mdata

end

reg = matread("lonlatpre.mat"); lon = reg["lon"][:]; lat = reg["lat"][:]; pre = reg["allpre"][:];
nlon = length(lon); nlat = length(lat);

RASfol = "/Volumes/CliNat-Isca/isca_out/Islands/T85L30-RRTM-RAS/control/";
QEBfol = "/Volumes/CliNat-Isca/isca_out/Islands/T85L30-RRTM-SBM/control/";

@load "controlprcp.jld2"
#mprcpRAS,sprcpRAS = dataextractsfc("precipitation",RASfol,nlon,nlat);
#mprcpQEB,sprcpQEB = dataextractsfc("precipitation",QEBfol,nlon,nlat);
#@save "controlprcp.jld2"  mprcpQEB mprcpRAS sprcpQEB sprcpRAS

close(); figure(figsize=(10,6),dpi=200)
plot(sind.(lat),mprcpRAS,label="Relaxed Arakawa-Schubert");
fill_between(sind.(lat),mprcpRAS-sprcpRAS,mprcpRAS+sprcpRAS,alpha=0.3);
plot(sind.(lat),mprcpQEB,label="Quasi-Equilibrium Betts-Miller");
fill_between(sind.(lat),mprcpQEB-sprcpQEB,mprcpQEB+sprcpQEB,alpha=0.3);
xlim(-1,1); ylim(0,10); grid("on")
xticks([-1,-sind(60),-sind(45),-sind(30),-sind(15),0,sind(15),sind(30),sind(45),sind(60),1],
       ["-90","-60","-45","-30","-15","0","15","30","45","60","90"]);
legend(); xlabel(L"Latitude / $\degree$"); ylabel(L"Precipitation / mm day$^{-1}$");
savefig("../figures/controlprcp.png",bbox_inches="tight")

@load "controltemp.jld2"
#mtempRAS,stempRAS = dataextractsfc("t_surf",RASfol,nlon,nlat);
#mtempQEB,stempQEB = dataextractsfc("t_surf",QEBfol,nlon,nlat);
#@save "controltemp.jld2"  mtempQEB mtempRAS stempQEB stempRAS

close(); figure(figsize=(10,6),dpi=200)
plot(sind.(lat),mtempRAS,label="Relaxed Arakawa-Schubert");
fill_between(sind.(lat),mtempRAS-stempRAS,mtempRAS+stempRAS,alpha=0.3);
plot(sind.(lat),mtempQEB,label="Quasi-Equilibrium Betts-Miller");
fill_between(sind.(lat),mtempQEB-stempQEB,mtempQEB+stempQEB,alpha=0.3);
xlim(-1,1); ylim(-50,30); grid("on")
xticks([-1,-sind(60),-sind(45),-sind(30),-sind(15),0,sind(15),sind(30),sind(45),sind(60),1],
       ["-90","-60","-45","-30","-15","0","15","30","45","60","90"]);
legend(); xlabel(L"Latitude / $\degree$"); ylabel(L"Temperature / $\degree$C");
savefig("../figures/controltemp.png",bbox_inches="tight")

@load "controluwind.jld2"
#uwindRAS = dataextractlvl("ucomp",RASfol,nlon,nlat);
#uwindQEB = dataextractlvl("ucomp",QEBfol,nlon,nlat);
#@save "controluwind.jld2" uwindQEB uwindRAS

close(); figure(figsize=(10,7),dpi=200)
contourf(sind.(lat),pre,uwindRAS');
xlim(-1,1); ylim(0,1000); grid("on")
xticks([-1,-sind(60),-sind(45),-sind(30),-sind(15),0,sind(15),sind(30),sind(45),sind(60),1],
       ["-90","-60","-45","-30","-15","0","15","30","45","60","90"]);
xlabel(L"Latitude / $\degree$"); ylabel(L"Pressure / hPa");
PyPlot.gca().invert_yaxis()
savefig("../figures/controluwind_RAS.png",bbox_inches="tight")

close(); figure(figsize=(10,7),dpi=200)
contourf(sind.(lat),pre,uwindQEB');
xlim(-1,1); ylim(0,1000); grid("on")
xticks([-1,-sind(60),-sind(45),-sind(30),-sind(15),0,sind(15),sind(30),sind(45),sind(60),1],
       ["-90","-60","-45","-30","-15","0","15","30","45","60","90"]);
xlabel(L"Latitude / $\degree$"); ylabel(L"Pressure / hPa");
PyPlot.gca().invert_yaxis()
savefig("../figures/controluwind_QEB.png",bbox_inches="tight")
