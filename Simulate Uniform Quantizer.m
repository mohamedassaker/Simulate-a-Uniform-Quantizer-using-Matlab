%Mohamed Assaker 46-1370  T7
%Reem Osama      46-0688  T7
%Waad Mohamed    46-5078  T7
%Mohamed Samir   46-17946 T4

clc
clear all
close all

a = 9;
sampled = -a + (a+a)*rand(1,10000);
L1 = 2;
L2 = 4;
L3 = 8;

delta1 = 2*a/L1;
delta2 = 2*a/L2;
delta3 = 2*a/L3;

Xs1 = -a:delta1:a;
Xs2 = -a:delta2:a;
Xs3 = -a:delta3:a;

Xq1 = -a+delta1/2:delta1:a-delta1/2;
Xq2 = -a+delta2/2:delta2:a-delta2/2;
Xq3 = -a+delta3/2:delta3:a-delta3/2;

quantized2 = zeros(1,10000);
quantized4 = zeros(1,10000);
quantized8 = zeros(1,10000);

for i = 1 : length(sampled)
     for j = 1 : length(Xs1)
         if(sampled(i)>Xs1(j) && sampled(i)<Xs1(j+1))
             quantized2(i) = Xq1(j);
         end
     end
end
 
for i = 1 : length(sampled)
     for j = 1 : length(Xs2)
         if(sampled(i)>Xs2(j) && sampled(i)<Xs2(j+1))
             quantized4(i) = Xq2(j);
         end
     end
end
 
for i = 1 : length(sampled)
     for j = 1 : length(Xs3)
         if(sampled(i)>Xs3(j) && sampled(i)<Xs3(j+1))
             quantized8(i) = Xq3(j);
         end
     end
end

%Display the first six elements from the original and the quantized vectors
Sampled_First_6_elements = sampled(1:6)
Quantized2_First_6_elements = quantized2(1:6)
Quantized4_First_6_elements = quantized4(1:6)
Quantized8_First_6_elements = quantized8(1:6)

%Error of each level
Error2 = quantized2-sampled;
Error4 = quantized4-sampled;
Error8 = quantized8-sampled;

%Mean of each error for each level
Mean_Error2 = mean(abs(Error2));
Mean_Error4 = mean(abs(Error4));
Mean_Error8 = mean(abs(Error8));

L = [2 4 8];

%Plot of mean error
plot(L,[Mean_Error2 Mean_Error4 Mean_Error8]);%As the levels increase, the mean of error decreases
title('Mean of Error');xlabel('Level'); ylabel('Mean');
txt={'As the levels increase, the mean of ';'error decreases'};text(4,2,txt);

%Variance of each error for each level
Variance_Error2 = var(Error2);
Variance_Error4 = var(Error4);
Variance_Error8 = var(Error8);

figure();plot(L,[Variance_Error2 Variance_Error4 Variance_Error8]);
title('Variance of Error');xlabel('Level'); ylabel('Variance');

%Theortical Variance of each error for each level
Theortical_Variance_Error2 = power(delta1,2)/12;
Theortical_Variance_Error4 = power(delta2,2)/12;
Theortical_Variance_Error8 = power(delta3,2)/12;

hold on 
%As the levels increase, the variance of error decreases. 
% The Variance is better than Therotical Variance
plot(L , [Theortical_Variance_Error2 Theortical_Variance_Error4 Theortical_Variance_Error8]);
legend('Variance Error','Theortical Variance Error');
txt={'As the levels increase, the variance of error decreases.'};
text(3,5,txt);

%SQNR
SQNR2 = power(a,2)/Variance_Error2;
SQNR4 = power(a,2)/Variance_Error4;
SQNR8 = power(a,2)/Variance_Error8;

figure();hold on
plot(L ,[SQNR2 SQNR4 SQNR8]);

Therotical_SQNR2 = 3*power(L1,2);
Therotical_SQNR4 = 3*power(L2,2);
Therotical_SQNR8 = 3*power(L3,2);
plot(L ,[Therotical_SQNR2 Therotical_SQNR4 Therotical_SQNR8]);
title('SQNR');xlabel('Level'); ylabel('SQNR');
legend('SQNR','Theortical SQNR');
txt={'As the levels increase, the SQNR increases'};
text(2.5,160,txt);
%As the levels increase, the SQNR increases