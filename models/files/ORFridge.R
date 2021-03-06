modelInfo <- list(label = "Oblique Random Forest",
                  library = "obliqueRF",
                  loop = NULL,
                  type = c("Classification"),
                  parameters = data.frame(parameter = "mtry",
                                          class = "numeric",
                                          label = "#Randomly Selected Predictors"),
                  grid = function(x, y, len = NULL, search = "grid"){
                    if(search == "grid") {
                      out <- data.frame(mtry = caret::var_seq(p = ncol(x), 
                                                              classification = is.factor(y), 
                                                              len = len))
                    } else {
                      out <- data.frame(mtry = unique(sample(1:ncol(x), size = len, replace = TRUE)))
                    }
                    out
                  },
                  fit = function(x, y, wts, param, lev, last, classProbs, ...) 
                    obliqueRF::obliqueRF(as.matrix(x), y, training_method = "ridge", ...),
                  predict = function(modelFit, newdata, submodels = NULL)
                    predict(modelFit, newdata),
                  prob = function(modelFit, newdata, submodels = NULL)
                    predict(modelFit, newdata, type = "prob"),
                  levels = function(x) x$obsLevels,
                  tags = c("Random Forest", "Oblique Tree", "Ridge Regression", 
                           "Implicit Feature Selection", "Ensemble Model", "Two Class Only",
                           "L2 Regularization"),
                  sort = function(x) x[order(x[,1]),])
