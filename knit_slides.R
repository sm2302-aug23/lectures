lecture_files <- dir(pattern = "\\.R[nm][wd]$")
lecture_names <- gsub(".Rmd", "", lecture_files)

for (i in seq_along(lecture_files)) {  #
  # Render regular version -----------------------------------------------------
  rmarkdown::render(
    lecture_files[i],
    params = list(handout = NULL),
    output_file = paste0(lecture_names[i], ".pdf"),
    envir = new.env()
  )

  # Render handout version -----------------------------------------------------
  # rmarkdown::render(
  #   lecture_files[i],
  #   params = list(handout = TRUE),
  #   output_file = paste0("handouts/", lecture_names[i], "_handout.pdf"),
  #   envir = new.env()
  # )
}

file.remove(list.files(pattern = "*.log"))
