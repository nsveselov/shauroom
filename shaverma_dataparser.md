

```python
import json
from urllib.request import urlopen
from bs4 import BeautifulSoup
import requests
import re
import os
import pandas as pd
import math
import time
import numpy
import pickle
```


```python
### пункт 1 ###
# выполить в адресной строке браузера и скопировать code
# https://oauth.vk.com/authorize?client_id=5931348&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=wall&response_type=code&v=5.62&state=123456

### пункт 2 ###
# вставить полученный code, выполнить команду
requests.get("https://oauth.vk.com/access_token?client_id=5931348&client_secret=TNErTj22HPljiUMRoCOK&redirect_uri=https://oauth.vk.com/blank.html&code=e8dae585e724d9232b").text
# скопировать полученный token_access
# вставить его в my_token
```


```python
my_token = "6aded212b1fbcd5db324c5f919459e83b92632ead34b90e3646a7232829f6c535bbecff43ad5dcd25b2b1"
my_id = "26193880"
group_id = 'topdonerspb'
group_id2 = "-94119361"
```


```python
wall_get = 'https://api.vk.com/method/wall.get?domain=' + group_id + "&count=1"
post_number = json.loads(requests.get(wall_get).text)['response'][0]
```


```python
wall_get_list = []
offset = 0
while offset < post_number:
   wall_get = 'https://api.vk.com/method/wall.get?domain=' + group_id + "&count=100&offset=" + str(offset) + "&v=5.62" + "access_token=" + my_token
   js_group = json.loads(requests.get(wall_get).text)
   wall_get_list.append(js_group)
   offset = offset + 100
print(len(wall_get_list))
# получаем лист
# в каждой строке находится вложенный список из 100 постов
```


```python
data = pd.DataFrame()                        
d = {}    
x = 0
for i in wall_get_list:
    for o in range(1,len(i['response']['items'])):
        d = {}    
        if 'poll' in str(i['response']['items'][o]):
            if 'attachments' in i['response']['items'][o]:
                for l in range(len(i['response']['items'][o]['attachments'])):
                            if i['response']['items'][o]['attachments'][l]['type'] == 'poll':
                                data.loc[x, 'id_post'] = i['response']['items'][o]['id']
                                data.loc[x, 'date'] = i['response']['items'][o]['date']
                                data.loc[x, 'наличие опроса'] = 1
                                data.loc[x, 'кол-во лайков'] = i['response']['items'][o]['likes']['count']
                                data.loc[x, 'кол-во комментов'] = i['response']['items'][o]['comments']['count']
                                data.loc[x, 'кол-во репосток'] = i['response']['items'][o]['reposts']['count']
                                data.loc[x, 'текст'] = i['response']['items'][o]['text']
                                data.loc[x, 'id_poll'] = i['response']['items'][o]['attachments'][l]['poll']['id']
                                data.loc[x, 'id_poll'] = i['response']['items'][o]['attachments'][l]['poll']['id']
                                data.loc[x, 'vots_poll'] = i['response']['items'][o]['attachments'][l]['poll']['votes']
                                data.loc[x, 'anonymous_poll'] = i['response']['items'][o]['attachments'][l]['poll']['anonymous']
                                answers = []
                                for k in range(len(i['response']['items'][o]['attachments'][l]['poll']['answers'])):
                                    d.update({i['response']['items'][o]['attachments'][l]['poll']['answers'][k]['id'] : [i['response']['items'][o]['attachments'][l]['poll']['answers'][k]['rate'], i['response']['items'][o]['attachments'][l]['poll']['answers'][k]['text'], i['response']['items'][o]['attachments'][l]['poll']['answers'][k]['votes']]})
                                data.loc[x, 'info_poll'] = [d]
                                ans1 = list(d.keys())
                                ans2 = str(ans1)[1:]
                                ans3 = ans2[:-1]
                                data.loc[x, 'answers_poll'] = ans3
                                x = x + 1
            else:    
                 #print("i['response']['items'][o]['id']")
                 print('потерялась') 
                 x = x + 1          
        else:
            data.loc[x, 'id_post'] = i['response']['items'][o]['id']
            data.loc[x, 'date'] = i['response']['items'][o]['date']
            data.loc[x, 'наличие опроса'] = 0
            x = x + 1

data = data.reset_index(drop = True)
data = data.fillna(99)
print(len(data))
data.head()

# вынимаем построчно все посты из wall_get_list и записываем их в датафрейм
```


```python
poll_get_list = []
      
for i in range(len(data)):
    if int(data.loc[i, 'anonymous_poll']) is 0:
        if type(data.loc[i, 'answers_poll']) is not float:
            poll_get_list = []
            offset2 = 0 
            poll_id = str(int(data.loc[i, 'id_poll']))
            answers_poll = data.loc[i, 'answers_poll']
            poll_get = 'https://api.vk.com/method/polls.getVoters?owner_id=' + group_id2 + "&count=1000&offset=" + str(offset2) + "&v=5.62" + "&access_token=" + my_token + "&poll_id=" + poll_id + "&answer_ids=" + answers_poll
            time.sleep(0.4)
            js_poll = json.loads(requests.get(poll_get).text)    
            poll_get_list.append(js_poll)
            offset2 = 1000 
            poll_get = 'https://api.vk.com/method/polls.getVoters?owner_id=' + group_id2 + "&count=1000&offset=" + str(offset2) + "&v=5.62" + "&access_token=" + my_token + "&poll_id=" + poll_id + "&answer_ids=" + answers_poll
            time.sleep(0.4)
            js_poll = json.loads(requests.get(poll_get).text)    
            poll_get_list.append(js_poll)
            for o in poll_get_list:
                print(i)
                for p in range(len(o["response"])):
                    if len(o["response"][p]["users"]["items"]) != 0:
                        data.loc[i, 'info_poll'][0][o["response"][p]["answer_id"]].append(o["response"][p]["users"]["items"])
                        
# подгружаем в получившийся на предыдущем шаге дарафрейм списки с проголосовавшими
```


```python
# опциональная подгрузка выкаченных данных
# f = open('python/data.pkl', 'rb')
# data = pickle.load(f)
# data.head()
```


```python
# фильтруем датафрейм
poll_data = data.loc[data['anonymous_poll'] == 0, :] # оставляем только данные с (1) опросами (2) открытыми
poll_data = poll_data.reset_index(drop = True)
# poll_data.count()
# poll_data.loc[808,:]
```


```python
df_light = pd.DataFrame()
row = 0
for x in range(len(poll_data)):
# for x in range(809, len(poll_data)): # доделывание с 809, 808 не внесено в БД, разобраться с ним!
    print("{}/{}".format(x, len(poll_data)))
    if int(poll_data.loc[x, 'anonymous_poll']) is 0:
        for i in poll_data.loc[x, 'info_poll'][0].keys(): # названия ответов в ряде
            if poll_data.loc[x, 'info_poll'][0][i][0] != 0:
              answer_text = poll_data.loc[x, 'info_poll'][0][i][1]
              address = poll_data.loc[x, 'адрес']
              score1 = poll_data.loc[x, 'оценка']
              if len(poll_data.loc[x, 'оценка']) > 3:
                      score2 = float(''.join(re.findall("[0-9][,.]?[0-9]?",str(poll_data.loc[x, 'оценка']))[0]).replace(',', '.'))
              id_post = poll_data.loc[x, 'id_post']
              question_poll = poll_data.loc[x, 'question_poll']
              date = poll_data.loc[x, 'date']
              #text = poll_data.loc[x, 'текст']
              for people in poll_data.loc[x, 'info_poll'][0][i][3]:
                  df_light.loc[row, "reviewer_id"] = people
                  df_light.loc[row, "answer_id"] = i          
                  df_light.loc[row, "answer_text"] = answer_text 
                  df_light.loc[row, "address"] = address
                  #str(",".join(data.loc[x, 'адрес'])).split(','))
                  df_light.loc[row, "score_test"] = score1
                  df_light.loc[row, "score"] = score2
                  df_light.loc[row, "id_post"] = id_post
                  df_light.loc[row, "question_poll"] = question_poll
                  df_light.loc[row, "date"] = date
                  #df_light.loc[row, "text"] = text
                  row = row + 1
              if len(poll_data.loc[x, 'info_poll'][0][i]) > 4:
                      for people in poll_data.loc[x, 'info_poll'][0][i][4]:
                          df_light.loc[row, "reviewer_id"] = people
                          df_light.loc[row, "answer_id"] = i          
                          df_light.loc[row, "answer_text"] = answer_text 
                          df_light.loc[row, "address"] = address
                          #str(",".join(data.loc[x, 'адрес'])).split(','))
                          df_light.loc[row, "score_test"] = score1
                          df_light.loc[row, "score"] = score2
                          df_light.loc[row, "id_post"] = id_post
                          df_light.loc[row, "question_poll"] = question_poll
                          df_light.loc[row, "date"] = date
                          #df_light.loc[row, "text"] = text
                          row = row + 1                    
              else:
                      row = row + 1
```


```python
# csv
# df_light.to_csv('python/shaverma_df_light.csv', index=True, encoding='utf-8')
```


```python
# pickle
# df.to_pickle('/python/shaverma_df.pkl')
```


```python
# пропавший 808 ряд :(
# poll_data.loc[808, 'info_poll'][0][i][3]
# poll_data.loc[807, 'info_poll'][0].keys()
# poll_data.loc[808, 'info_poll'][0]
# poll_data.loc[808, 'info_poll'][0].keys()
# poll_data.loc[x, 'info_poll'][0][640771515][0] != 0
# poll_data.loc[x, 'info_poll'][0][640771515][3]
# как будто просто данные не загрузились

# for t in range(809,len(poll_data)):
# print(t)
# poll_data.loc[864,:]
```
