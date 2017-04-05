function emis_out=calc_pathway(emis_hi,emis_lo,yr_strt,yr_hlfwy,emms,yr_rampdwn,t_rampdwn,e_fin)
yr_end=2500;
emis_out=emis_hi;

t_strt=find(emis_hi.FossilCO2.time==yr_strt) ;

e0=emis_hi.FossilCO2.val(t_strt)+ ...
   emis_hi.OtherCO2.val(t_strt);
             em=emis_hi.FossilCO2.val(t_strt-1)+ ...
                emis_hi.OtherCO2.val(t_strt-1);
             t_end=find(emis_hi.FossilCO2.time==yr_end);
             zero_yr=yr_strt+yr_hlfwy;

     tims=[emis_hi.FossilCO2.time(t_strt:end)-emis_hi.FossilCO2.time(t_strt)]';
     r=emms;
     g0=(e0-em)/(emis_hi.FossilCO2.time(t_strt)-emis_hi.FossilCO2.time(t_strt-1));
     yrg0=0;
     ge=0;
     syms a b tau re t_e t
     fun = @(t,a,t_e,tau,re) a*(t-t_e).*exp(-t/tau)-re;
     dfun = @(t,a,t_e,tau,re) a*exp(-t/tau) - (a*exp(-t/tau).*(t - t_e))/tau;


     S=vpasolve([fun(0,a,t_e,tau,re)==e0,fun(yr_hlfwy,a,t_e,tau,re)==(e0-r)/2,dfun(0,a,t_e,tau,re)==g0,fun(400,a,t_e,tau,re)==-r],[a,t_e,tau,re],[1.17,-10,10,r]);
     

if(size(S,1))==1
     sln=subs(fun(tims,a,t_e,tau,r), S);
     fnf=eval(sln(:));
else
    fnf=NaN*tims;
end
     
  t_emis=[emis_hi.FossilCO2.val(1:(t_strt-1))+ ...
          emis_hi.OtherCO2.val(1:(t_strt-1));fnf];
  t_year=[emis_hi.FossilCO2.time(1:(t_strt-1)); ...
          emis_hi.FossilCO2.time(t_strt:t_end)];
  
  fun2= @(t,yr_rampdwn,emms) -(emms-e_fin)*exp(-((t)/t_rampdwn).^2)-e_fin;
  
  s_rmp=find(emis_hi.FossilCO2.time==yr_rampdwn) ;
  t_emis(s_rmp:end)=fun2(1:numel(t_emis(s_rmp:end)),t_rampdwn,emms);
  
gases=fieldnames(emis_hi);


for n=1:numel(gases)
rampup=emis_hi.(gases{n}).val(1:(t_strt-1));
hifuture=emis_hi.(gases{n}).val(t_strt:end);
lofuture=emis_lo.(gases{n}).val(t_strt:end);
t_sw=emis_hi.(gases{n}).time(t_strt:end)-emis_hi.(gases{n}).time(t_strt);
rampdown=hifuture.*exp(-t_sw/S.tau)+lofuture.*(1-exp(-t_sw/S.tau));
    
emis_out.(gases{n}).val=interp1(emis_lo.(gases{n}).time,double([rampup; ...
                    rampdown]),t_year);
emis_out.(gases{n}).time=t_year;
end

    emis_out.FossilCO2.val=t_emis-emis_out.OtherCO2.val;

     
 
 