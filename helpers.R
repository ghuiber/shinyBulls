# libraries I'll need
library(ggplot2)
library(plyr)

# ggplot2 settings
theme_set(theme_gray() + theme(axis.text.x = element_text(angle = 90, hjust = 1)))

# draw density plot of paces
# argument is a list x, whose 1st element is the data to draw from
# and 2nd element is a text blurb that tells which years
drawPdens <- function(x) {
    df    <- x[[1]]
    tag   <- x[[2]]
    men   <- nrow(subset(df,Gender=='M'))
    women <- nrow(subset(df,Gender=='F'))
    count <- paste('(',prettyNum(men,big.mark=','),' male and ',
                   prettyNum(women,big.mark=','),' female runners)',sep='')
    tag <- paste('Minutes/mile',tag,sep=', ')
    tag <- paste(tag,count,'vertical lines at the means',sep='\n')
    mpace <- ddply(df, "Gender", summarise, 
                   pace.mean=mean(Pace),
                   pace.median=median(Pace),
                   age.mean=mean(Age),
                   age.median=median(Age))
    phist <- ggplot(df, aes(x=Pace, colour=Gender)) + 
        geom_density() + 
        geom_vline(data=mpace, aes(xintercept=pace.mean,  colour=Gender), size=1) + 
        ggtitle(tag)
    return(phist)
}

# draw a bar plot of age groups
# argument is a list x, whose 1st element is the data to draw from
# and 2nd element is a text blurb that tells which years
drawBarplots <- function(x) {
    df  <- x[[1]]
    tag <- x[[2]]
    men   <- nrow(subset(df,Gender=='M'))
    women <- nrow(subset(df,Gender=='F'))    
    layout(matrix(c(1,2), 1, 2, byrow = TRUE))
    barplot(table(subset(df,Gender=='M')$Group),
            las=2,main=paste("Males",tag,sep=", "),
            sub=paste(prettyNum(men,big.mark=','),'runners',sep=' '))
    barplot(table(subset(df,Gender=='F')$Group),
            las=2,main=paste("Females",tag,sep=", "),
            sub=paste(prettyNum(women,big.mark=','),'runners',sep=' '))
}

# Box plots of paces by age group, by gender
# argument x is a list whose 1st element is the data to draw from
# and 2nd element is a text blurb that tells which years
plotPace <- function(x) {
    df  <- x[[1]]
    tag <- x[[2]]
    yl <- "Pace (minutes / mile)"
    p  <- ggplot(aes(y = Pace, x = factor(Group), fill = factor(Gender)), 
                data = df) + geom_boxplot() + geom_jitter(alpha = 1/4) + ylab(yl) + 
        xlab("Age Group") + ggtitle(tag) + scale_fill_discrete(name="Gender")
    return(p)
}

# plot selector
# argument i is an integer, indicating which plot we want
# argument x is a list whose 1st element is the data to draw from
# and 2nd element is a text blurb that tells which years
plotIt <- function(i,x) {
    if(i==1) return(drawBarplots(x))
    else if(i==2) return(drawPdens(x))
    return(plotPace(x))
}
