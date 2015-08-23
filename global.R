library(data.table)
library(dplyr)

# Load 2014 loan data
notes <- fread("LoanStats3c_securev1.csv")
notes <- tbl_df(transform(notes, 
                          int_rate = as.numeric(gsub("%", "", int_rate)),
                          revol_util = as.numeric(gsub("%", "", revol_util)),
                          revol_bal = as.numeric(revol_bal),
                          installment = as.numeric(gsub("%", "", installment)),
                          loan_amnt = as.numeric(loan_amnt),
                          total_acc = as.numeric(total_acc),
                          dti = as.numeric(dti),
                          fico_range_low = as.numeric(fico_range_low),
                          fico_range_high = as.numeric(fico_range_high),
                          annual_inc = as.numeric(annual_inc)))

# Create Factors
notes$grade <- as.factor(notes$grade)
notes$sub_grade <- as.factor(notes$sub_grade)
notes$loan_status <- as.factor(notes$loan_status)
notes$purpose <- as.factor(notes$purpose)

# Filter note data to fully paid and charged off and make it a factor variable
notes_charged_full_paid <- notes %>% 
    filter(loan_status == "Fully Paid" | loan_status == "Charged Off") %>%
    mutate(loan_status = as.factor(loan_status))

selectableData <- names(notes_charged_full_paid)[sapply(notes_charged_full_paid, class) == "numeric"]

# Helper function for rendering Rmd to html
# Source: https://github.com/vnijs/shiny-site/blob/master/global.R
inclRmd <- function(path, r_env = parent.frame()) {
    paste(readLines(path, warn = FALSE), collapse = '\n') %>%
        knitr::knit2html(text = ., fragment.only = TRUE, envir = r_env,  options = "",
                         stylesheet = "") %>%
        gsub("&lt;!--/html_preserve--&gt;","",.) %>%  ## knitr adds this
        gsub("&lt;!--html_preserve--&gt;","",.) %>%   ## knitr adds this
        HTML
}
