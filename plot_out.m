function plot_out(out,conc,temp)

time=[1850:2300];

obs_co2=interp1(conc.CO2.time,conc.CO2.val,time);
mod_co2=interp1(out.clim.time,out.clim.ppm,time);
co2_err=mean(([obs_co2-mod_co2]).^2)./var(obs_co2);


obs_tas=interp1(temp.time,temp.temp,time);
mod_tas=interp1(out.clim.time,out.clim.tem,time);


obs_tas=obs_tas-mean(obs_tas(1:40));
mod_tas=mod_tas-mean(mod_tas(1:40));
tas_err=mean(([obs_tas-mod_tas]).^2)./var(obs_tas);

obs_ch4=interp1(conc.CH4.time,conc.CH4.val,time);
mod_ch4=interp1(out.CH4.tt,out.CH4.cF,time);

obs_n20=interp1(conc.N2O.time,conc.N2O.val,time);
mod_n20=interp1(out.N2O.tt,out.N2O.cF,time);


figure(1)
clf
subplot(2,2,1)
p1=plot(time,obs_tas,'k-');
hold on
p2=plot(time,mod_tas,'r-');
legend([p1,p2],'CESM1-CAM5/RCP2.6','MiCES','location','SouthEast')
xlabel('Year')
ylabel('Temperature/PI (K)')
xlim([1950,2100])
plot([1850,2500],[2,2],'k--')
subplot(2,2,2)
p1=plot(time,obs_co2,'k-');
hold on
p2=plot(time,mod_co2,'r-');
legend([p1,p2],'MAGICC6','MiCES')
xlim([1950,2300])

xlabel('Year')
ylabel('CO2 Concentration (ppmv)')

subplot(2,2,3)
p1=plot(time,obs_ch4,'k-');
hold on
p2=plot(time,mod_ch4,'r-');
legend([p1,p2],'MAGICC','MiCES')
xlim([1950,2300])

xlabel('Year')
ylabel('CH4 Concentration (ppbv)')
subplot(2,2,4)
p1=plot(time,obs_n20,'k-');
hold on
p2=plot(time,mod_n20,'r-');
legend([p1,p2],'MAGICC','MiCES','location','SouthEast')
xlim([1950,2300])

xlabel('Year')
ylabel('N2O Concentration (ppbv)')
