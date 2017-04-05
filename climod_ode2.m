function out=climod_ode2(emis,param,tt,use)


%Project & calc RF for CH4, N2O and HFC134a
if isempty(strmatch(use,'N2O'))==1
out.CH4=project_new( emis.CH4, param.CH4,1,tt);
end
if isempty(strmatch(use,'CH4'))==1
out.N2O=project_new( emis.N2O, param.N2O,1,tt);
end

if isempty(strmatch(use,'CH4'))+isempty(strmatch(use,'N2O'))==2


%Project & calc RF for CH4, N2O and HFC134a
out.minor=project_minor( emis, out);
out.aer=project_new_aer( emis, out, param.aer );


cpl=param.clim.cpl;

mat=1.8e20; %moles in atm
length=numel(out.CH4.tt); 
lambda=3.8/param.clim.sens;%sensitivity parameter
kappa=param.clim.kappa;%ocean heat uptake parameters
kappa2=param.clim.kappa2;%ocean heat uptake parameters
kdeep=param.clim.kdeep;%ocean heat uptake parameters

tt=out.CH4.tt;%get timesteps from methane
dt=tt(2)-tt(1);%interval

%%initialize atm
co2c0=param.clim.ppm_1850;%preindustrial CO2 conc
tem0=0;%temperature start
alpha=1e6/mat/12*1e15;%conversion from ppm to Pg
Ca0=co2c0/alpha;%starting carbon in atmosphere (Pg)

%%initialize lnd
cinl(1)=param.clim.lnd_init; %Pg carbon in land
%% Friedlingstein parameters (land)
gamma_l=param.clim.gamma_l;% Pg/K
beta_l=param.clim.beta_l; %Pg/ppm

%temperature amplification parameter for carbon uptake
c_amp=param.clim.c_amp;

%% Friedlingstein parameters (ocn)
gamma_o=param.clim.gamma_o;%Pg/K
beta_o=param.clim.beta_o; %Pg/ppm
cino(1)=param.clim.ocn_init; %PgC (starting) in ocean

%%shallow parameters

%%initialize shallow
oco2c(1)=param.clim.ppm_1850;
cino(1)=param.clim.ocn_init; %PgC (starting) in shallow ocean
rho=oco2c(1)/cino(1);
%%initialize deep

cinod(1)=param.clim.docn_init; %PgC (starting) in deep ocean
beta_od(1)=param.clim.beta_od; %PgC (starting) in deep ocean

odco2c(1)=param.clim.ppm_1850;
rho2=odco2c(1)/cinod(1);




emis_fossil=interp1(emis.FossilCO2.time,emis.FossilCO2.val,tt);%fossil
                                                               %emissions,
                                                               %interpolated
                                                               %to tt
emis_lu=interp1(emis.OtherCO2.time,emis.OtherCO2.val,tt); %landuse
                                                          %emissions,
                                                          %interpolated
                                                          %to tt

for i=1:numel(tt)
f_nonco2(i)=out.CH4.RFrcp(i)+...
    out.N2O.RFrcp(i)+...
    out.aer.aer_f(i)+out.minor.rad(i); %sum non-co2 forcing
gtc_in(i)=emis_fossil(i)+emis_lu(i); %sum anthro carbon in (Pg)
end
%%Solve for Temperature C(1) and atmospheric carbon evolution C(2)
%%using ODE solver.  Calls function tsolve which represents
%%derivatives of temperature and atmos carbon as functions of EBM
%%and freidlingstein parameters.  Returns solution at tt.  Initial
%%conditions are tem0 and Ca0
[t,C] = ode45(@(t,C) tsolve2(C,Ca0,kappa,kappa2,kdeep,lambda,gamma_l,gamma_o,alpha,rho,rho2,beta_l,beta_o,beta_od,f_nonco2,gtc_in,tt,t,cpl,c_amp), tt, [tem0,Ca0,cino(1),cinod(1),tem0]);

out.clim.f_co2=6.3*log(C(:,2)/Ca0);
out.clim.f_nonco2=f_nonco2;
out.clim.gtc_in=gtc_in;
out.clim.time=t;
out.clim.cina=C(:,2);
tim_pi=find(and(t>1850,t<1900));
out.clim.tem=C(:,1)-mean(C(tim_pi,1));
out.clim.cino=C(:,3);
out.clim.cinod=C(:,4);

out.clim.ppm=out.clim.cina*alpha;


cumc(1)=0;%cumulative carbon emis counter
%%now back out ocean and land carbon stocks at each timestep

for i=2:numel(tt)
dt=(out.clim.tem(i)-out.clim.tem(i-1));
dppm=(out.clim.ppm(i)-out.clim.ppm(i-1));

absl(i)=beta_l*dppm+gamma_l*dt;
cinl(i)=cinl(i-1)+absl(i);

f_co2(i)=6.3*log(out.clim.ppm(i)/co2c0);
cumc(i)=cumc(i-1)+gtc_in(i);
end


out.clim.f_co2=f_co2;
out.clim.cinl=cinl;
out.clim.absl=absl;
out.clim.time=tt;
out.clim.cumc=cumc;
end