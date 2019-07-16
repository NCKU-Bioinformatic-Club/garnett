context("test-overall.R")

library(org.Hs.eg.db)
data(test_cds)

set.seed(260)
test_classifier <- train_cell_classifier(cds = test_cds,
                                         marker_file = "../pbmc_test.txt",
                                         db=org.Hs.eg.db,
                                         min_observations = 10,
                                         cds_gene_id_type = "SYMBOL",
                                         num_unknown = 50,
                                         marker_file_gene_id_type = "SYMBOL")

test_cds <- garnett::classify_cells(test_cds, test_classifier,
                                    db = org.Hs.eg.db,
                                    rank_prob_ratio = 1.5,
                                    cluster_extend = TRUE,
                                    cds_gene_id_type = "SYMBOL")

test_that("whole process is the same", {
  expect_equal(sum(colData(test_cds)$cell_type == "B cells"), 147)
  expect_equal(sum(colData(test_cds)$cell_type == "CD4 T cells"), 87)
  expect_equal(sum(colData(test_cds)$cell_type == "CD8 T cells"), 45)
  expect_equal(sum(colData(test_cds)$cell_type == "T cells"), 121)
  expect_equal(sum(colData(test_cds)$cluster_ext_type == "B cells"), 403)
  expect_equal(sum(colData(test_cds)$cluster_ext_type == "CD4 T cells"), 205)
  expect_equal(sum(colData(test_cds)$cluster_ext_type == "T cells"), 192)
})


#test_cds <- new_cell_data_set(as.matrix(counts(test_cds)),
#                           cell_metadata = colData(test_cds),
#                          gene_metadata = rowData(test_cds))
#test_cds <- estimate_size_factors(test_cds)


#set.seed(260)
#test_classifier <- train_cell_classifier(cds = test_cds,
#                                         marker_file = "../pbmc_test.txt",
#                                         db=org.Hs.eg.db,
#                                         min_observations = 10,
#                                         cds_gene_id_type = "SYMBOL",
#                                         num_unknown = 50,
#                                         marker_file_gene_id_type = "SYMBOL")

#test_cds <- garnett::classify_cells(test_cds, test_classifier,
#                                    db = org.Hs.eg.db,
#                                    rank_prob_ratio = 1.5,
#                                    cluster_extend = TRUE,
#                                    cds_gene_id_type = "SYMBOL")

#test_that("whole process is the same matrix", {
#  expect_equal(sum(colData(test_cds)$cell_type == "B cells"), 147)
#  expect_equal(sum(colData(test_cds)$cell_type == "CD4 T cells"), 87)
#  expect_equal(sum(colData(test_cds)$cell_type == "CD8 T cells"), 45)
#  expect_equal(sum(colData(test_cds)$cell_type == "T cells"), 121)
#  expect_equal(sum(colData(test_cds)$cluster_ext_type == "B cells"), 403)
#  expect_equal(sum(colData(test_cds)$cluster_ext_type == "CD4 T cells"), 205)
#  expect_equal(sum(colData(test_cds)$cluster_ext_type == "T cells"), 192)
#  expect_is(counts(test_cds), "matrix")
#})

data(test_cds)
set.seed(260)
test_classifier <- train_cell_classifier(cds = test_cds,
                                         marker_file = "../pbmc_test.txt",
                                         db=org.Hs.eg.db,
                                         min_observations = 10,
                                         cds_gene_id_type = "SYMBOL",
                                         num_unknown = 50,
                                         cores = 2,
                                         marker_file_gene_id_type = "SYMBOL")

test_cds <- garnett::classify_cells(test_cds, test_classifier,
                                    db = org.Hs.eg.db,
                                    rank_prob_ratio = 1.5,
                                    cluster_extend = TRUE,
                                    cds_gene_id_type = "SYMBOL")

test_that("whole process is the same multi-core", {
  expect_equal(sum(colData(test_cds)$cell_type == "B cells"), 147)
  expect_equal(sum(colData(test_cds)$cell_type == "CD4 T cells"), 87)
  expect_equal(sum(colData(test_cds)$cell_type == "CD8 T cells"), 45)
  expect_equal(sum(colData(test_cds)$cell_type == "T cells"), 121)
  expect_equal(sum(colData(test_cds)$cluster_ext_type == "B cells"), 403)
  expect_equal(sum(colData(test_cds)$cluster_ext_type == "CD4 T cells"), 205)
  expect_equal(sum(colData(test_cds)$cluster_ext_type == "T cells"), 192)
})

data(test_cds)
set.seed(260)
test_classifier <- train_cell_classifier(cds = test_cds,
                                         marker_file = "../pbmc_test.txt",
                                         db='none',
                                         min_observations = 10,
                                         cds_gene_id_type = "SYMBOL",
                                         num_unknown = 50,
                                         cores = 2,
                                         marker_file_gene_id_type = "SYMBOL")

test_cds <- garnett::classify_cells(test_cds, test_classifier,
                                    db = 'none',
                                    rank_prob_ratio = 1.5,
                                    cluster_extend = TRUE,
                                    cds_gene_id_type = "SYMBOL")

test_that("whole process is the same db = 'none'", {
  expect_equal(sum(colData(test_cds)$cell_type == "B cells"), 153)
  expect_equal(sum(colData(test_cds)$cell_type == "CD4 T cells"), 83)
  expect_equal(sum(colData(test_cds)$cell_type == "CD8 T cells"), 41)
  expect_equal(sum(colData(test_cds)$cell_type == "T cells"), 123)
  expect_equal(sum(colData(test_cds)$cluster_ext_type == "B cells"), 403)
  expect_equal(sum(colData(test_cds)$cluster_ext_type == "CD4 T cells"), 205)
  expect_equal(sum(colData(test_cds)$cluster_ext_type == "T cells"), 192)
})
