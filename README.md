# BIS180L Website

Website for UC Davis class BIS180L

Based on the Jekyll theme [Hyde](http://hyde.getpoole.com/)

The live website is [http://jnmaloof.github.io/BIS180L_web/](http://jnmaloof.github.io/BIS180L_web/)

## Some formatting info

To have a markdown file converted it must have front matter.

### Regular page

For a regular page use the following front matter:

    ---
    layout: page
    title: YOUR TITLE HERE
    ---

Place the .md file in the root directory for the site.  It will get added to the sidebar links.

### Lab

For a lab page use:

    ---
    layout: lab
    title: Instructions on installing and using the BIS180L virtual linux machine
    hidden: true    <!-- To prevent post from being displayed as regular blog post -->
    tags:
        - Linux
    ---

Save it in the '_posts' folder with a name that follows a format of `yyyy-mm-dd-title.md'.  This will automatically get added to the list of lab pages

### Post

For a post to be listed on the front page, use:

    ---
    layout: post
    title: Welcome to BIS180L
    ---

Save it in the '_posts' folder with a name that follows a format of `yyyy-mm-dd-title.md'.  This will automatically get added to the front page.

## Setting up your computer to use jekyll

See https://github.com/github/pages-gem or https://help.github.com/articles/using-jekyll-with-pages/ .  Bundler has been a bit strange for me, so the former approach may be better.

Once you have jekyll installed, type `jekyll serve` in the root directory and point your browser to http://localhost:4000

## Branching Scheme

* gh-pages: the published site
* develop: for making relatively minor changes to the site
* feature-XYZ: for adding labs, etc, that may take a longer time to complete.

