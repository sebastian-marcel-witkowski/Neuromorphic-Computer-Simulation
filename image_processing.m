%Generate MNIST training and test image data for simulation
%Code borrowed from ufldl.stanford.edu
RawTrainingImages = loadMNISTImages('train-images.idx3-ubyte');
TrainingLabels = loadMNISTLabels('train-labels.idx1-ubyte');
RawTestImages = loadMNISTImages('t10k-images.idx3-ubyte');
TestLabels = loadMNISTLabels('t10k-labels.idx1-ubyte');

%resize and scale image data to be [(5x5)x #images]
ScaledTrainingImages = zeros(25,30000);
ScaledTestImages = zeros(25,10000);
RawBuffer = rand(28,28);
ScaledBuffer = rand(5,5);
%resize training images
for ii = 1:30000
   RawBuffer = reshape(RawTrainingImages(:,ii),28,28);
   ScaledBuffer = imresize(RawBuffer,[5,5],'nearest');
   ScaledTrainingImages(:,ii)=reshape(ScaledBuffer,25,1);
end
figure(1);
title('25 Unscaled 28x28 MNIST Image Members');
display_network(RawTrainingImages(:,1:25))
figure(2);
title('25 Scaled 5x5 MNIST Image Members');
display_network(ScaledTrainingImages(:,1:25));
%resize test images
for ii = 1:10000
   RawBuffer = reshape(RawTestImages(:,ii),28,28);
   ScaledBuffer = imresize(RawBuffer,[5,5],'nearest');
   ScaledTestImages(:,ii)=reshape(ScaledBuffer,25,1);
end
ScaledTrainingImages = ScaledTrainingImages';
ScaledTestImages = ScaledTestImages';

SortedScaledTestImages = zeros(10000,25);
SortedScaledTrainingImages = zeros(30000,25);
SortedTestLabels = zeros(10000,1);
SortedTrainingLabels = zeros(30000,1);
sortcount = 1;
TrainingDigitTally = zeros(10,1);
TestDigitTally = zeros(10,1);
for ii = 0:9
    for jj = 1:30000
        digit = int8(TrainingLabels(jj));
        if digit == ii
            TrainingDigitTally(ii+1) = TrainingDigitTally(ii+1)+1;
            SortedScaledTrainingImages(sortcount,:) = ScaledTrainingImages(jj,:);
            SortedTrainingLabels(sortcount,1) = TrainingLabels(jj);
            sortcount = sortcount+1;
        end
        
    end
end
sortcount = 1;
for ii = 0:9
    for jj = 1:10000
        digit = int8(TestLabels(jj));
        if digit == ii
            TestDigitTally(ii+1) = TestDigitTally(ii+1)+1;
            SortedScaledTestImages(sortcount,:) = ScaledTestImages(jj,:);
            SortedTestLabels(sortcount,1) = TestLabels(jj);
            sortcount = sortcount+1;
        end
        
    end
end
%Export Image data as ASCII files for use in Cadence Simulations
% dlmwrite('Training Images', TrainingImages);
% dlmwrite('Training Labels', TrainingLabels);
% dlmwrite('Test Images', TestImages);
% dlmwrite('Test Labels', TestLabels);
% display_network(TrainingImages(:,1:100)); % Show the first n images
% display_network(TestImages(:,1:100)); % Show the first n images
%disp(TrainingLabels(1:100));