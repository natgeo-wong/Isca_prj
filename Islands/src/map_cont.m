function map_cont(csize,varargin)

if strcmp(csize,'large'),     map_plotsqr([168,192,-12,12],varargin{:});
elseif strcmp(csize,'med'),   map_plotsqr([173,187,-7,7],varargin{:});
elseif strcmp(csize,'small'), map_plotsqr([175,185,-5,5],varargin{:});
end
    
end