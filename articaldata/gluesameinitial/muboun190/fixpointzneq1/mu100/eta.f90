subroutine eta(kk,lam1k,lam2k,lam3k,lam4k,lam5k,lam0k,hk,dr1dhk,dr2dhk,dr3dhk,dr4dhk,dr5dhk,         &
                                Zphilk,Zphitk,Zpsik,ck,kappak,etaphilk,etaphitk,etapsik)
!Calculating anomonous dimension eta

  implicit none

  real(8) kk,lam1k,lam2k,lam3k,lam4k,lam5k,lam0k,hk,Zphilk,Zphitk,Zpsik,ck,kappak,etaphilk,&
                etaphitk,etapsik,dr1dhk,dr2dhk,dr3dhk,dr4dhk,dr5dhk
  real(8) k ! IR cutoff in flow equations
  real(8) lam0,lam1,lam2,lam3,lam4,lam5,lam6,lam7
  real(8) h,dr1dh,dr2dh,dr3dh,dr4dh,dr5dh
  real(8) Zphit,Zphil,Zpsi
  real(8) c,kappa
  real(8) pi,hc
  parameter(pi=3.1415926)
  parameter(hc=197.33)
  real(8) etaphil,etaphit,etapsi
!meson and quark anomanous dimension
  real(8) Nc,Nf
  parameter(Nc=3.,Nf=2.)
  real(8) v3
  parameter(v3=1./(2.*pi**2))
  real(8) rho !phi_a**2/2
  real(8) Fnb,Fnf0,Fnf1,Fnf2
  external Fnb,Fnf0,Fnf1,Fnf2
  real(8) zb,zf !distinguish the transverse and longituidanl wave function renormalization
  real(8) p0,p0c!temporal compontent of external momentum
  real(8) T,mu
  real(8) l,lb !polyakov loop
  real(8) mu0
  real(8) mp2,ms2,mf2,mp2d1rho,mp2d2rho,mp2d3rho,mp2d4rho,mp2d5rho,ms2d1rho,ms2d2rho,ms2d3rho,ms2d4rho,ms2d5rho,mf2d1rho
  real(8) nb,nbd0x,nbd1x,nbd2x,nbd3x,nbd4x,nbd5x,nbd6x
  real(8) nbPion,nbd1xPion,nbd2xPion,nbd3xPion,nbd4xPion,nbd5xPion,nbSigma,nbd1xSigma,nbd2xSigma, &
          nbd3xSigma,nbd4xSigma,nbd5xSigma,nbd6xPion,nbd6xSigma
  real(8) nff,nfd1xf,nfd2xf,nfd3xf,nfd4xf,nfd5xf,nfa,nfd1xa,nfd2xa,nfd3xa,nfd4xa,nfd5xa,nfd6xa,nfd6xf
  real(8) nf0,nf1,nf2,nfd0x,nfd1x,nfd2x,nfd3x,nfd4x,nfd5x,nfd6x
  real(8) xff,xfa
  real(8) mf2d2rho,mf2d3rho,mf2d4rho,mf2d5rho
  real(8) f2a,f3a,b2b2PS,b2f1aPion,b2f1aPionI,b2f1aSigma,b2f1aSigmaI,b1f2Pion,b1f2PionI,b1f2Sigma,b1f2SigmaI
  complex(8) b2f1aPionC,b2f1aSigmaC,b1f2PionC,b1f2SigmaC
  real(8) l_com,lb_com,b3b2,b2b3

  common /Tmu/ T,mu
  common /polyakov_com/ l_com,lb_com


  k=kk
  lam1=lam1k
  lam2=lam2k
  lam3=lam3k
  lam4=lam4k
  lam5=lam5k
  lam6=0.
  lam7=0.
  lam0=lam0k
  h=hk
  dr1dh=dr1dhk
  dr2dh=dr2dhk
  dr3dh=dr3dhk
  dr4dh=dr4dhk
  dr5dh=dr5dhk
  Zphil=Zphilk
  Zphit=Zphitk
  Zpsi=Zpsik
  c=ck
  kappa=kappak

  rho=kappa !calculations are performed at expansion point kappa

  zb=Zphil/Zphit
  zf=1.


  mu0=0.

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!mass and their derivatives
  mp2=lam1/k**2

  ms2=(lam1 + 2*lam2*rho)/k**2

  mf2=(h**2*rho)/(k**2*Nf)

  mp2d1rho=lam2/k**2

  mp2d2rho=lam3/k**2

  mp2d3rho=lam4/k**2

  mp2d4rho=lam5/k**2

  mp2d5rho=lam6/k**2

  ms2d1rho=(3*lam2 + 2*lam3*rho)/k**2

  ms2d2rho=(5*lam3 + 2*lam4*rho)/k**2

  ms2d3rho=(7*lam4 + 2*lam5*rho)/k**2

  ms2d4rho=(9*lam5 + 2*lam6*rho)/k**2

  ms2d5rho=(11*lam6 + 2*lam7*rho)/k**2

  mf2d1rho=h**2/(k**2*Nf) + (2*h*dr1dh*rho)/(k**2*Nf)

  mf2d2rho=(4*h*dr1dh)/(k**2*Nf) + (2*dr1dh**2*rho)/(k**2*Nf) + &
  (2*h*dr2dh*rho)/(k**2*Nf)

  mf2d3rho=(6*dr1dh**2)/(k**2*Nf) + (6*h*dr2dh)/(k**2*Nf) + &
  (6*dr1dh*dr2dh*rho)/(k**2*Nf) + (2*h*dr3dh*rho)/(k**2*Nf)

  mf2d4rho=(24*dr1dh*dr2dh)/(k**2*Nf) + (8*h*dr3dh)/(k**2*Nf) + &
  (6*dr2dh**2*rho)/(k**2*Nf) + (8*dr1dh*dr3dh*rho)/(k**2*Nf) + &
  (2*h*dr4dh*rho)/(k**2*Nf)

  mf2d5rho=(30*dr2dh**2)/(k**2*Nf) + (40*dr1dh*dr3dh)/(k**2*Nf) + &
  (10*h*dr4dh)/(k**2*Nf) + (20*dr2dh*dr3dh*rho)/(k**2*Nf) + &
  (10*dr1dh*dr4dh*rho)/(k**2*Nf) + (2*h*dr5dh*rho)/(k**2*Nf)


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  nb=Fnb((k*Sqrt(1 + mp2))/Sqrt(zb),T)
  call nbdx(nb,nbd0x,nbd1x,nbd2x,nbd3x,nbd4x,nbd5x,nbd6x)
  nbPion=nbd0x
  nbd1xPion=nbd1x
  nbd2xPion=nbd2x
  nbd3xPion=nbd3x
  nbd4xPion=nbd4x
  nbd5xPion=nbd5x
  nbd6xPion=nbd6x

  nb=Fnb((k*Sqrt(1 + ms2))/Sqrt(zb),T)
  call nbdx(nb,nbd0x,nbd1x,nbd2x,nbd3x,nbd4x,nbd5x,nbd6x)
  nbSigma=nbd0x
  nbd1xSigma=nbd1x
  nbd2xSigma=nbd2x
  nbd3xSigma=nbd3x
  nbd4xSigma=nbd4x
  nbd5xSigma=nbd5x
  nbd6xSigma=nbd6x


  xff=-mu + (k*Sqrt(1 + mf2))/zf
  xfa=mu + (k*Sqrt(1 + mf2))/zf

  l=l_com
  lb=lb_com

  nf0=Fnf0(xff,T,l,lb)
  nf1=Fnf1(xff,T,l,lb)
  nf2=Fnf2(xff,T,l,lb)
  call nfdx(l,lb,nf0,nf1,nf2,nfd0x,nfd1x,nfd2x,nfd3x,nfd4x,nfd5x,nfd6x)
  nff=nfd0x
  nfd1xf=nfd1x
  nfd2xf=nfd2x
  nfd3xf=nfd3x
  nfd4xf=nfd4x
  nfd5xf=nfd5x
  nfd6xf=nfd6x



  nf0=Fnf0(xfa,T,lb,l)
  nf1=Fnf1(xfa,T,lb,l)
  nf2=Fnf2(xfa,T,lb,l)
  call nfdx(lb,l,nf0,nf1,nf2,nfd0x,nfd1x,nfd2x,nfd3x,nfd4x,nfd5x,nfd6x)
  nfa=nfd0x
  nfd1xa=nfd1x
  nfd2xa=nfd2x
  nfd3xa=nfd3x
  nfd4xa=nfd4x
  nfd5xa=nfd5x
  nfd6xa=nfd6x


  f2a=(k*Sqrt(1 + mf2)*nfd1xa + k*Sqrt(1 + mf2)*nfd1xf + zf - nfa*zf - nff*zf)/ &
  (4.*(1 + mf2)**1.5*zf**2)

  f3a=(-((k**2*(1 + mf2)*(nfd2xa + nfd2xf))/zf) +                               &
    3*(k*Sqrt(1 + mf2)*nfd1xa + k*Sqrt(1 + mf2)*nfd1xf + zf - nfa*zf -          &
       nff*zf))/(16.*(1 + mf2)**2.5*zf**2)

  b2b2PS=-((-2*(1 + 2*nbPion))/(Sqrt(1 + mp2)*(mp2 - ms2)**3) -                 &
     (1 + 2*nbPion)/(2.*(1 + mp2)**1.5*(mp2 - ms2)**2) -                        &
     (2*(1 + 2*nbSigma))/(Sqrt(1 + ms2)*(-mp2 + ms2)**3) -                      &
     (1 + 2*nbSigma)/(2.*(1 + ms2)**1.5*(-mp2 + ms2)**2) +                      &
     (k*nbd1xPion)/((1 + mp2)*(mp2 - ms2)**2*Sqrt(zb)) +                        &
     (k*nbd1xSigma)/((1 + ms2)*(-mp2 + ms2)**2*Sqrt(zb)))/(2.*Sqrt(zb))

  b3b2=((k**2*nbd2xPion*Sqrt(zb))/(2.*(1 + mp2)**1.5*(mp2 - ms2)**2) - &
      (4*k*nbd1xPion*zb)/((1 + mp2)*(mp2 - ms2)**3) - &
      (3*k*nbd1xPion*zb)/(2.*(1 + mp2)**2*(mp2 - ms2)**2) + &
      (2*k*nbd1xSigma*zb)/((1 + ms2)*(-mp2 + ms2)**3) + &
      (6*(1 + 2*nbPion)*zb**1.5)/(Sqrt(1 + mp2)*(mp2 - ms2)**4) + &
      (2*(1 + 2*nbPion)*zb**1.5)/((1 + mp2)**1.5*(mp2 - ms2)**3) + &
      (3*(1 + 2*nbPion)*zb**1.5)/(4.*(1 + mp2)**2.5*(mp2 - ms2)**2) - &
      (6*(1 + 2*nbSigma)*zb**1.5)/(Sqrt(1 + ms2)*(-mp2 + ms2)**4) - &
      ((1 + 2*nbSigma)*zb**1.5)/((1 + ms2)**1.5*(-mp2 + ms2)**3))/4.
  b2b3=((k**2*nbd2xSigma*Sqrt(zb))/(2.*(1 + ms2)**1.5*(-mp2 + ms2)**2) + &
      (2*k*nbd1xPion*zb)/((1 + mp2)*(mp2 - ms2)**3) - &
      (4*k*nbd1xSigma*zb)/((1 + ms2)*(-mp2 + ms2)**3) - &
      (3*k*nbd1xSigma*zb)/(2.*(1 + ms2)**2*(-mp2 + ms2)**2) - &
      (6*(1 + 2*nbPion)*zb**1.5)/(Sqrt(1 + mp2)*(mp2 - ms2)**4) - &
      ((1 + 2*nbPion)*zb**1.5)/((1 + mp2)**1.5*(mp2 - ms2)**3) + &
      (6*(1 + 2*nbSigma)*zb**1.5)/(Sqrt(1 + ms2)*(-mp2 + ms2)**4) + &
      (2*(1 + 2*nbSigma)*zb**1.5)/((1 + ms2)**1.5*(-mp2 + ms2)**3) + &
      (3*(1 + 2*nbSigma)*zb**1.5)/(4.*(1 + ms2)**2.5*(-mp2 + ms2)**2))/4.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  p0=pi*T
  p0c=sqrt((pi*(T-1./hc)*exp(-k/T/5.)+pi*1./hc)**2+k**2)

  b2f1aPionC=-(k**2*(-((k*nbPion*(-mu0 + Complex(0,1)*p0 - (k*Sqrt(1 + mp2))/Sqrt(zb)))/  &
          ((1 + mp2)*((-mu0 + Complex(0,1)*p0 -                                 &
                  (k*Sqrt(1 + mp2))/Sqrt(zb))**2 - (k**2*(1 + mf2))/zf**2)      &
**2)) - (k*nbd1xPion)/                                                          &
        (2.*(1 + mp2)*((-mu0 + Complex(0,1)*p0 -                                &
               (k*Sqrt(1 + mp2))/Sqrt(zb))**2 - (k**2*(1 + mf2))/zf**2)) +      &
       (nbPion*Sqrt(zb))/                                                       &
        (2.*(1 + mp2)**1.5*((-mu0 + Complex(0,1)*p0 -                           &
               (k*Sqrt(1 + mp2))/Sqrt(zb))**2 - (k**2*(1 + mf2))/zf**2)) -      &
       (k*(-mu0 + Complex(0,1)*p0c - (k*Sqrt(1 + mp2))/Sqrt(zb)))/              &
        ((1 + mp2)*((-mu0 + Complex(0,1)*p0c -                                  &
                (k*Sqrt(1 + mp2))/Sqrt(zb))**2 - (k**2*(1 + mf2))/zf**2)**2     &
) + Sqrt(zb)/(2.*(1 + mp2)**1.5*                                                &
          ((-mu0 + Complex(0,1)*p0c - (k*Sqrt(1 + mp2))/Sqrt(zb))**2 -          &
            (k**2*(1 + mf2))/zf**2)) +                                          &
       (k*nbPion*(-mu0 + Complex(0,1)*p0 + (k*Sqrt(1 + mp2))/Sqrt(zb)))/        &
        ((1 + mp2)*((-mu0 + Complex(0,1)*p0 +                                   &
                (k*Sqrt(1 + mp2))/Sqrt(zb))**2 - (k**2*(1 + mf2))/zf**2)**2     &
) - (k*nbd1xPion)/                                                              &
        (2.*(1 + mp2)*((-mu0 + Complex(0,1)*p0 +                                &
               (k*Sqrt(1 + mp2))/Sqrt(zb))**2 - (k**2*(1 + mf2))/zf**2)) +      &
       (nbPion*Sqrt(zb))/                                                       &
        (2.*(1 + mp2)**1.5*((-mu0 + Complex(0,1)*p0 +                           &
               (k*Sqrt(1 + mp2))/Sqrt(zb))**2 - (k**2*(1 + mf2))/zf**2)) -      &
       (k**2*zf)/                                                               &
        (Sqrt(1 + mf2)*zb*(-((k**2*(1 + mp2))/zb) +                             &
             (-mu0 + Complex(0,1)*p0c + (k*Sqrt(1 + mf2))/zf)**2)**2) +         &
       ((k**2*nfa*zf)/                                                          &
           (Sqrt(1 + mf2)*zb*(-((k**2*(1 + mp2))/zb) +                          &
                (-mu0 + Complex(0,1)*p0 - (k*Sqrt(1 + mf2))/zf)**2)**2) +       &
          (k**2*nff*zf)/                                                        &
           (Sqrt(1 + mf2)*zb*(-((k**2*(1 + mp2))/zb) +                          &
                (mu0 + Complex(0,1)*p0 - (k*Sqrt(1 + mf2))/zf)**2)**2))/2.      &
+ ((k**2*nff*zf)/                                                               &
           (Sqrt(1 + mf2)*zb*(-((k**2*(1 + mp2))/zb) +                          &
                (-mu0 + Complex(0,1)*p0 + (k*Sqrt(1 + mf2))/zf)**2)**2) +       &
          (k**2*nfa*zf)/                                                        &
           (Sqrt(1 + mf2)*zb*(-((k**2*(1 + mp2))/zb) +                          &
                (mu0 + Complex(0,1)*p0 + (k*Sqrt(1 + mf2))/zf)**2)**2))/2.))/   &
  (2.*zb*zf**2)


  b2f1aPion=real(b2f1aPionC)
  b2f1aPionI=aimag(b2f1aPionC)

  b2f1aSigmaC=-(k**2*(-((k*nbSigma*(-mu0 + Complex(0,1)*p0 -                    &
              (k*Sqrt(1 + ms2))/Sqrt(zb)))/                                     &
          ((1 + ms2)*((-mu0 + Complex(0,1)*p0 -                                 &
                  (k*Sqrt(1 + ms2))/Sqrt(zb))**2 - (k**2*(1 + mf2))/zf**2)      &
**2)) - (k*nbd1xSigma)/                                                         &
        (2.*(1 + ms2)*((-mu0 + Complex(0,1)*p0 -                                &
               (k*Sqrt(1 + ms2))/Sqrt(zb))**2 - (k**2*(1 + mf2))/zf**2)) +      &
       (nbSigma*Sqrt(zb))/                                                      &
        (2.*(1 + ms2)**1.5*((-mu0 + Complex(0,1)*p0 -                           &
               (k*Sqrt(1 + ms2))/Sqrt(zb))**2 - (k**2*(1 + mf2))/zf**2)) -      &
       (k*(-mu0 + Complex(0,1)*p0c - (k*Sqrt(1 + ms2))/Sqrt(zb)))/              &
        ((1 + ms2)*((-mu0 + Complex(0,1)*p0c -                                  &
                (k*Sqrt(1 + ms2))/Sqrt(zb))**2 - (k**2*(1 + mf2))/zf**2)**2     &
) + Sqrt(zb)/(2.*(1 + ms2)**1.5*                                                &
          ((-mu0 + Complex(0,1)*p0c - (k*Sqrt(1 + ms2))/Sqrt(zb))**2 -          &
            (k**2*(1 + mf2))/zf**2)) +                                          &
       (k*nbSigma*(-mu0 + Complex(0,1)*p0 + (k*Sqrt(1 + ms2))/Sqrt(zb)))/       &
        ((1 + ms2)*((-mu0 + Complex(0,1)*p0 +                                   &
                (k*Sqrt(1 + ms2))/Sqrt(zb))**2 - (k**2*(1 + mf2))/zf**2)**2     &
) - (k*nbd1xSigma)/                                                             &
        (2.*(1 + ms2)*((-mu0 + Complex(0,1)*p0 +                                &
               (k*Sqrt(1 + ms2))/Sqrt(zb))**2 - (k**2*(1 + mf2))/zf**2)) +      &
       (nbSigma*Sqrt(zb))/                                                      &
        (2.*(1 + ms2)**1.5*((-mu0 + Complex(0,1)*p0 +                           &
               (k*Sqrt(1 + ms2))/Sqrt(zb))**2 - (k**2*(1 + mf2))/zf**2)) -      &
       (k**2*zf)/                                                               &
        (Sqrt(1 + mf2)*zb*(-((k**2*(1 + ms2))/zb) +                             &
             (-mu0 + Complex(0,1)*p0c + (k*Sqrt(1 + mf2))/zf)**2)**2) +         &
       ((k**2*nfa*zf)/                                                          &
           (Sqrt(1 + mf2)*zb*(-((k**2*(1 + ms2))/zb) +                          &
                (-mu0 + Complex(0,1)*p0 - (k*Sqrt(1 + mf2))/zf)**2)**2) +       &
          (k**2*nff*zf)/                                                        &
           (Sqrt(1 + mf2)*zb*(-((k**2*(1 + ms2))/zb) +                          &
                (mu0 + Complex(0,1)*p0 - (k*Sqrt(1 + mf2))/zf)**2)**2))/2.      &
+ ((k**2*nff*zf)/                                                               &
           (Sqrt(1 + mf2)*zb*(-((k**2*(1 + ms2))/zb) +                          &
                (-mu0 + Complex(0,1)*p0 + (k*Sqrt(1 + mf2))/zf)**2)**2) +       &
          (k**2*nfa*zf)/                                                        &
           (Sqrt(1 + mf2)*zb*(-((k**2*(1 + ms2))/zb) +                          &
                (mu0 + Complex(0,1)*p0 + (k*Sqrt(1 + mf2))/zf)**2)**2))/2.))/   &
  (2.*zb*zf**2)


  b2f1aSigma=real(b2f1aSigmaC)
  b2f1aSigmaI=aimag(b2f1aSigmaC)


   etaphit=-((f2a*h**2*Nc*v3 - (8*f3a*h**2*Nc*v3)/3. -                          &
      (4*b2b2PS*lam2**2*rho*v3)/(3.*k**2*zb**2) +                               &
      ((b2f1aSigma*h**2 + b2f1aPion*h**2*(-1 + Nf**2))*v3*                      &
         ((-2*f2a*h**2*Nc*v3)/3. + (4*f3a*h**2*Nc*v3)/3.))/(3.*Nf))/            &
    (1 - ((b2f1aSigma*h**2 + b2f1aPion*h**2*(-1 + Nf**2))*v3*                   &
         ((-2*f2a*h**2*Nc*v3)/3. + (4*f3a*h**2*Nc*v3)/3.))/(12.*Nf)))


  etapsi=((-(b2f1aPion*h**2) + b2f1aSigma*h**2 + b2f1aPion*h**2*Nf**2)*v3*      &
    (12*k**2 + 3*f2a*h**2*k**2*Nc*v3 - 8*f3a*h**2*k**2*Nc*v3 -                  &
      4*b2b2PS*lam2**2*rho*v3))/                                                &
  (2.*k**2*(18*Nf - b2f1aPion*f2a*h**4*Nc*v3**2 +                               &
      b2f1aSigma*f2a*h**4*Nc*v3**2 + 2*b2f1aPion*f3a*h**4*Nc*v3**2 -            &
      2*b2f1aSigma*f3a*h**4*Nc*v3**2 + b2f1aPion*f2a*h**4*Nc*Nf**2*v3**2 -      &
      2*b2f1aPion*f3a*h**4*Nc*Nf**2*v3**2))

etaphil=(2*(1 - etaphit/5.)*lam2**2*rho*v3*                                       &
       (-6*b2b2PS + (4*b3b2*(1 + mp2))/zb + (4*b2b3*(1 + ms2))/zb))/                &
     (3.*k**2*zb**4) + ((4 - etapsi)*f3a*h**2*Nc*v3)/(3.*zb)

  etaphilk=etaphil
  etaphitk=etaphit
  etapsik=etapsi

end



