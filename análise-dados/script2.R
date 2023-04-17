library(plyr)
duracao <- rename(duracao, replace = c("user_id"="aluno", "course_id"="curso", "timeToFinish"="dias"))
plot(duracao$dias)

jpeg("imagem_histograma.jpg")
hist(duracao$dias, breaks = 20, main = "Histograma do tempo", ylab = "Quantidade", xlab = "Tempo", ylim = c(0, 2000), col = "blue")
dev.off()

mean(duracao$dias, na.rm = TRUE)
median(duracao$dias, na.rm = TRUE)
summary(duracao$dias)

dim(duracao)[1]

3828/6366

length(unique(duracao$curso))

length(unique(duracao$aluno))


sumario_estatistico <- aggregate(duracao$dias, list(duracao$curso), mean, na.rm = T)
sumario_estatistico <- rename(sumario_estatistico, replace = c('Group.1'='curso', 'x'='dias'))
popularidade <- rename(popularidade, c('course_id' = 'curso'))
popularidade <- rename(popularidade, c('freq' = 'popularidade'))
popularidade_e_duracao <- merge(sumario_estatistico, popularidade, by = 'curso')

plot(popularidade_e_duracao$dias, popularidade_e_duracao$popularidade)

modelo.linear <- lm(popularidade_e_duracao$popularidade~popularidade_e_duracao$dias)

abline(modelo.linear)


help('pch')
plot(popularidade_e_duracao$dias, popularidade_e_duracao$popularidade)
scatter.smooth(popularidade_e_duracao$dias, popularidade_e_duracao$popularidade
               , pch='.', col='blue')

scatter.smooth(popularidade_e_duracao$dias, popularidade_e_duracao$popularidade
               , pch=21, col='blue')


install.packages('ggplot2')
library(ggplot2)
grafico <- ggplot(popularidade_e_duracao, aes(dias, popularidade))
grafico
grafico <- grafico + geom_point()
grafico
grafico <- grafico + geom_smooth()
grafico















