function fv=tsolve3(C,Ca0,kappa,kappa2,kdeep,lambda,gamma_l,gamma_o,alpha,rho,rho2,beta_l,beta_o,beta_od,fcg,emis,tt,t,cpl)
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
   
   
   
   dppm=(alpha*C(2)-rho*C(3)/(1-gamma_o*C(1)))/100;
    dppm2=(rho*C(3)/(1+gamma_o*C(1))-rho2*C(4))/100;

   %derivative of atmospheric carbon content. emissions, minus
   %temperature driven flux into land and ocean.  denominator
   %contains the ppm-driven fluxes.                  
    fv(2)=(emis_t-beta_o*dppm)/(1+beta_l/(1+gamma_l*C(1)));
   fv(3)=beta_o*dppm-beta_od*dppm2;
   fv(4)=beta_od*dppm2;
