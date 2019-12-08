load lonlat.mat; lon(end+1) = lon(1)+360;
[ mlat,mlon ] = meshgrid(lat,lon);
qflux = genqflux(30,16,lon,lat);
fig_resize(1.2,1.8); cmap = cpal_extract('RdBu_r',60,0,0); cmap(30:31,:) = 1;

subplot(9,4,[1,2,5,6]);
m_proj('mollweide','clon',180);
m_contourf(mlon,mlat,qflux,-30:30,'linestyle','none');
m_grid('tickdir','out','linewi',1,...
    'xtick',60:60:300,'ytick',-60:30:60,...
    'xticklabels',[],'yticklabels',[],'XaxisLocation','middle');
colormap(cmap); caxis([-30 30]);

subplot(9,4,[9,10,13,14]);
qfluxa = qflux2zero(qflux,lon,lat,[175,179,-5,-1]);
qfluxa = qflux2zero(qfluxa,lon,lat,[181,185,-5,-1]);
qfluxa = qflux2zero(qfluxa,lon,lat,[175,179,1,5]);
qfluxa = qflux2zero(qfluxa,lon,lat,[181,185,1,5]);
m_proj('mollweide','clon',180);
m_contourf(mlon,mlat,qfluxa,-30:30,'linestyle','none');
map_2x2('k','linewidth',1);
m_grid('tickdir','out','linewi',1,...
    'xtick',60:60:300,'ytick',-60:30:60,...
    'xticklabels',[],'yticklabels',[],'XaxisLocation','middle');
colormap(cmap); caxis([-30 30]);

subplot(9,4,[3,4,7,8]); qflux = qflux2zero(qflux,lon,lat,[178,182,-2,2]);
m_proj('mollweide','clon',180);
m_contourf(mlon,mlat,qflux,-30:30,'linestyle','none');
map_1x1('k','linewidth',1);
m_grid('tickdir','out','linewi',1,...
    'xtick',60:60:300,'ytick',-60:30:60,...
    'xticklabels',[],'yticklabels',[],'XaxisLocation','middle');
colormap(cmap); caxis([-30 30]);

subplot(9,4,[17,18,21,22]);
qflux = qflux2zero(qflux,lon,lat,[173,177,3,7]);
qflux = qflux2zero(qflux,lon,lat,[183,187,3,7]);
qflux = qflux2zero(qflux,lon,lat,[173,177,-7,-3]);
qflux = qflux2zero(qflux,lon,lat,[183,187,-7,-3]);
m_proj('mollweide','clon',180);
m_contourf(mlon,mlat,qflux,-30:30,'linestyle','none');
map_3x3('k','linewidth',1);
m_grid('tickdir','out','linewi',1,...
    'xtick',60:60:300,'ytick',-60:30:60,...
    'xticklabels',[],'yticklabels',[],'XaxisLocation','middle');
colormap(cmap); caxis([-30 30]);

subplot(9,4,[25,26,29,30]);
qflux = qflux2zero(qflux,lon,lat,[168,172,-2,2]);
qflux = qflux2zero(qflux,lon,lat,[188,192,-2,2]);
qflux = qflux2zero(qflux,lon,lat,[168,172,8,12]);
qflux = qflux2zero(qflux,lon,lat,[178,182,8,12]);
qflux = qflux2zero(qflux,lon,lat,[188,192,8,12]);
qflux = qflux2zero(qflux,lon,lat,[168,172,-12,-8]);
qflux = qflux2zero(qflux,lon,lat,[178,182,-12,-8]);
qflux = qflux2zero(qflux,lon,lat,[188,192,-12,-8]);
m_proj('mollweide','clon',180);
m_contourf(mlon,mlat,qflux,-30:30,'linestyle','none');
map_5x5('k','linewidth',1);
m_grid('tickdir','out','linewi',1,...
    'xtick',60:60:300,'ytick',-60:30:60,...
    'xticklabels',[],'yticklabels',[],'XaxisLocation','middle');
colormap(cmap); caxis([-30 30]);

subplot(9,4,[11,12,15,16]);
qfluxa = qflux2zero(qfluxa,lon,lat,[175,185,-5,5]);
m_proj('mollweide','clon',180);
m_contourf(mlon,mlat,qfluxa,-30:30,'linestyle','none');
map_cont('small','k','linewidth',1);
m_grid('tickdir','out','linewi',1,...
    'xtick',60:60:300,'ytick',-60:30:60,...
    'xticklabels',[],'yticklabels',[],'XaxisLocation','middle');
colormap(cmap); caxis([-30 30]);

subplot(9,4,[19,20,23,24]);
qfluxa = qflux2zero(qfluxa,lon,lat,[173,187,-7,7]);
m_proj('mollweide','clon',180);
m_contourf(mlon,mlat,qfluxa,-30:30,'linestyle','none');
map_cont('med','k','linewidth',1);
m_grid('tickdir','out','linewi',1,...
    'xtick',60:60:300,'ytick',-60:30:60,...
    'xticklabels',[],'yticklabels',[],'XaxisLocation','middle');
colormap(cmap); caxis([-30 30]);

subplot(9,4,[27,28,31,32]);
qfluxa = qflux2zero(qfluxa,lon,lat,[168,192,-12,12]);
m_proj('mollweide','clon',180);
m_contourf(mlon,mlat,qfluxa,-30:30,'linestyle','none');
map_cont('large','k','linewidth',1);
m_grid('tickdir','out','linewi',1,...
    'xtick',60:60:300,'ytick',-60:30:60,...
    'xticklabels',[],'yticklabels',[],'XaxisLocation','middle');
colormap(cmap); caxis([-30 30]);

subplot(9,4,[33,34,35,36]);
colormap(cmap); caxis([-30 30]); colorbar('horiz','north'); axis off;

saveas(gcf,'..figures/islands','png');