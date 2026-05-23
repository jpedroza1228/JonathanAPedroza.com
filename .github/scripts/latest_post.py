import os
import re
import frontmatter
from pyhere import here
# import numpy as np
# import pandas as pd

# get the latest post that is published on the website
def get_posts():
    posts = os.listdir(here('_site/posts'))
    posts.sort(reverse = True)
    return posts

# get_posts()[0]

# get the title, subtitle, date of the post,
# and the categories that are covered in the post
def get_post_metadata(post):
  post = frontmatter.load(here(f'posts/{post}/index.qmd'))
  
  title = post['title']
  subtitle = post['subtitle']
  date = post['date']
  categories = post['categories']

  return title, subtitle, date, categories

# get_post_metadata(get_posts()[0])

# Build the URL of the published post from the filename
def get_post_url(post):
    url = 'https://jonathanapedroza.com/posts/' + post +'/'
    return url

# get_post_url(get_posts()[0])

# if __name__ == "__main__":
#   # Get the latest blog post
#   post = get_posts()[0]
  
#   title, subtitle, date, categories = get_post_metadata(post)
#   url = get_post_url(post)
  
#   print(f'{title} {subtitle}{url}\nPublished date: {date}\nTopics covered: {categories}')

#   # Open the index file of the main page of my 
#   with open(here('index.qmd'), 'r') as f:
#       main = f.readlines()
#       f.close()
#       # Delete the old latest posts
#       del main[
#           main.index('<!-- START_SECTION:latest_posts -->\n')
#           + 1 : main.index('<!-- END_SECTION:latest_posts -->\n')
#       ]
#       # Add the new latest posts
#       main.insert(
#           main.index('<!-- START_SECTION:latest_posts -->\n') + 1
#       )
#   # Open the README.md file again, this time for writing
#   with open(here('index.qmd'), "w") as f:
#       f.writelines(main)
#       f.close()