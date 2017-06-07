classdef Adaboost < handle
    properties
        trained;
        classifier;
        weak_classifiers;
        alphas;
        num_classifiers;
        num_classes;
        label_map;
    end
    methods
        function obj = Adaboost(classifier)
            obj.trained = false;
            obj.classifier = classifier;
            obj.weak_classifiers = {};
            obj.alphas = [];
            obj.num_classifiers = 0;
            obj.num_classes = 0;
            obj.label_map = [];
        end
        b_train(obj, data, labels, num_iters, class_num);
        train(obj, data, labels, num_iters);
        error_pct = test(obj, test_data, test_labels);
        pred_labels = classify(obj, data);
        
    end
end

        

