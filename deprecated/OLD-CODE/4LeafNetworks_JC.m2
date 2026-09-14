--The following code computes all of the ideals for 4-leaf JC k-cycle networks
--to verify the statement in Proposition 4.5.
--The ideal is computed for one labeling of each topology and then the coordinates
--are permuted to obtain the ideal for each different labeling.

restart;

A = (1,1);C = (1,-1);G = (-1,1); T = (-1,-1);

L = 
{(A,A,A,A),(A,A,C,C),(A,C,A,C),(A,C,C,A),
 (A,C,G,T),(C,A,A,C),(C,A,C,A),(C,A,G,T),
 (C,C,A,A),(C,C,C,C),(C,G,A,T),(C,G,C,G),
 (C,G,T,A),(C,C,G,G),(C,G,G,C)};--JC

x = hashTable{A => 0, C => 1, G => 1, T => 1}--JC
y = hashTable{A => 0, C => 1, G => 2, T => 3}

L1 = toList apply(L,i->q_(y#(i#0),y#(i#1),y#(i#2),y#(i#3)));
L2 = {a_0,a_1,b_0,b_1,c_0,c_1,d_0,d_1,e_0,e_1,
      f_0,f_1,g_0,g_1,h_0,h_1,l_0,l_1};

R = QQ[(L2|L1), MonomialOrder=> Eliminate 18];


--2-cycle (tree) Network Topology
Eqn_2 = toList apply(L,i->
q_(y#(i#0),y#(i#1),y#(i#2),y#(i#3)) - 
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*g_(x#(i#2#0*i#3#0,i#2#1*i#3#1)));

--3-cycle Network Topology
Eqn_3 = toList apply(L,i->
q_(y#(i#0),y#(i#1),y#(i#2),y#(i#3)) -
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*f_(x#(i#2))*g_(x#(i#0#0*i#1#0,i#0#1*i#1#1))*h_(x#(i#0#0*i#1#0,i#0#1*i#1#1))
-
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*e_(x#(i#2))*g_(x#(i#0#0*i#1#0,i#0#1*i#1#1))*h_(x#(i#3))
);

--4-cycle Network Topology
Eqn_4 = toList apply(L,i->
q_(y#(i#0),y#(i#1),y#(i#2),y#(i#3)) - 
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*f_(x#(i#1))*g_(x#(i#1#0*i#2#0,i#1#1*i#2#1))*h_(x#(i#0)) - 
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*e_(x#(i#1))*g_(x#(i#2))*h_(x#(i#2#0*i#3#0,i#2#1*i#3#1)));
      
      
--We compute the ideals only up to a certain degree and verify they
-- are prime and of the correct dimension below.
      
for j from 2 to 4 do
{K_j = ideal(Eqn_j);
{time 
GG_j = selectInSubring(1,gens gb(K_j, DegreeLimit => 18))},
I_j = ideal(GG_j),
MG_j = mingens I_j};



---Prime/Dimension check with Jacobian

--2-cycle (tree) Network Topology (parameters only)
P_2 = toList apply(L,i-> 
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*g_(x#(i#2#0*i#3#0,i#2#1*i#3#1)));

--3-cycle Network Topology (parameters only)
P_3 = toList apply(L,i->
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*f_(x#(i#2))*g_(x#(i#0#0*i#1#0,i#0#1*i#1#1))*h_(x#(i#0#0*i#1#0,i#0#1*i#1#1)) - 
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*e_(x#(i#2))*g_(x#(i#0#0*i#1#0,i#0#1*i#1#1))*h_(x#(i#3)));

--4-cycle Network Topology (parameters only)
P_4 = toList apply(L,i->
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*f_(x#(i#1))*g_(x#(i#1#0*i#2#0,i#1#1*i#2#1))*h_(x#(i#0)) - 
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*d_(x#(i#3))*e_(x#(i#1))*g_(x#(i#2))*h_(x#(i#2#0*i#3#0,i#2#1*i#3#1)));
      
      
J2 = jacobian matrix{P_2};
J3 = jacobian matrix{P_3};
J4 = jacobian matrix{P_4};

rank(J2) == dim I_2 - 18
rank(J3) == dim I_3 - 18
rank(J4) == dim I_4 - 18

isPrime I_2
isPrime I_3
--The computation below will eventually return true, however, it will take several hours to complete
--isPrime I_4
  


------------------------------------------------------------------------------------------

----Permutations maps of labels    -------------------------------------------------

------------------------------------------------------------------------------------------
T = {a_0,a_1,b_0,b_1,c_0,c_1,d_0,d_1,e_0,e_1,
      f_0,f_1,g_0,g_1,h_0,h_1,l_0,l_1};

--(01)

S01 = {q_(0,0,0,0), q_(0,0,1,1), q_(1,0,0,1), q_(1,0,1,0), q_(1,0,2,3),
       q_(0,1,0,1), q_(0,1,1,0), q_(0,1,2,3), q_(1,1,0,0), q_(1,1,1,1),
       q_(1,2,0,3), q_(1,2,2,1), q_(1,2,3,0), q_(1,1,2,2), q_(1,2,1,2)}
  
s01 = map(R,R,matrix{(T|S01)})


--(02)
S02 = {q_(0,0,0,0), q_(1,0,0,1), q_(0,1,0,1), q_(1,1,0,0), q_(1,2,0,3),
       q_(0,0,1,1), q_(1,0,1,0), q_(1,0,2,3), q_(0,1,1,0), q_(1,1,1,1), 
       q_(0,1,2,3), q_(1,2,1,2), q_(1,2,3,0), q_(1,2,2,1), q_(1,1,2,2)}
s02 = map(R,R,matrix{(T|S02)})

--(03)

S03 = {q_(0,0,0,0), q_(1,0,1,0), q_(1,1,0,0), q_(0,1,1,0), q_(1,2,3,0),
       q_(1,0,0,1), q_(0,0,1,1), q_(1,0,2,3), q_(0,1,0,1), q_(1,1,1,1),
       q_(1,2,0,3), q_(1,1,2,2), q_(0,1,2,3), q_(1,2,1,2), q_(1,2,2,1)}
s03 = map(R,R,matrix{(T|S03)})

--(12)
S12 = {q_(0,0,0,0), q_(0,1,0,1), q_(0,0,1,1), q_(0,1,1,0), q_(0,1,2,3),
       q_(1,0,0,1), q_(1,1,0,0), q_(1,2,0,3), q_(1,0,1,0), q_(1,1,1,1), 
       q_(1,0,2,3), q_(1,1,2,2), q_(1,2,3,0), q_(1,2,1,2), q_(1,2,2,1)}
s12 = map(R,R,matrix{(T|S12)})

--(13)
S13 = {q_(0,0,0,0), q_(0,1,1,0), q_(0,1,0,1), q_(0,0,1,1), q_(0,1,2,3),
       q_(1,1,0,0), q_(1,0,1,0), q_(1,2,3,0), q_(1,0,0,1), q_(1,1,1,1), 
       q_(1,2,0,3), q_(1,2,1,2), q_(1,0,2,3), q_(1,2,2,1), q_(1,1,2,2)}
s13 = map(R,R,matrix{(T|S13)})

--(23)
S23 =  {q_(0,0,0,0), q_(0,0,1,1), q_(0,1,1,0), q_(0,1,0,1), q_(0,1,2,3),
        q_(1,0,1,0), q_(1,0,0,1), q_(1,0,2,3), q_(1,1,0,0), q_(1,1,1,1), 
        q_(1,2,3,0), q_(1,2,2,1), q_(1,2,0,3), q_(1,1,2,2), q_(1,2,1,2)}
s23 = map(R,R,matrix{(T|S23)})


------------------------------------------------------------------------------------------

----All Tree Networks    -------------------------------------------------

------------------------------------------------------------------------------------------

V_1 = I_2;
V_2 = s12(I_2);
V_3 = s02(I_2);


------------------------------------------------------------------------------------------

----All 3-cycle Networks    -------------------------------------------------

------------------------------------------------------------------------------------------

B_1 = (I_3);
B_2 = s12(I_3);
B_3 = s13(I_3);
B_4 = s02(I_3);
B_5 = s03(I_3);
B_6 = s02(s13(I_3));

------------------------------------------------------------------------------------------

----All 4-cycle Networks    -------------------------------------------------

------------------------------------------------------------------------------------------
--1 and 3 at corners
H_1  = (I_4);
H_2  = s13(I_4);

--1 and 2 at corners
H_3  = s23(I_4);
H_4  = s12(s23(I_4));

--1 and 0 at corners
H_5  = s03(I_4);
H_6  = s01(s03(I_4));

-- 0 and 2 at corners
H_7  = s01(s23(I_4));
H_8  = s02(s01(s23(I_4)));

-- 0 and 3 at corners
H_9  = s01(I_4);
H_10 = s03(s01(I_4));

-- 2 and 3 at corners
H_11 = s12(I_4);
H_12 = s23(s12(I_4));

--Network comparisons for 4-leaf k-cycle networks for 
--constructing the poset in Figure 9. 

for j1 from 1 to 3 do for j2 from 1 to 3 do if isSubset(V_j1,V_j2) then print(toString (j1,j2))
for j1 from 1 to 6 do for j2 from 1 to 6 do if isSubset(B_j1,B_j2) then print(toString (j1,j2))
for j1 from 1 to 12 do for j2 from 1 to 12 do if isSubset(H_j1,H_j2) then print(toString (j1,j2))
 
for j1 from 1 to 3 do
  for j2 from 1 to 6 do if isSubset(B_j2,V_j1) then print(toString (v_j1,b_j2))
  
for j1 from 1 to 6 do
  for j2 from 1 to 12 do if isSubset(H_j2,B_j1) then print(toString (b_j1,h_j2))
   
for j1 from 1 to 3 do
  for j2 from 1 to 12 do if isSubset(H_j2,V_j1) then print(toString (v_j1,h_j2))
  
  

  
  





