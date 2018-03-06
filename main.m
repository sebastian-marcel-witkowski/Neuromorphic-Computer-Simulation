%initialize matrices
weights = rand(25,10);
Vout1 = zeros(1,10);
%train weights
for ii = 1:30000
    Vout1 = SortedScaledTrainingImages(ii,:)*weights;
    Vout1 = Vout1/norm(Vout1,inf);
    for jj = 1:10
        if ((jj-1)==SortedTrainingLabels(ii)) && (Vout1(jj) < 0.75)
            %if at correct output voltage pin and voltage is less than
            %threshold, scale all weights corresponding to Vin pins with
            %voltage > 0 up, and all others in the column down
            for kk = 1:25
                if SortedScaledTrainingImages(ii,kk) >=0.25
                    weights(kk,jj) = weights(kk,jj)*1.3;
                else
                    weights(kk,jj) = weights(kk,jj)*0.875;
                end
            end
        end
    end
      
end
weights = weights/norm(weights,inf);

Correct = zeros(10,1);
DigitTally = zeros(10,1);
for ii = 1:10000
    digit = int8(SortedTestLabels(ii));
    DigitTally(digit+1) = DigitTally(digit+1)+1;
    Vout1 = SortedScaledTestImages(ii,:)*weights;
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

