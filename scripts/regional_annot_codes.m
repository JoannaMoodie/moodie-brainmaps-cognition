
% read_annotation() function is from https://github.com/fieldtrip/fieldtrip/blob/master/external/freesurfer/read_annotation.m

set(0,'defaultAxesFontSize',15)
addpath('/surfstat')

avsurf = SurfStatReadSurf({'/lh.pial'...
                           '/rh.pial'}) # fsaverage .pial files, needed to plot the cortex below
                           
mask=textread('/mask.csv','%f'); # provided in data/mask.csv

[lv, lL, lct] = read_annotation('/lh.aparc.annot'); # fsaverage .annot files
[rv, rL, rct] = read_annotation('/rh.aparc.annot'); 

parclh = int32([lL]);
names = [lct.struct_names]; 
unique(parclh);

parcrh = int32([rL]);
names = [rct.struct_names]; 
unique(parcrh)

parc = [parclh; parcrh];
parc(parc == 0) = 1639705;
for i = 1:36
code = rct.table(:,5);
code = code(i);
parc(parc == code) = i;
end 

parc(mask == 0) = 37;

SurfStatViewDataRegions(parc, avsurf, 'title') # double check that the colours look as expected on the cortex
saveas(gcf, '/surfstat_DK.jpeg')


writematrix([parc, mask], '/annot_parc_327684.csv')
writetable(table(lct.table, lct.struct_names), '/annot_info.csv')
