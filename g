CHIP JunctionController {
    IN  PowerOn;
    OUT X[3], Z[3];

    PARTS:
    // 3-bit state counter s2 s1 s0 (counts 0..7 when PowerOn=1)
    // When PowerOn=0, the counter holds its current value (starts at 000).

    // current state bits
    Bit(in=nextS0, load=true, out=s0);
    Bit(in=nextS1, load=true, out=s1);
    Bit(in=nextS2, load=true, out=s2);

    // increment logic (binary +1)
    Not(in=s0, out=inc0);
    Xor(a=s0, b=s1, out=inc1);
    And(a=s0, b=s1, out=carry1);
    Xor(a=carry1, b=s2, out=inc2);

    // only advance when PowerOn=1, else hold state
    Mux(a=s0, b=inc0, sel=PowerOn, out=nextS0);
    Mux(a=s1, b=inc1, sel=PowerOn, out=nextS1);
    Mux(a=s2, b=inc2, sel=PowerOn, out=nextS2);

    // handy NOTs
    Not(in=s0, out=ns0);
    Not(in=s1, out=ns1);
    Not(in=s2, out=ns2);

    // decode states 0..7
    And(a=ns2, b=ns1, out=t00);
    And(a=t00, b=ns0, out=st0);

    And(a=t00, b=s0,  out=st1);

    And(a=ns2, b=s1, out=t01);
    And(a=t01, b=ns0, out=st2);
    And(a=t01, b=s0,  out=st3);

    And(a=s2,  b=ns1, out=t10);
    And(a=t10, b=ns0, out=st4);
    And(a=t10, b=s0,  out=st5);

    And(a=s2,  b=s1, out=t11);
    And(a=t11, b=ns0, out=st6);
    And(a=t11, b=s0,  out=st7);

    // OUTPUTS expected by cmp:
    // st0: X=100 Z=100
    // st1: X=110 Z=100
    // st2: X=001 Z=100
    // st3: X=010 Z=100
    // st4: X=100 Z=100
    // st5: X=100 Z=110
    // st6: X=100 Z=001
    // st7: X=100 Z=010

    // ----- X lights -----
    // X red (X[2]) = 1 in states 0,1,4,5,6,7
    Or(a=st0, b=st1, out=xr01);
    Or(a=st4, b=st5, out=xr45);
    Or(a=st6, b=st7, out=xr67);
    Or(a=xr01, b=xr45, out=xr0145);
    Or(a=xr0145, b=xr67, out=X[2]);

    // X amber (X[1]) = 1 in states 1,3
    Or(a=st1, b=st3, out=X[1]);

    // X green (X[0]) = 1 in state 2
    Or(a=st2, b=false, out=X[0]);

    // ----- Z lights -----
    // Z red (Z[2]) = 1 in states 0,1,2,3,4,5
    Or(a=st0, b=st1, out=zr01);
    Or(a=st2, b=st3, out=zr23);
    Or(a=st4, b=st5, out=zr45);
    Or(a=zr01, b=zr23, out=zr0123);
    Or(a=zr0123, b=zr45, out=Z[2]);

    // Z amber (Z[1]) = 1 in states 5,7
    Or(a=st5, b=st7, out=Z[1]);

    // Z green (Z[0]) = 1 in state 6
    Or(a=st6, b=false, out=Z[0]);
}
