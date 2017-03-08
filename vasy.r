library(dplyr)
library(stringr)
library(vkR)

source_url("https://gist.githubusercontent.com/paulokopny/63daf8ca42f9d842b122/raw/bf7c8f9f6944b44e7c791cb66f4919bd762f4dc9/vk.R")
# http://wardoctor.nosoc.io/public/paulokopny/vkauth/karepin.html - получаем код и подставляем в code

vk <- get.vk.connector(code = "КОД ПОЛУЧИТЬ ПО ССЫЛКЕ ВЫШЕ", app = "karepin", debug = T) 
setAccessToken(access_token='ТОКЕН ИЗ ПРЕДЫДУЩЕЙ ФУНКЦИИ')

vkOAuth(5585217, 'groups', 'ЗДЕСЬ СВОЮ ПОЧТУ ОТ ВК', 'ПАРОЛЬ')


get_wall2500 <- function(owner_id='', domain=NULL, offset=0, max_count=100, filter='all', extended='0', v='5.29') {
  if (max_count == 0) max_count <- 2500
  
  owner <- ifelse(!is.null(domain), paste0('"domain":"', domain, '"'), paste0('"owner_id":', owner_id))
  
  if (max_count <= 100) {
    execute(paste0('return API.wall.get({',
                   owner, ', 
                   "offset":', offset, ', 
                   "count":', max_count, ',
                   "filter":', '"', filter, '"', ',
                   "extended":', extended, ',
                   "v":', v, '}).items;'))
} else {
  code <- 'var wall_records = [];'
  code <- paste0(code, 'wall_records = wall_records + 
                 API.wall.get({',
                 owner, ', 
                 "offset":', offset, ', 
                 "count": 100,
                 "filter":', '"', filter, '"', ',
                 "extended":', extended, ',
                 "v":', v, '}).items;')
  
  code <- paste0(code, 'var offset = 100 + ', offset, ';
                 var count = 100; var max_offset = offset + ', max_count, ';
                 while (offset < max_offset && wall_records.length <= offset && offset-', offset, '<', max_count, ') {
                 if (', max_count, ' - wall_records.length < 100) {
                 count = ', max_count, ' - wall_records.length;
                 };
                 wall_records = wall_records + API.wall.get({',
                 owner, ', 
                 "offset": offset, 
                 "count": count,
                 "filter":', '"', filter, '"', ',
                 "extended":', extended, ',
                 "v":', v, '}).items;
                 offset = offset + 100;
                 };
                 return wall_records;')
  
  execute(code)
}
  }
# Получить список всех постов со стены
get_all_posts <- function(owner_id='', domain=NULL, filter='all', extended='1', v='5.29') {
  offset <- 0
  delay_counter <- 0
  count_per_request <- 2500
  all_posts <- list()
  
  repeat
  {
    messages <- get_wall2500(owner_id = owner_id, 
                             domain = domain, 
                             offset = offset, 
                             max_count = count_per_request,
                             filter = filter,
                             extended = extended,
                             v = v)
    
    if (length(messages) <= 0) break
    
    if (!is.null(messages)) {
      for (i in 1:nrow(messages))
      {
        post <- vkPost(messages[i, ])
        all_posts <- append(all_posts, list(post))
      }
    }
    
    offset <- offset + count_per_request
    delay_counter <- delay_counter + 1
    if (delay_counter %% 3 == 0)
      Sys.sleep(1.0)
  }
  
  all_posts
}
# texts <- sapply(all_posts, function(post) post$text)
x = get_all_posts(owner_id = "-94119361")

#dump = profiles
profiles = sapply(1:length(x), function(z){as.data.frame(t(unlist(x[[z]])))})
profiles = do.call(plyr::rbind.fill, profiles) 
profiles = as.data.frame(profiles, stringsAsFactors = F)
#profiles2 = profiles %>% select(id:reposts.user_reposted)
#write_csv(profiles, "~/vasy_shava.csv")



polls_answ = select_(profiles, lazyeval::interp(~matches(x), x = "attachments.poll.answers.id"))
polls_answ[] <- lapply(polls_answ, as.character) 
polls_answ$new <- apply( polls_answ , 1 , paste , collapse = " " )
polls_answ$new = str_replace_all(polls_answ$new, "NA", "")
polls_answ$new = str_trim(polls_answ$new)
polls_answ$new = str_replace_all(polls_answ$new, " +", "%2C")


polls_id = select_(profiles, lazyeval::interp(~matches(x), x = "attachments.poll.id"))
polls_id[] <- lapply(polls_id, as.character) %>% lapply(as.numeric)

polls_id = apply(polls_id,1,sum,na.rm=TRUE)
polls_id = data.frame(polls_id = polls_id, polls_answ = polls_answ$new)
polls_id$polls_answ = as.character(polls_id$polls_answ)




polls.getVoters = function(vk.get_data, owner_id, poll_id, answer_ids, offset=0, count=1000, friends_only = 0, is_board = 1) {
  print("Waiting...")
  Sys.sleep(1)
  print("Getting posts...")
  return(vk.get_data(method="polls.getVoters", owner_id=owner_id, poll_id=poll_id, answer_ids=answer_ids, offset=offset, count=count, friends_only=friends_only, is_board=is_board))
}



voters = data.frame()

for (i in 1:nrow(polls_id)) {
  x = polls_id[i,1]
  y = polls_id[i,2]
  if (x != 0) {
    temp = polls.getVoters(vk, owner_id = c(-94119361), poll_id=x, answer_ids=y, is_board = 0, offset = 0, count = 1000) 
    if (length(temp) !=0) {
      temp = sapply(1:length(temp), function(z){as.data.frame(t(unlist(temp[[z]])))})
      temp = do.call(plyr::rbind.fill, temp) 
      temp = as.data.frame(temp, stringsAsFactors = F)
      
      df3 = temp[,-1]
      df3 = df3[,-1] #%>% select(-users)
      df3$new <- apply( df3 , 1 , paste , collapse = " " )
      df3$new = str_replace_all(df3$new, "NA", "")
      df3$new = str_trim(df3$new)
      df3$new = str_replace_all(df3$new, " +", ",")
      
      temp2= data.frame(polls_id = polls_id[i,1], answer_id = temp$answer_id, num_voted = temp$users1, 
                        users = df3$new)
      #if (nrow(temp) > 2) break
      voters = plyr::rbind.fill(voters, temp2)
      Sys.sleep(5)
      
    }
    Sys.sleep(2)
  }
  Sys.sleep(1)
}


