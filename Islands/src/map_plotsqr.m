function map_plotsqr (breg,varargin)

blon = breg(1); elon = breg(2); blat = breg(3); elat = breg(4);
    
x = [ linspace(blon,elon,101) linspace(elon,elon,101) ...
      linspace(elon,blon,101) linspace(blon,blon,101) ];
y = [ linspace(blat,blat,101) linspace(blat,elat,101) ...
      linspace(elat,elat,101) linspace(elat,blat,101) ];
hold on; m_plot(x,y,varargin{:}); hold off;
    
end