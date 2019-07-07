subroutine dtVdiff2(kk,l,lb,dtVd1l,dtVd1lb)
!This subroutine calculate various differential kernal corresponding k>k_UV

  implicit none

  real(8) kk
  real(8) l,lb,l_con,lb_con
  real(8) k,etaphil,etaphit,etapsi,Zphil,Zphit
  real(8) mf2
  real(8) T,mu
  real(8) xff,xfa
  real(8) zb,zf !distinguish the transverse and longituidanl wave function renormalization
  real(8) nf0,nf1,nf2
  real(8) Fnf0,Fnf1,Fnf2
  external Fnf0,Fnf1,Fnf2
  real(8) Nc,Nf
  parameter(Nc=3.,Nf=2.)
  real(8) pi,hc
  parameter(pi=3.1415926)
  parameter(hc=197.33)
  real(8) v3
  parameter(v3=1./(2.*pi**2))
  real(8) nfd1l,nfd1lb
  real(8) nfd1lf,nfd1lbf,nfd1la,nfd1lba
  real(8) dtVd1l,dtVd1lb

  common /Tmu/ T,mu


  l_con=l
  lb_con=lb

  k=kk

  etaphil=0.
  etaphit=0.
  etapsi=0.


  zb=1.
  zf=1.

  mf2=0.

  xff=-mu + (k*Sqrt(1 + mf2))/zf
  xfa=mu + (k*Sqrt(1 + mf2))/zf

  l=l_con
  lb=lb_con

  nf0=Fnf0(xff,T,l,lb)
  nf1=Fnf1(xff,T,l,lb)
  nf2=Fnf2(xff,T,l,lb)

  nfd1l=-(nf2*(-1 + 3*nf0 + 3*lb*nf1 + 3*l*nf2))
  nfd1lb=-(nf1*(-2 + 3*nf0 + 3*lb*nf1 + 3*l*nf2))/2.

  nfd1lf=nfd1l
  nfd1lbf=nfd1lb
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  l=lb_con
  lb=l_con

  nf0=Fnf0(xfa,T,l,lb)
  nf1=Fnf1(xfa,T,l,lb)
  nf2=Fnf2(xfa,T,l,lb)

  nfd1l=-(nf2*(-1 + 3*nf0 + 3*lb*nf1 + 3*l*nf2))
  nfd1lb=-(nf1*(-2 + 3*nf0 + 3*lb*nf1 + 3*l*nf2))/2.

  nfd1la=nfd1l
  nfd1lba=nfd1lb

  l=l_con
  lb=lb_con
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  dtVd1l=(-2*(1 - etapsi/4.)*k**4*Nc*Nf*(-nfd1lba - nfd1lf)*v3)/(3.*Sqrt(1 + mf2)*zf)
  dtVd1lb=(-2*(1 - etapsi/4.)*k**4*Nc*Nf*(-nfd1la - nfd1lbf)*v3)/(3.*Sqrt(1 + mf2)*zf)

end
