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

def update_readme():
  # Since the script lives in the profile repo now, it reads the local README
  readme_path = "README.md"
  
  newest_post_folder = get_posts()[0]
  title, subtitle, date, categories = get_post_metadata(newest_post_folder)
  url = get_post_url(newest_post_folder)
  
  category_tags = " ".join([f"<code>{cat}</code>" for cat in categories]) if categories else ""
  
  # Clean HTML construction
  blog_html = (
      f"Newest blog post:<br>\n"
      f"<strong><a href='{url}'>{title}</a></strong> - <em>{date}</em><br>\n"
      f"<small>{subtitle}</small> {category_tags}\n"
  )
  
  with open(readme_path, "r", encoding="utf-8") as f:
      readme_content = f.read()
  # CRITICAL FIX: The '?' makes the regex match lazy instead of greedy, preventing multi-replacement loops
  pattern = r"(\n)(.*?)(\n)"
  replacement = f"\\1{blog_html}\\3"
  
  updated_content = re.sub(pattern, replacement, readme_content, flags=re.DOTALL)
  with open(readme_path, "w", encoding="utf-8") as f:
      f.write(updated_content)
      
  print(f"Successfully formatted layout for: '{title}'")

if __name__ == "__main__":
    update_readme()