# An optional custom script to run before Hugo builds your site.
# You can delete it if you do not need it.
install.packages(c("ggplot2", "palmerpenguins", "car", "prettydoc"))

blogdown::build_dir('static')

latex_files <- list.files('static', pattern = ".*TD_.*.tex",
                          recursive = TRUE, full.names = TRUE)
for (f in latex_files) {
  xfun::Rscript_call(knitr::knit2pdf,
                     list(input = f, output = f,
                          envir = globalenv(), quiet = TRUE),
                     fail = c("Failed to render ", f))
}
