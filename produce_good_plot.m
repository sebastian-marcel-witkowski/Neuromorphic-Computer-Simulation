Correct = zeros(10,1);
DigitTally = zeros(10,1);
for ii = 1:10000
    digit = int8(SortedTestLabels(ii));
    DigitTally(digit+1) = DigitTally(digit+1)+1;
    Vout1 = SortedScaledTestImages(ii,:)*GoodWeights;
    Vout1 = Vout1/norm(Vout1,inf);
    if Vout1(digit+1)>0.75  %Vout1(digit+1) == Vmax;
        Correct(digit+1) = Correct(digit+1)+1;
    end
end
PercentCorrect = zeros(10,1);
for ii = 1:10
    PercentCorrect(ii) = Correct(ii)/DigitTally(ii);
end
x = 0:9;
figure(3);
title('Proportion of Correct Number Identification');
xlabel('Image Label');
ylabel('Percent Correct');
bar(x,PercentCorrect);
