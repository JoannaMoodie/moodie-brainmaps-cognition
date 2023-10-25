
% This is an example script of the vertex-wise _g_ associations, calculated for each cohort.
% Comparable scripts were run for all 3 cohorts, and for surface area, thickness, curvature and sulcal depth

addpath('/surfstat')
avsurf = SurfStatReadSurf( { '~/freesurfer/subjects/fsaverage/surf/lh.pial'...
                           '~/freesurfer/subjects/fsaverage/surf/rh.pial'});

[ID  VolumeLeft VolumeRight ageMRI sex headX headY headZ site lag g]=textread('/data_input.csv', '%s %s %s %f %s %f %f %f %s %f %f'); 

vol = SurfStatReadData([VolumeLeft  VolumeRight]);
VolumeLeft = strrep(VolumeLeft(:),'"','');
VolumeRight = strrep(VolumeRight(:),'"','');

ID = term(ID);
AgeMRI = term(ageMRI);
Sex = term(sex);
HeadX = term(headX);
HeadY = term(headY);
HeadZ = term(headZ);
Site = term(site);
Lag = term(lag);
G = term(g);


mycovariates = 1 +  G + AgeMRI + Sex + HeadX + HeadY + HeadZ + Site ;
slm = SurfStatLinMod(vol, mycovariates, avsurf);
slm = SurfStatT(slm, g);
standardvertex = std(vol.Data.Data,0,2);
standardg = std(g, 0,1); 
volbeta = slm.ef'.*(standardg./standardvertex);
volse = slm.sd'.*(volbeta./slm.ef');
max(volbeta)
min(volbeta)
volqstat =  SurfStatQ2(slm);

writematrix([volbeta, volse, volqstat.Q'], '/data_output.csv', 'Delimiter', ',')
