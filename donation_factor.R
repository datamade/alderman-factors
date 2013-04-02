library(RMySQL)
library(Matrix)
library(ape)

con <- dbConnect(MySQL(), dbname="contributions")

donors <- dbGetQuery(con, paste("SELECT ",
                                "CONCAT_WS(' ', ",
                                "          donors.first_name, ",
                                "          donors.last_name) ",
                                "AS name, ",
                                "recipient_id, ",
                                "donation_totals.totals AS totals ",
                                "FROM donors INNER JOIN ",
                                "(SELECT ",
                                " canon_id, ",
                                " recipient_id, ",
                                " sum(amount) AS totals ",
                                " FROM contributions INNER JOIN ",
                                " (SELECT ",
                                "  IFNULL(canon_id, donor_id) AS canon_id, ",
                                "  donor_id ",
                                "  FROM entity_map ",
                                "  RIGHT JOIN donors ",
                                "  USING(donor_id)) as e_map ", 
                                " USING (donor_id) ",
                                " GROUP BY canon_id, recipient_id) ",
                                "AS donation_totals ",
                                "WHERE donors.donor_id = donation_totals.canon_id"))




dbDisconnect(con)

council_committees = c(
  22749, # arena, john
  11884, 11885, # austin, carrie
  17491, # balcer, james
  14556, # beale, anthony
  17003, 20626, # brookins, jr., howard
  4410,  # burke, edward
  10591, # burnett, jr., walter
  20749, # burns, william
  19747, # cappleman, james
  17290, # cardenas, george
  23005, 14947,  # chandler, michael
  19880, # cochran, willie
  17037, 18010, # colon, rey
  23111, # cullerton, tim
  16892, # dowell, pat
  23112, # ervin, jason
  19819, 21102, # fiorreti, bob
  20107, # foulkes, toni
  16505, # graham, deborah
  14216, # hairston, leslie
  20016, # harris, michelle
  20052, # jackson, sandi
  20015, # lane, lona
  9808, # laurino, margaret
  9533, # maldonado, robert
  4317, # mell, richard
  15622, # mitts, emma
  6380, # moore, joe
  20809, # moreno, joe
  9487, # munoz, ricardo
  20673, # oconnor, mary
  4353, # oconnor, patrick
  22919, # oshea, matthew
  14971, 22976, # osterman, harry
  23607, 22524, # pawar, ameya
  19733, 14501, # pope, john
  23282, # quinn, marty
  17163, # reboyras, ariel
  19263, # reilly, brendan
  22875, # sawyer, roderick
  22982, # silverstein, debra
  19682, # smith, michelle
  12260, # solis, danny
  19830, # sposato, nicholas
  6555, 14968, # suarez, regner
  15729, # thomas, latasha
  16425, # thompson, joann
  17150, # tunney, thomas
  19898, # waguespack, scott
  14156 # zalewski, mike
  )

last_names <- c("Mell", "O'Connor", "Burke", "Moore", "Suarez",
"Munoz", "Maldonado", "Laurino", "Burnett", "Austin", "Solis",
"Zalewski", "Hairston", "Pope", "Beale", "Chandler", "Osterman",
"Mitts", "Thomas", "Thompson", "Graham", "Dowell", "Brookins",
"Colon", "Tunney", "Reboyras", "Cardenas", "Balcer", "Reilly",
"Smith", "Cappleman", "Sposato", "Cochran", "Waguespack", "Lane",
"Harris", "Jackson", "Foulkes", "Mary O'Connor", "Burns", "Moreno",
"Fioretti", "Pawar", "Arena", "Sawyer", "O'Shea", "Silverstein",
"Cullerton", "Ervin", "Quinn")

council_donors <- donors[donors$recipient_id %in% council_committees, ]

council_donors[council_donors$recipient_id == 11885, 'recipient_id'] <- 11884
council_donors[council_donors$recipient_id == 20626, 'recipient_id'] <- 17003
council_donors[council_donors$recipient_id == 23005, 'recipient_id'] <- 14947
council_donors[council_donors$recipient_id == 18010, 'recipient_id'] <- 17037
council_donors[council_donors$recipient_id == 19819, 'recipient_id'] <- 21102
council_donors[council_donors$recipient_id == 22976, 'recipient_id'] <- 14971
council_donors[council_donors$recipient_id == 23607, 'recipient_id'] <- 22524
council_donors[council_donors$recipient_id == 19733, 'recipient_id'] <- 14501
council_donors[council_donors$recipient_id == 14968, 'recipient_id'] <- 6555


donor_names <- table(council_donors$name)

council_donors$name <- factor(council_donors$name)
council_donors$recipient_id <- factor(council_donors$recipient_id)

M <- sparseMatrix(i=as.numeric(council_donors$name),
                  j=as.numeric(council_donors$recipient_id))

# this fit is probabaly the data object that we would want to
# serialize to feed to d3
fit <- hclust((dist(t(M), method="binary")-0.95)/0.05, method="ward")

fit$labels <- last_names

pdf()

plot(as.phylo(fit), type="fan")

dev.off()

