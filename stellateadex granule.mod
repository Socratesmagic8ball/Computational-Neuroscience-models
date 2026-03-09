NEURON {
	POINT_PROCESS PROADEX
	NONSPECIFIC_CURRENT i
	RANGE C,gl,el,delT,I,Vr,a,b,tw,fflag,thresh,count,gsyn,nspike:,thresh
	RANGE Vt,amp,del,dur,i_i
}


UNITS {
	(nA)=(nanoamp)
	(pA)=(picoamp)
	(mV)=(millivolt)
	(mM)=(milli/liter)
	(umho)=(micromho)
	(pF)=(picofarad)
	(nS)=(nanosiemens)
}

PARAMETER {
	C=9	(pF) :granule
	gl=0.08(nS) :leak conductance
	el=-70 (mV) :resting potential
	delT=5	(mV) :slope factor
	thresh=20	(mV) :0
	Vr=-82 (mV) :reset potential
	Vt=-50	(mV) :threshold potential
	I=20 (pA) :tonic external current
	a=0	(nS) :subthreshold adaptation
	b=0 (pA) :spike-triggered adaptation
	tw=6.7	(ms) :adaptation time constant
	fflag=1
	count=0
	i_i=0
	del (ms) : iclamp parameters
	dur (ms)	<0,1e9>
	amp (pA)



}


ASSIGNED {
	gsyn	(ns)
	nspike
	i	(nA)
}

STATE { 
	w	(pA)
	vv 	(mV)
}
INITIAL {
	vv=-60
	w=0
	gsyn=0
	nspike=0
	net_send(0,1)
}


BREAKPOINT {
	SOLVE states METHOD derivimplicit
	:i=gsyn*(vv-0)*(0.001)
		at_time(del) : iclamp conditions
	at_time(del+dur)

	if (t < del + dur && t >= del) {
		i = amp - i_i 
	}else{
		i = 0
	}
}


DERIVATIVE states {
	vv'=(gl*(el-vv)+gl*delT*exp((vv-Vt)/delT)+I+(i-w*(0.001))*(1000))/C
	w'=(a*(vv-el)-w)/tw
}



NET_RECEIVE (u(nS)) {
	INITIAL {
		nspike=0
	}
	if (flag == 1) {
		WATCH (vv>thresh) 2
	} else if (flag == 2) {
		net_event(t)
		vv=Vr
		w=w+b
		count=count+1
	} else {	:synaptic activation
		gsyn=gsyn+u
	}
}

