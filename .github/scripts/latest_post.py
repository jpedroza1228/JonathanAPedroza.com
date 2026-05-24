import os
import re
import frontmatter
from pyhere import here
# import numpy as np
# import pandas as pd

# get the latest post that is published on the website
def get_posts():
    posts = os.listdir('website/_site/posts')
    posts.sort(reverse = True)
    return posts

# for local changes on main website page
def get_posts_local():
    posts = os.listdir('./_site/posts')
    posts.sort(reverse = True)
    return posts

# get_posts()[0]

# get the title, subtitle, date of the post,
# and the categories that are covered in the post
def get_post_metadata(post):
  post = frontmatter.load(f'website/posts/{post}/index.qmd')
  
  title = post['title']
  subtitle = post['subtitle']
  date = post['date']
  categories = post['categories']

  return title, subtitle, date, categories

# for local changes on main website page
def get_post_metadata_local(post):
  post = frontmatter.load(f'./posts/{post}/index.qmd')
  
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
