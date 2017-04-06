%Read scenario emissions
emis{1}=read_emissions('RCP26');
conc{1}=read_concentrations('RCP26');
temp{1}=read_temp_cesm('RCP26');

param=read_all_parameters_test();

%define output times
tt = linspace(1800,2500,701);
opt=0;
if opt
paramopt=opt_methane(param,emis,conc,temp,tt)
paramopt=opt_n2o(paramopt,emis,conc,temp,tt)
paramopt=opt_clim(paramopt,emis,conc,temp,tt,0)
else 
paramopt=param;
end


out=climod_ode2(emis{1},conc{1},paramopt,tt,'all');
plot_out(out,conc{1},temp{1})

