import ETS2.*

a1 = 1;
a2 = 1;

E = Rz('q1') * Tx(a1) * Rz('q2') * Tx(a2);

E.plot([0, 0]);

syms q1 q2 x y  real

TE = E.fkine([q1, q2]);

e1 = x == TE.t(1);
e2 = y == TE.t(2);

[s1, s2] = solve([e1 e2], [q1, q2]);

length(s1);
length(s2);

%%
mdl_puma560

T = p560.fkine(qn);
qi = p560.ikine6s(T);
p560.fkine(qi);

qi1 = p560.ikine6s(T, 'ru');
qi2 = p560.ikine6s(T, 'lu');

qi3 = p560.ikine6s(T, 'rd');
qi4 = p560.ikine6s(T, 'ld');

qi = p560.ikine6s(SE3(3, 0, 0));