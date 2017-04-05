function err=calc_error(conc,temp,out,use)
time=[1950:2300];

if isempty(strmatch(use,'N2O'))==1
obs_ch4=interp1(conc.CH4.time,conc.CH4.val,time);
mod_ch4=interp1(out.CH4.tt,out.CH4.cF,time);
ch4_err=mean(([obs_ch4-mod_ch4]).^2)./var(obs_ch4);
if ~isnan(ch4_err)
err=ch4_err;
else
    err=0;
end

end

if isempty(strmatch(use,'CH4'))==1

obs_n20=interp1(conc.N2O.time,conc.N2O.val,time);
mod_n20=interp1(out.N2O.tt,out.N2O.cF,time);
n20_err=mean(([obs_n20-mod_n20]).^4)./var(obs_n20);
    if ~isnan(n20_err)
          err=n20_err;
    
    else
        err=0
    end
    
end

if isempty(strmatch(use,'CH4'))+isempty(strmatch(use,'N2O'))==2


obs_co2=interp1(conc.CO2.time,conc.CO2.val,time);
mod_co2=interp1(out.clim.time,out.clim.ppm,time);
co2_err=mean(([obs_co2-mod_co2]).^2)./var(obs_co2);


if isnan(co2_err)
    disp('CO2 error not calculated')
    co2_err=1;
end


obs_tas=interp1(temp.time,mean(temp.temp,1),time);
mod_tas=interp1(out.clim.time,out.clim.tem,time);

obs_tas=smooth(obs_tas-mean(obs_tas(1:20)),20)';
mod_tas=mod_tas-mean(mod_tas(1:20));


tas_err=nanmean(([obs_tas-mod_tas]).^2)./var(obs_tas);
if isnan(tas_err)
    tas_err=1;
end


err=co2_err*tas_err;
end
