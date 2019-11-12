predY = load('predy_for_classification.csv');
predX = load('predx_for_classification.csv');


label = load('label.csv');
label1 = label(:,1);
label2 = label(:,2);
label3 = label(:,3);
label4 = label(:,4);
label5 = label(:,5);

head_node = node;

features = [predX predY];
head_node.fit(features, label1);
