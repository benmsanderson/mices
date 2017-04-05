function param=read_all_parameters_test()




%%Specify other parameters for climate/aerosol scaling
param.aer.f_1990=-0.8;

param.clim.sens=4.8;
param.clim.kappa=10;
param.clim.ppm_1850=290;
param.clim.c_amp=1.1;
param.clim.beta_l=3.5;
param.clim.beta_o=2.4;
param.clim.ocn_init=600;
param.clim.gamma_l=-95;
param.clim.gamma_o=-60;
param.clim.lnd_init=2300;
param.clim.cpl=1;
param.clim.beta_od=.5;
param.clim.docn_init=1.0000e+05;
param.clim.kappa2=12.6;
param.clim.kdeep=0.15;

param.CH4.Year=2000;
param.CH4.species='CH4';
param.CH4.mass=16;
param.CH4.Xair=0.1765;
param.CH4.cPD=1.746e+03;
param.CH4.dcdt=5.97;
param.CH4.cPI=681.8;
param.CH4.kOH=0.0895;
param.CH4.kCl=0.0064;
param.CH4.kStrat=0.0083;
param.CH4.kSurf=0.0144;
param.CH4.anPI=1.1344;
param.CH4.aPI=1.226;
param.CH4.a2100=0.9;
param.CH4.aPIstrat=0.8;
param.CH4.a2100strat=0.7;
param.CH4.sOH=-0.2832;
param.CH4.sStrat=0;
param.CH4.b=2.800;
param.CH4.RFe=3.7000e-04;
param.CH4.kMCF=0.2483;
param.CH4.kMCFstrat=0.0235;
param.CH4.kMCFocean=-0.0041;
param.CH4.fillMCF=0.900;
param.CH4.fill=0.950;
param.CH4.r272=0.5823;
param.CH4.r225=0;

param.N2O.Year=2000;
param.N2O.species='N2O';
param.N2O.mass=28;
param.N2O.Xair=0.1765;
param.N2O.cPD=316;
param.N2O.dcdt=0.635;
param.N2O.cPI=298;
param.N2O.kOH=0;
param.N2O.kCl=0;
param.N2O.kStrat=0.0088;
param.N2O.kSurf=0;
param.N2O.anPI=0.91;
param.N2O.aPI=2.5;
param.N2O.a2100=1.09;
param.N2O.aPIstrat=0.814;
param.N2O.a2100strat=1.057;
param.N2O.sOH=0;
param.N2O.sStrat=0.1959;
param.N2O.b=4.7900;
param.N2O.RFe=0.0030;
param.N2O.kMCF=0;
param.N2O.kMCFstrat=0;
param.N2O.kMCFocean=0;
param.N2O.fillMCF=1;
param.N2O.fill=0.7943;
param.N2O.r272=0;
param.N2O.r225=0;

param.HFC134a.Year=2010;
param.HFC134a.species='HFC134a';
param.HFC134a.mass=102;
param.HFC134a.Xair=0.1765;
param.HFC134a.cPD=0.0580;
param.HFC134a.dcdt=0;
param.HFC134a.cPI=0;
param.HFC134a.kOH=0;
param.HFC134a.kCl=0;
param.HFC134a.kStrat=0;
param.HFC134a.kSurf=0;
param.HFC134a.anPI=1;
param.HFC134a.aPI=1;
param.HFC134a.a2100=1;
param.HFC134a.aPIstrat=1;
param.HFC134a.a2100strat=1;
param.HFC134a.sOH=0;
param.HFC134a.sStrat=0;
param.HFC134a.b=17.5000;
param.HFC134a.RFe=0.1600;
param.HFC134a.kMCF=0;
param.HFC134a.kMCFstrat=0;
param.HFC134a.kMCFocean=0;
param.HFC134a.fillMCF=1;
param.HFC134a.fill=0.9700;
param.HFC134a.r272=0.4270;
param.HFC134a.r225=0.8160;

%s_proj={'CH4','N2O','HFC134a'};;

%%Read parameters for CH4 and N20 cycle;
%for i=1:numel(s_proj);
%paramfun.(s_proj{i})=readparams(s_proj{i},1);;
%flds=fieldnames(paramfun.(s_proj{i}));;
%for j=1:numel(flds);
%    param.(s_proj{i}).(flds{j})= paramfun.(s_proj{i}).(flds{j})();;
%end;
%end