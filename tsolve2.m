function fv=tsolve2(C,Ca0,kappa,kappa2,kdeep,lambda,gamma_l,gamma_o,alpha,rho,rho2,beta_l,beta_o,beta_od,fcg,emis,tt,t,cpl,c_amp)
 fv = zeros(2,1);%%make output vector - 1st element is temperature,
                 %%2nd element is atmospheric carbon
    emis_t=interp1(tt,emis,t);%interpolate emissions to this
                              %timestep "t"
   fcg_t=interp1(tt,fcg,t);%interpolate nonco2 forcings to this timestep
                           %next term is derivative of temperature,
                           %based on energy balance                        
   if cpl
   fv(1)=1/kappa*(6.3*log(C(2)/Ca0)+fcg_t-lambda*C(1))-kdeep*(C(1)-C(5));
   fv(5)=1/kappa2*kdeep*(C(1)-C(5));
   else
   fv(1)=0;
   end
   
   
   
   dppm=(alpha*C(2)-rho*C(3))/100;
    dppm2=(rho*C(3)-rho2*C(4))/100;

   %derivative of atmospheric carbon content. emissions, minus
   %temperature driven flux into land and ocean.  denominator
   %contains the ppm-driven fluxes.                  
    fv(2)=(emis_t-(gamma_l+gamma_o)*fv(1)*(1+C(1)*c_amp))/(1+alpha*(beta_l))-beta_o*dppm; ...
   fv(3)=beta_o*dppm+gamma_o*fv(1)-beta_od*dppm2;
   fv(4)=beta_od*dppm2;
