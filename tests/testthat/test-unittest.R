library(STRExpansionAnalyzer)
test_that("load dataset", {
  data("ShortTandemRepeatsLoci")
  expect_type(ShortTandemRepeatsLoci, "list")
})

test_that("dataframe variables created correctly", {
  df <- STRExpansionAnalyzer::createVariables(ShortTandemRepeatsLoci, 0.1)
  expect_equal(ncol(df), 12)
})

test_that("load dataset from inst/extdata file", {
  fpath <- system.file("extdata", "str_data.txt", package="STRExpansionAnalyzer")
  mydf <- STRExpansionAnalyzer::readIntoDF(fpath)
  mydf <- STRExpansionAnalyzer::createVariables(mydf, 0.1)
  expect_equal(ncol(df), 12)
})
