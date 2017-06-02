classdef Adaboost < handle
    properties(Access = private)
        trained;
        classifier;
        weak_classifiers;
        num_classifiers;
        alphas;
    end
    methods
        function obj = Adaboost(classifier)
            obj.trained = false;
            obj.classifier = classifier;
            obj.weak_classifiers = {};
            obj.alphas = [];
        end
        [weak_classifiers, alphas] = train(obj, data, labels, num_iters);
        error_pct = test(obj, test_data, test_labels);
        
    end
end

        

