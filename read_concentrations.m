function conc=read_concentrations(scen)

species={'CO2','CH4','N2O','CFC_11','CFC_12'};
 %%Read emissions from MAGICC text file
for i=1:numel(species)
[conc.(species{i}).time conc.(species{i}).val conc.(species{i}).unit]= readmagicc(scen,species{i},'c');
end