
# Web Scraping MLB Data Using Selenium + Storing it in a MongoDB

Date: July 17, 2019

Made by: Cristian E. Nuno

## Overview

Web scraping is used for retrieving data from the Internet. This tutorial will show you how to web scrape [hitting statistics](http://mlb.mlb.com/stats/sortable.jsp#elem=%5Bobject+Object%5D&tab_level=child&click_text=Sortable+Player+hitting&game_type='R'&season=2019&season_type=ANY&league_code='MLB'&sectionType=sp&statType=hitting&page=1&ts=1563409038614&sortColumn=avg&sortOrder='desc'&extended=0) for MLB baseball players for the current 2019 season. It will also walk you through on using `MongoDB` to store your data from the internet into your local machine.

*Note: this tutorial draws heavily on [Kena Jaladora's work](https://github.com/kenajalodara/webscraping_players/blob/master/WebScraping_Player.ipynb)*

## Load necessary libraries


```python
# load necessary libraries and modules
from selenium.webdriver import Chrome
import time
import requests
import pandas as pd
from typing import List
import json
from pymongo import MongoClient
from datetime import datetime
```

## Brief introduction into web browser automation

There are tools to help you extract content available on the web, specifically so that you do not have to spend time manually clicking or scrolling on the web yourself. [Selenium](https://www.seleniumhq.org/) is a suite of tools to automate web browsers across many platforms. 

> Selenium is a great tool that allows developers to *simulate* end-users with only a few lines of code. Some of the most popular tasks accomplished with Selenium include, but are not limited to:
> * Clicking buttons
> * Inputting text
> * Extracting text
> * Accessing Cookies
> * Pressing keys
>
> source: [Getting Started with Selenium and Python](https://stackabuse.com/getting-started-with-selenium-and-python/) by Ely Shaffir

### Custom `SuperChrome` class to help shorten the module name when selecting CSS elements

Below, `SuperChrome` is a custom class created to abbreviate the `find_elements_by_css_select()` method inside of the `Chrome` class. 


```python
class SuperChrome(Chrome):
    """References find_elements)by_css_selector in fewer words"""
    def select(self, *args, **kwargs):
        return self.find_elements_by_css_selector(*args, **kwargs)
    def select_one(self, *args, **kwargs):
        return self.find_element_by_css_selector(*args, **kwargs)
    
```

### Brief introduction to `MongoDB`

[MongoDB](https://www.mongodb.com/) is a general purpose, document-based, distributed database built for modern application developers and for the cloud era. [MongoDB stores data](https://www.mongodb.com/what-is-mongodb) in flexible, JSON-like documents, meaning fields can vary from document to document and data structure can be changed over time.

We'll store our extracted data into a database inside MongoDB. Once you've connected to a client-side representation of your local MongoDB server, you can create a new database by subsetting `client` with a string that represents the name of your newly created db.

In this case, we're creating a new database named `mlb`.


```python
client = MongoClient()
db = client["mlb"]
```

Since MongoDB is not a relational database management system, the `mlb` database does not hold tables like PostgreSQL. Instead, [collections](https://docs.mongodb.com/manual/core/databases-and-collections/) are what MongoDB calls tables. Collections are analogous to tables in relational databases.


```python
hitters = db["hitters"]
```

### Open a web brower


```python
# open a chrome window with our custom class
browser = SuperChrome()
```

### Scraping the backend JSON that feeds into the HMTL table

The MLB hitting statistics live [on this web page](http://mlb.mlb.com/stats/sortable.jsp#elem=%5Bobject+Object%5D&tab_level=child&click_text=Sortable+Player+hitting&game_type='R'&season=2019&season_type=ANY&league_code='MLB'&sectionType=sp&statType=hitting&page=1&ts=1564445154674&sortColumn=avg&sortOrder='desc'&extended=0). This web page that stores MLB hitting statistics for the current season. The data stored here is not static: every day it gets updated to take into account the players statistics after today's game.

The function `fetch_mlb_data_page()` shows how to extract the JSON data that is being displayed on the HTML tables on a particular response page. It adds two features to each record:

* `created_timestamp`: the datetime MLB uploaded the data; and
* `fetched_timestamp`: the datetime the data was scraped by us.


```python
def fetch_mlb_data_page(browser, page_num):
    """Get MLB data from each page"""
    json_url = f"http://mlb.mlb.com/pubajax/wf/flow/stats.splayer?season=2019&sort_order=%27desc%27&sort_column=%27avg%27&stat_type=hitting&page_type=SortablePlayer&game_type=%27R%27&player_pool=QUALIFIER&season_type=ANY&sport_code=%27mlb%27&results=1000&recSP={page_num}&recPP=50"
    browser.get(json_url)
    current_dt = datetime.today().strftime("%Y-%m-%d %H:%M:%S")
    # always sleep after getting data
    time.sleep(14)
    json_text = browser.select_one("body").text
    results = json.loads(json_text)
    rows = results["stats_sortable_player"]["queryResults"]["row"]
    for player in rows:
        player["created_timestamp"] = results["stats_sortable_player"]["queryResults"]["created"]
        player["fetched_timestamp"] = current_dt
    n_pages = results["stats_sortable_player"]["queryResults"]["totalP"]
    n_rows = results["stats_sortable_player"]["queryResults"]["totalSize"]
    return {"rows": rows, "n_pages": int(n_pages), "n_rows": int(n_rows)}
```

By default, MLB limits the number of records its HMTL table displays in 50 increments. To view the next 50 players, the `fetch_mlb_data()` function will update the url that retrieves the JSON such that it moves onto the next page until the last page is scraped.


```python
def fetch_mlb_data(browser, page_limit=3, page_num=1):
    """Retrieve data from MLB Stats"""
    while page_num <= page_limit:
        result = fetch_mlb_data_page(browser, page_num)
        n_pages = result["n_pages"]
        rows = result["rows"]
        if page_limit > n_pages:
            page_limit = n_pages
        print(f"Insert page {page_num} into the hitters collection inside the mlb MongoDB")
        hitters.insert_many(rows)
        page_num += 1
```


```python
fetch_mlb_data(browser)
```

    Insert page 1 into the hitters collection inside the mlb MongoDB
    Insert page 2 into the hitters collection inside the mlb MongoDB
    Insert page 3 into the hitters collection inside the mlb MongoDB


### Import data from MongoDB and cast as a DataFrame


```python
hitters_df = pd.DataFrame(list(hitters.find()))
hitters_df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>_id</th>
      <th>ab</th>
      <th>ao</th>
      <th>avg</th>
      <th>bats</th>
      <th>bb</th>
      <th>created_timestamp</th>
      <th>cs</th>
      <th>d</th>
      <th>fetched_timestamp</th>
      <th>...</th>
      <th>sport_id</th>
      <th>t</th>
      <th>tb</th>
      <th>team</th>
      <th>team_abbrev</th>
      <th>team_brief</th>
      <th>team_id</th>
      <th>team_name</th>
      <th>tpa</th>
      <th>xbh</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>5d3f953c9e58457f18986756</td>
      <td>365</td>
      <td>80</td>
      <td>.337</td>
      <td>L</td>
      <td>59</td>
      <td>2019-07-30T00:04:32</td>
      <td>2</td>
      <td>21</td>
      <td>2019-07-29 17:54:06</td>
      <td>...</td>
      <td>1</td>
      <td>3</td>
      <td>258</td>
      <td>mil</td>
      <td>MIL</td>
      <td>Brewers</td>
      <td>158</td>
      <td>Milwaukee Brewers</td>
      <td>433</td>
      <td>60</td>
    </tr>
    <tr>
      <th>1</th>
      <td>5d3f953c9e58457f18986757</td>
      <td>345</td>
      <td>97</td>
      <td>.336</td>
      <td>L</td>
      <td>20</td>
      <td>2019-07-30T00:04:32</td>
      <td>5</td>
      <td>27</td>
      <td>2019-07-29 17:54:06</td>
      <td>...</td>
      <td>1</td>
      <td>1</td>
      <td>175</td>
      <td>nyn</td>
      <td>NYM</td>
      <td>Mets</td>
      <td>121</td>
      <td>New York Mets</td>
      <td>380</td>
      <td>38</td>
    </tr>
    <tr>
      <th>2</th>
      <td>5d3f953c9e58457f18986758</td>
      <td>391</td>
      <td>91</td>
      <td>.332</td>
      <td>R</td>
      <td>31</td>
      <td>2019-07-30T00:04:32</td>
      <td>2</td>
      <td>23</td>
      <td>2019-07-29 17:54:06</td>
      <td>...</td>
      <td>1</td>
      <td>2</td>
      <td>202</td>
      <td>nya</td>
      <td>NYY</td>
      <td>Yankees</td>
      <td>147</td>
      <td>New York Yankees</td>
      <td>428</td>
      <td>40</td>
    </tr>
    <tr>
      <th>3</th>
      <td>5d3f953c9e58457f18986759</td>
      <td>420</td>
      <td>100</td>
      <td>.329</td>
      <td>L</td>
      <td>34</td>
      <td>2019-07-30T00:04:32</td>
      <td>6</td>
      <td>36</td>
      <td>2019-07-29 17:54:06</td>
      <td>...</td>
      <td>1</td>
      <td>3</td>
      <td>243</td>
      <td>bos</td>
      <td>BOS</td>
      <td>Red Sox</td>
      <td>111</td>
      <td>Boston Red Sox</td>
      <td>458</td>
      <td>60</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5d3f953c9e58457f1898675a</td>
      <td>367</td>
      <td>123</td>
      <td>.327</td>
      <td>L</td>
      <td>65</td>
      <td>2019-07-30T00:04:32</td>
      <td>5</td>
      <td>20</td>
      <td>2019-07-29 17:54:06</td>
      <td>...</td>
      <td>1</td>
      <td>2</td>
      <td>246</td>
      <td>lan</td>
      <td>LAD</td>
      <td>Dodgers</td>
      <td>119</td>
      <td>Los Angeles Dodgers</td>
      <td>440</td>
      <td>56</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 55 columns</p>
</div>




```python
hitters_df.shape
```




    (150, 55)


