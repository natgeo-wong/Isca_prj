module Islands

## Modules Used
using Dates
using NetCDF, Glob, JLD2, FileIO
using ClimateEasy, ClimateIsca
using PyPlot

function islandroot(iroot::AbstractString="/Volumes/CliNat-Isca/isca_out/Islands/")
    cd(iroot); exp = replace.(glob("*/"),"/".=>"")
    return iroot
end

end # module
