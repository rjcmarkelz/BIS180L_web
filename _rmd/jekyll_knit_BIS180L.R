setwd("~/git/BIS180L_web/_posts/")
library(knitr)


jekyll.knit <- function(input) {
    rel.path = substr(input, 5, nchar(input) - 4)
    output = paste("_posts/", rel.path, ".md", sep = "")
    knit(input = input, output = output)
    system(paste("perl -pi -e 's|image/|{{ site.figurl }}/|gi'", output, sep = " "))
}
# .Rmd files in _rmd directory
# Usage example:
# jekyll.knit("_rmd/2013-XX-XX-post-name.Rmd")
 jekyll.knit("_rmd/2013-05-01-Text-Searches-Regular-Expressions-Answers.Rmd")

