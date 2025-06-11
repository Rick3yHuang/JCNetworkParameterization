--The following computations show that there are no invariants for the 3-leaf 
--3-cycle networks for the CFN, JC,and K2P models. We show this by verifying 
--that the rank of the Jacobian matrix J1 is equal to the dimension of the 
--coordinate space for each model. Moroever, we show that there are no invariants
--for the CFN or JC model if we set the transition matrix on any single leaf 
--edge of the 3-leaf 3-cycle equal to the identity. 

--We also show that the ideal for the K3P model is principal and indepedent 
--of the leaf labeling. 

--The computations for each model can be performed by commenting out the
--code for the other models below. 

-----------------------------------------------------------------------------------------
restart;
printWidth=60;

--The group element representations for each model

--A = (1,1);C = (1,-1); --CFN
A = (1,1);C = (1,-1);G = (-1,1); T = (-1,-1); --JC,K2P,K3P


--The list of coordinate indices for each model

--L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A)}-- CFN
--L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)};-- JC
--L = {(A,A,A),(A,C,C),(A,G,G),(C,A,C),(C,C,A),(C,G,T),(C,T,G),(G,A,G),(G,C,T),(G,G,A)}-- K2P
L = {(A,A,A),(A,C,C),(A,G,G),(A,T,T),(C,A,C),(C,C,A),(C,G,T),(C,T,G),(G,A,G),(G,C,T),
     (G,G,A),(G,T,C),(T,A,T),(T,C,G),(T,G,C),(T,T,A)}-- K3P


--The identification of coordinates for each model

--x = hashTable{A => 0, C => 1, G => 1, T => 1}--CFN
--x = hashTable{A => 0, C => 1, G => 1, T => 1}--JC
--x = hashTable{A => 0, C => 1, G => 2, T => 1}--K2P
x = hashTable{A => 0, C => 1, G => 2, T => 3}--K3P


--y = hashTable{A => 0, C => 1}--CFN
y = hashTable{A => 0, C => 1, G => 2, T => 3}--JC,K2P,K3P


--The coordinate ring for each model

L1 = toList apply(L,i->q_(y#(i#0),y#(i#1),y#(i#2)));

--The list of parameters for each model

--L2 = {a_0,a_1,b_0,b_1,c_0,c_1,e_0,e_1,f_0,f_1,g_0,g_1};--JC, CFN
 
--L2 = {a_0,a_1,a_2,b_0,b_1,b_2,c_0,c_1,c_2,
--    e_0,e_1,e_2,f_0,f_1,f_2,g_0,g_1,g_2};--K2P
  
L2 = {a_0,a_1,a_2,a_3,b_0,b_1,b_2,b_3,c_0,c_1,c_2,c_3,
      e_0,e_1,e_2,e_3,f_0,f_1,f_2,f_3,g_0,g_1,g_2,g_3};--K3P

--The ring of variables for each model
 
--R = QQ[(L2|L1), MonomialOrder=>Eliminate 12] --JC,CFN
--R = QQ[(L2|L1), MonomialOrder=>Eliminate 18] --K2P
R = QQ[(L2|L1), MonomialOrder=>Eliminate 24] --K3P
 
  
--The parameterization for the 3-leaf network 

Eqn_1 = toList apply(L,i->
q_(y#(i#0),y#(i#1),y#(i#2)) - 
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*
f_(x#(i#1))*g_(x#(i#1#0*i#2#0,i#1#1*i#2#1)) -
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*
e_(x#(i#1))*g_(x#(i#2)));

P_1 = toList apply(L,i->
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*
f_(x#(i#1))*g_(x#(i#1#0*i#2#0,i#1#1*i#2#1)) +
a_(x#(i#0))*b_(x#(i#1))*c_(x#(i#2))*
e_(x#(i#1))*g_(x#(i#2)));

--The parameteriztaion for the 3-leaf, 3-cycle network with no reticulation leaf edge

P_2 = toList apply(L,i->
a_(x#(i#0))*c_(x#(i#2))*
f_(x#(i#1))*g_(x#(i#1#0*i#2#0,i#1#1*i#2#1)) +
a_(x#(i#0))*c_(x#(i#2))*
e_(x#(i#1))*g_(x#(i#2)));

--The parameterization for the 3-leaf, 3-cycle network without one of the non-reticulation 
--leaves

P_3 = toList apply(L,i->
b_(x#(i#1))*c_(x#(i#2))*
f_(x#(i#1))*g_(x#(i#1#0*i#2#0,i#1#1*i#2#1)) +
b_(x#(i#1))*c_(x#(i#2))*
e_(x#(i#1))*g_(x#(i#2)));


--The Jacobian matrices
J1 = jacobian matrix{P_1};
J2 = jacobian matrix{P_2};
J3 = jacobian matrix{P_3};

--CFN, JC models
rank(J1) == #L
rank(J2) == #L
rank(J3) == #L

-- K2P Model
rank(J1) == #L

--K3P model------------------------------------------------------------------------------

I = ideal(q_(0,1,1)*q_(1,3,2)*q_(2,2,0)*q_(3,0,3)-q_(0,2,2)*q_(1,1,0)*q_(2,3,1)*q_(3,0,3)-
          q_(0,3,3)*q_(1,0,1)*q_(2,2,0)*q_(3,1,2)+q_(0,0,0)*q_(1,2,3)*q_(2,3,1)*q_(3,1,2)+
	  q_(0,3,3)*q_(1,1,0)*q_(2,0,2)*q_(3,2,1)-q_(0,0,0)*q_(1,3,2)*q_(2,1,3)*q_(3,2,1)-
	  q_(0,1,1)*q_(1,2,3)*q_(2,0,2)*q_(3,3,0)+q_(0,2,2)*q_(1,0,1)*q_(2,1,3)*q_(3,3,0))

isPrime(I)
rank(J1) == dim(I) - #L2 


--The single invariant can be found (after several hours) by running the code below.

--K = ideal(Eqn_1);
--time GG = selectInSubring(1,gens gb(K, DegreeLimit => 16))
--I = ideal(GG)



--K3P permutation
--These computations show the ideal I is independent of the labeling of the 3-leaf 3-cycle network
--By the symmetry in the network, we only need to check that the ideal is invariant when we swap
--the label of the reticulation leaf label (1) with one of the non-reticulation leavf labels (0).

T = {a_0,a_1,a_2,a_3,b_0,b_1,b_2,b_3,c_0,c_1,c_2,c_3,
    e_0,e_1,e_2,e_3,f_0,f_1,f_2,f_3,g_0,g_1,g_2,g_3};--K3P

--(01)

S01 = {q_(0,0,0),q_(1,0,1),q_(2,0,2),q_(3,0,3),
       q_(0,1,1),q_(1,1,0),q_(2,1,3),q_(3,1,2),
       q_(0,2,2),q_(1,2,3),q_(2,2,0),q_(3,2,1),
       q_(0,3,3),q_(1,3,2),q_(2,3,1),q_(3,3,0)}
   
s01 = map(R,R,matrix{(T|S01)})

I == s01(I)

