
--The following code shows that there exists an invariant for the 5-leaf 5-cycle Jukes-Cantor
--network that is not an invariant for either of the 5-leaf 4-cycle networks pictured in
--Figure 10.

restart;

A = (1,1);C = (1,-1);G = (-1,1); T = (-1,-1);

L = 
{(A,A,A,A,A),(A,C,C,A,A),(A,C,A,C,A),(A,C,A,A,C),(C,C,A,A,A),
 (G,C,C,A,G),(G,C,A,C,G),(G,C,A,G,C),(C,C,A,G,G),(C,C,T,G,C),
 (C,C,T,C,G),(G,C,T,C,C),(C,C,C,T,G),(G,C,C,T,C),(G,C,C,C,T)};--JC



x = hashTable{A => 0, C => 1, G => 1, T => 1};
y = hashTable{A => 0, C => 1, G => 2, T => 3};

L1 = toList apply(L,i->q_(y#(i#0),y#(i#1),y#(i#2),y#(i#3),y#(i#4)));
L2 = {a_0,a_1,b_0,b_1,c_0,c_1,d_0,d_1,e_0,e_1,f_0,f_1,g_0,g_1,h_0,h_1,l_0,l_1,j_0,j_1};

R = QQ[(L2|L1), MonomialOrder=> Eliminate 20];


------The 5-Cycle Network Parameterization

Par_1 = toList apply(L,i-> 
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*e_(x#(i#4))*
f_(x#(i#0))*h_(x#(i#1))*l_(x#(i#1#0*i#2#0,i#1#1*i#2#1))*j_(x#(i#4#0*i#0#0,i#4#1*i#0#1)) +
--
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*e_(x#(i#4))*
g_(x#(i#0))*h_(x#(i#1#0*i#0#0,i#1#1*i#0#1))*l_(x#(i#3#0*i#4#0,i#3#1*i#4#1))*j_(x#(i#4)) );
      


------The 4-Cycle Network with 45 cherry

Par_2 = toList apply(L,i-> 
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*e_(x#(i#4))*
f_(x#(i#0))*h_(x#(i#1))*l_(x#(i#1#0*i#2#0,i#1#1*i#2#1))*j_(x#(i#3#0*i#4#0,i#3#1*i#4#1)) + 
--
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*e_(x#(i#4))*
g_(x#(i#0))*h_(x#(i#1#0*i#0#0,i#1#1*i#0#1))*l_(x#(i#3#0*i#4#0,i#3#1*i#4#1))*j_(x#(i#3#0*i#4#0,i#3#1*i#4#1))
);


------The 4-Cycle Network with 23 cherry


Par_3 = toList apply(L,i->
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*e_(x#(i#4))*
f_(x#(i#0))*h_(x#(i#4))*l_(x#(i#3#0*i#4#0,i#3#1*i#4#1))*j_(x#(i#1#0*i#2#0,i#1#1*i#2#1)) +
--
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*e_(x#(i#4))*
g_(x#(i#0))*h_(x#(i#4#0*i#0#0,i#4#1*i#0#1))*l_(x#(i#1#0*i#2#0,i#1#1*i#2#1))*j_(x#(i#1#0*i#2#0,i#1#1*i#2#1))
);

-------Parameterization maps

L2 = {a_0,a_1,b_0,b_1,c_0,c_1,d_0,d_1,e_0,e_1,f_0,f_1,g_0,g_1,h_0,h_1,l_0,l_1,j_0,j_1};
PAR_1 = (L2|Par_1);
PAR_2 = (L2|Par_2);
PAR_3 = (L2|Par_3);


----Distinguishing Invariant

-------------------

ff = 
q_(0,1,0,1,0)*q_(2,1,1,0,2)*q_(1,1,3,1,2)-q_(0,1,1,0,0)*q_(2,1,0,1,2)*q_(1,1,3,1,2)+
q_(0,1,1,0,0)*q_(2,1,0,2,1)*q_(1,1,3,1,2)-q_(0,1,0,1,0)*q_(2,1,1,0,2)*q_(2,1,3,1,1)+
q_(0,1,1,0,0)*q_(2,1,0,1,2)*q_(2,1,3,1,1)-q_(0,1,1,0,0)*q_(2,1,0,2,1)*q_(2,1,3,1,1)-
q_(0,1,0,1,0)*q_(2,1,1,0,2)*q_(1,1,1,3,2)+q_(0,1,1,0,0)*q_(2,1,0,1,2)*q_(1,1,1,3,2)-
q_(0,1,1,0,0)*q_(2,1,0,2,1)*q_(1,1,1,3,2)+q_(0,1,1,0,0)*q_(2,1,0,2,1)*q_(2,1,1,1,3);



sub(ff, matrix{PAR_1})
sub(ff, matrix{PAR_2})
sub(ff, matrix{PAR_3})


-----Jacobian Computations


J1 = jacobian matrix{Par_1};
J2 = jacobian matrix{Par_2};
J3 = jacobian matrix{Par_3};

rank(J1)
rank(J2)
rank(J3)










