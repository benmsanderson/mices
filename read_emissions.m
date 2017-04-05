function emis=read_emissions(scen)

species={'FossilCO2','OtherCO2','CH4','N2O','SOx','CO','NMVOC','NOx','BC','OC','NH3','CF4','C2F6','C6F14','HFC23','HFC32','HFC43_10','HFC125','HFC134a','HFC143a','HFC227ea','HFC245fa','SF6','CFC_11','CFC_12','CFC_113','CFC_114','CFC_115','CARB_TET','MCF','HCFC_22','HCFC_141B','HCFC_142B','HALON1211','HALON1202','HALON1301','HALON2402','CH3BR','CH3CL'};
 %%Read emissions from MAGICC text file
for i=1:numel(species)
[emis.(species{i}).time emis.(species{i}).val emis.(species{i}).unit]= readmagicc(scen,species{i},'E');
end