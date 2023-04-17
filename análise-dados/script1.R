attach(aulas)

options(max.print = 40000)

head(section_id)

section_id

sort(section_id)

aulas[33137,3]<- 3255

sort(aulas$section_id)

aulas_unicas <- unique(aulas$section_id)

length(aulas_unicas)

hist(aulas$section_id)

shapiro.test(unique(aulas$section_id))

t.test(unique(aulas$section_id))

tabela <- table(aulas$section_id)

sort(tabela)


tabela1 <- table(aulas$course_id)

sort(tabela1)

install.packages("plyr")

library(plyr)
auxiliar <- count(aulas, vars = "course_id")
write.csv(auxiliar, "popularidade.csv")







