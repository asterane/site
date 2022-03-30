+++
title = "A Tale of Jekyll and Hugo"
author = ["Matthew Rothlisberger"]
date = 2020-10-14T20:27:00-06:00
lastmod = 2022-03-30T13:30:51-06:00
draft = false
weight = 2002
+++

My journey to having a fully functional site where I can publish
content was somewhat convoluted, but highly educational. In this post,
I'll be sharing what I learned, discussing the process of creating a
site using Emacs and Org mode, and comparing the two leading static
site generators: Jekyll and Hugo.
<!--more-->

Some time ago, I became interested in writing a technical blog. I have
learned much from the blogs of others, and there is always more to
say. Later, the prospect of a personal portfolio where I could share
my work began to have its own appeal. In recent weeks, I have put up
this site to fill both purposes. Without further ado, let's begin.

<div class="ox-hugo-toc toc">

<div class="heading">Table of Contents</div>

- [Getting Started](#getting-started)
    - [Static Sites](#static-sites)
    - [Alternatives](#alternatives)
    - [GitHub Pages](#github-pages)
- [Jekyll](#jekyll)
    - [Resources](#resources)
    - [Structure](#structure)
    - [Generating Content](#generating-content)
    - [Issues](#issues)
- [Hugo](#hugo)
    - [Resources](#hugo-resources)
    - [Structure](#hugo-structure)
    - [Generating Content](#hugo-content)
- [Comparison](#comparison)

</div>
<!--endtoc-->


## Getting Started {#getting-started}

When I chose to pursue this project, I had a few important goals. Here is
a list of the qualities I wanted my site to have.

-   Hosting should be free. I'm not interested in paying for a domain
    name or hosting until I have a good reason to do so.
-   I should have complete control of content and format. No irremovable
    themes, no "proudly powered by x" footer.
-   It should be easy to publish content. I don't want to have to muck
    around with HTML when I am just writing a blog post.
-   The site should be light, fast, and responsive. The less there is to
    design, and the fewer dependencies, the better.
-   I should understand every part of my site, and the process by which
    it is published. This is a learning exercise as much as anything.


### Static Sites {#static-sites}

A website must include both formatting and content, the former
dictating how the latter will be displayed in browsers. In the
hypertext model used on the Web, format and content come in a single,
structured, HTML file that places content within blocks of
formatting.

This combination makes sense for rendering, and means that the
technically simplest way to create a website is to author HTML files
containing content within the desired format tags. This approach can
become cumbersome if the creator wants to change content frequently or
keep a uniform format across many pages with different content.

Static site generators offer another model for site creation, one
where the format and the content are conceptually distinct, only
combined together when the final site is generated, hence the name. As
the creator, you design HTML layouts for your site and use a
template language to tell the generator where your content should be
placed on the page.

You author your site's content in distinct files, in a significantly
more human readable format, where you can edit quickly and focus on
the structure of your text. When you choose to generate your site, the
generator combines any number of content pages with any number of
layouts according to specific rules; this makes it trivial to ensure
the same look for every page.

In a way, the static site generator acts as a linker, combining your
content with layouts that are ready for a browser to display. You can
reference variables and set up routines that run at generation time,
using the template language that your site generator of choice
provides. We will discuss this more in later sections.


### Alternatives {#alternatives}

I mentioned the issues with creating a site out of HTML files from
scratch, but there is another model for conceptual separation of
content and format. Most web content management systems use a server
backend that provides content dynamically, using scripts, to a
formatted page.

Such behavior is desirable for complex web applications, but is
unnecessary for simple blogs and personal websites. Static site
generators create a hierarchy of pages dynamically, but they are then
served statically, which reduces hosting requirements and technical
complexity significantly.


### GitHub Pages {#github-pages}

Free hosting along with total control over the site is a high bar, but
thankfully GitHub has been offering this service for some time. I
began by creating a new public repository with the name required by
Pages: `asterane.github.io`. I then created a folder on my machine
with the same name. GitHub Pages automatically integrates with the
static site generator Jekyll, which is where our story leads next.


## Jekyll {#jekyll}

Released in 2008, [Jekyll](https://jekyllrb.com) was the first major free and open source
static site generator. It is well supported by GitHub, which will
automatically generate and serve a site from a repository containing
Jekyll source. This was attractive to me, and Jekyll was the first
site generator I encountered, so I began by setting up my site this
way. Jekyll's template language is called Liquid.

To set up and test your site, it is important to install Jekyll on
your own computer. It comes as a Ruby gem, so it's possible to install
with `gem install jekyll bundle` as the [quickstart guide](https://jekyllrb.com/docs/)
recommends. For me, it was easier to use the Arch User Repository,
which provides the relevant gems as distinct packages. I created a new
site with `jekyll new asterane.github.io` and then `bundle exec jekyll
serve` to serve it on <http://localhost:4000>.


### Resources {#resources}

-   <http://jmcglone.com/guides/github-pages/>
-   <https://orgmode.org/worg/org-tutorials/org-jekyll.html>
-   <https://opensource.com/article/20/3/blog-emacs>


### Structure {#structure}

A Jekyll site's top level directory contains the configuration file
(`_config.yml`), several important folders each prefixed with an
underscore, and all of the content files for the site (other than blog
posts). Anything that is not prefixed with an underscore or excluded
in the configuration file will be part of the generated site.

Layouts, kept in the `_layouts` directory, are provided as HTML files
with snippets of Liquid that indicate where content is meant to be
inserted. Below is a basic example of a `default.html` layout for a
Jekyll website.

```html
<!DOCTYPE html>
<html>
  <head>
    <title>{{ page.title }}</title>
    <link rel="stylesheet" type="text/css" href="/css/main.css">
  </head>
  <body>
    <nav>
      <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/about">About</a></li>
        <li><a href="/blog">Blog</a></li>
      </ul>
    </nav>
    <div class="container">
      <h1>{{ page.title }}</h1>

      {{ content }}

    </div><!-- /.container -->
    <footer>
      <ul>
        <li><a href="/contact">Contact</a></li>
      </ul>
    </footer>
  </body>
</html>
```

The Liquid tags are identifiers surrounded by double braces, like `{{
content }}`. These tell Jekyll what to insert at that area of a page
using this default layout. The title of a page will be defined in a
content file, which is usually Markdown or HTML, and the content
itself is the text of that file.

Content files may be Markdown, Textile, or even HTML with only a
`<body>` section. To tell Jekyll that they need to be generated into
pages, and to set important variables, all content files must begin
with Jekyll front matter. Here are the first four lines of a page
`helloworld.md`.

```yaml
---
layout: default
title: Hello World
---
```

You can see that the page with this front matter will use the layout
we just defined at `_layouts/default.html`, and that the page title
will be "Hello World". There are other available variables, and you
may even create custom ones. The rest of the file is up to you,
containing your content represented with your chosen markup language.

Posts are a special type of page; content files for these are placed
in the `_drafts` directory while in progress, or in the `_posts`
directory for publishing. They must be named according to the format
`YYYY-MM-DD-put-name-here.EXT`, and will appear in the site's
structure at `/YYYY/MM/DD/put-name-here.html`.

We can define a layout just for posts, illustrating a useful feature
of static site layouts: they may be nested. A layout which is to use
another as a parent must begin with front matter. Here is an example
`post.html` layout that displays the date below the title.

```html
---
layout: default
---

<p class="meta">{{ page.date | date_to_string }}</p>

<div class="post">
  {{ content }}
</div>
```

This layout inherits from our default layout but adds additional
information that should be useful for blog posts. The vertical bar is
a pipe, passing the page date into the `date_to_string` function,
which will convert it to `YYYY-MM-DD` format.

Folders containing useful resources may also be added to the Jekyll
site directory, such as `css` or `img`. Just like any site, you may
define your own stylesheet to customize the look and feel of yours
when it is displayed in a browser.

Below, see an example directory structure for a simple Jekyll
site. Any complete site will likely be more complicated than this, but
it serves to show how Jekyll structures its files in practice. The
generated site would be placed in a `_site` directory.

```text
.
├── _layouts
│   ├── default.html
│   └── post.html
├── _drafts
├── _posts
│   └── YYYY-MM-DD-put-name-here.md
├── img
├── css
│   └── main.css
├── _config.yml
├── index.md
├── helloworld.md
├── about.md
├── blog.md
└── contact.md
```


### Generating Content {#generating-content}

My love affair with [Emacs](https://www.gnu.org/software/emacs/) began shortly after my senior year of high
school was abruptly truncated by the aforementioned pandemic. I will
undoubtedly be writing more about Emacs in the future, but suffice it
to say that this tool has no equal. I knew that I had to be able to
create my site using Emacs.

What's more, I wanted to write all of my content in [Org mode](https://orgmode.org), the to
do management and document creation system included with Emacs. Fellow
Org mode users will understand why. If you have not yet made this
excellent software part of your life, I cannot recommend it more. So,
I needed a comfortable way to publish pages from Org files.


#### Org Publish {#org-publish}

An excellent export system comes bundled with Org, which can publish
Org files to many other text formats. I chose to publish to HTML
because I had no intention of editing my published files, and table of
contents support is best for HTML export. Simply running the export
command over my Org content buffers would not suffice, though.

In the default mode, a file `example.org` will simply be exported to
`example.html`, in the same directory. I wanted to keep my content in
a subdirectory of my main Jekyll site, called `org`, and export all of
it to the top level at once. Helpfully, a facility that can do this
exists, Org Publish.

This utility publishes a group of files according to a set of per
project configuration options. These are meant to be set in one's
Emacs configuration file, but I wanted all of my settings to be
bundled in the same directory as the rest of my site, so I opted to
write my own set of build scripts, discussed momentarily.

I stored my Org Publish settings in an Emacs Lisp file
`publish.el`. They set the directory to publish to, express that Org
files should be published as HTML files containing only a body, and
that all other files (CSS, images) should be published verbatim. I
also included a function that runs when the file is loaded and
actually publishes the content.

```emacs-lisp
(require 'ox-publish)
(setq org-publish-project-alist
      '(
        ("asterane-org"
         :base-directory "./org/"
         :base-extension "org"
         :publishing-directory "."
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 5 ;; Could be whatever
         :html-extension "html"
         :body-only t ;; Only export between <body> </body>
         )
        ("asterane-static"
         :base-directory "./org/"
         :base-extension "html\\|css\\|js\\|md\\|png\\|jpg\\|gif\\|ico\\|pdf"
         :publishing-directory "."
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("asterane-all" :components ("asterane-org" "asterane-static"))
        ))

(defun asterane-publish ()
  "Publishes all projects regardless of file modification status."
    (let ((current-prefix-arg 4))
      (call-interactively 'org-publish-all)
      )
  )
```

To ensure that my exported HTML bodies would be properly processed by
Jekyll, I also had to structure my Org files in such a way that
appropriate Jekyll front matter would be placed at the top of each
one. Each Org file I published from thus began as shown here.

```org
#+OPTIONS: toc:nil num:nil
#+BEGIN_EXPORT html
---
layout: default
title: [title]
---
#+END_EXPORT
```


#### GNU Make {#gnu-make}

My `publish.el` file was meant to be loaded into Emacs batch mode and
run from the top level directory of my Jekyll site. I wrote a Makefile
to accomplish this and other useful functions using only simple
commands, shown below.

```makefile
.PHONY: serve publish

serve: publish
        @echo "Serving..."
        bundle exec jekyll serve --host=0.0.0.0

publish: publish.el
        @echo "Publishing..."
        emacs --batch --no-init-file --load publish.el --funcall asterane-publish

clean:
        @echo "Cleaning directory..."
        @find org -maxdepth 1 -mindepth 1 -type d -exec basename {} \; \
        | xargs rm -rvf
        @rm -rvf *.html
        @rm -rvf _site
```

With this Makefile in my site's directory, all I need to do to publish
my Org files to HTML bodies for Jekyll to process is to run `make
publish` at the command line. To serve my site over my local network
for testing, I run `make serve`, and to clean up all the generated
files, I run `make clean`.

I find that a system like this makes (pun intended) content creation
with Jekyll easy. I simply place all of my content in the `org`
directory as Org files, divided into subdirectories as necessary. My
stylesheets and images also go here. Running a few Make commands
publishes everything in seconds for me to view in the browser.


### Issues {#issues}

As you can see, I did set up a functioning system to publish my site
with Jekyll. Indeed, my site as generated by Jekyll was live on the
internet for a number of days. Despite this success, however, a number
of issues drove me to switch to Hugo, hence the title of this post.

The most important problem, and the reason I could not stay with my
original system, came down to poor integration between Jekyll and Org
mode. Essentially, no links between pages worked properly when the
site was live. They started out as Org links between files and were
exported as HTML links to paths that did not exist in the final site.

Jekyll's preferred way of linking pages together in content is through
the use of particular Liquid tags that are translated into good links
on generation, but this would have been a pain to use from Org, and
there were multiple other problems with Jekyll leading me to seek
another option.

Site generation was relatively slow. Even with only around ten pages,
it took a noticeable fraction of a second for Jekyll to generate and
serve the site. This is due to their use of Ruby, an interpreted
language; not the best choice for a piece of speed sensitive
production software.

Also bothersome was the clutter in my site repository. GitHub Pages
only publishes content files from the top level directory, which
swiftly began to fill with various HTML files. In addition, Jekyll
requires several files and folders to begin with an underscore, which
I regard as rather ugly.


## Hugo {#hugo}

With the most features and fastest generation, [Hugo](https://gohugo.io), released in 2013,
is Jekyll's main competitor. I was attracted to it by the existence
of a powerful Org exporter just for Hugo, called `ox-hugo`. It is not
integrated with GitHub, but it generates complete sites that can still
be served through GitHub Pages. Hugo is written in Go and uses the Go
template language.

It was clear that switching to Hugo as my static site generator would
fix all of my main issues with Jekyll. The tighter Org mode
integration made my links work properly, the use of a compiled
language aided extremely fast generation, and the directory structure
is much cleaner to my eye.

Hugo comes in the Arch and Manjaro repositories, so it was easy for me
to install the compiled application on my computer. As suggested by
the [quick start guide](https://gohugo.io/getting-started/quick-start/), I ran `hugo new site asterane` to lay out the
directory structure. I then ran `hugo server -D`, which served my
fledgling site on <http://localhost:1313>.


### Resources {#hugo-resources}

-   <https://zwbetz.com/make-a-hugo-blog-from-scratch/>
-   <https://www.shanesveller.com/blog/2018/02/13/blogging-with-org-mode-and-ox-hugo/>
-   <https://jpdroege.com/blog/hugo-shortcodes-partials/>


### Structure {#hugo-structure}

In a Hugo site's top level directory, there are several important
folders and a configuration file. The site creator may add any other
files or folders deemed necessary, but the final site will only be
generated from the contents of particular folders, according to a
clearly documented set of rules. A simple configuration file,
`config.toml`, appears below.

```cfg
baseURL = "https://asterane.github.io/"
languageCode = "en-us"
title = "asterane"

[params]
  Name = "Matthew Rothlisberger"

[markup.highlight]
  style = "emacs"

[markup.goldmark.renderer]
  unsafe = true
```

This is brief and clean, setting the base link URL, site title,
creator name, and code highlighting style. Parameters from the config
may be used in layouts, which are in the `layouts` directory. Layouts
are HTML files with bits of Go template language that indicate where
content and various parameters should be inserted.

The default layout for an entire site resides in
`layouts/_default/baseof.html`. All layouts will inherit from this one
unless otherwise specified; a default for list pages may also be
created. Here is a basic example of a `baseof.html` layout for Hugo.

```html
<!DOCTYPE html>
<html>
  <head>
    <title>{{ .Title }} | {{ .Site.Title }}</title>
    <link rel="stylesheet" type="text/css" href="/css/main.css">
  </head>
  <body>
    <nav>
      <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/about">About</a></li>
        <li><a href="/blog">Blog</a></li>
      </ul>
    </nav>
    <div class="container">

      {{ block "main" . }}

      {{ end }}

    </div><!-- /.container -->
    <footer>
      <ul>
        <li><a href="/contact">Contact</a></li>
      </ul>
    </footer>
  </body>
</html>
```

Note that in Hugo templates, the tags are surrounded by double braces
and the parameters are accessed using dot notation. To access any site
parameter, one dot comes in front of the first name and namespaces are
separated with further dots. Identifiers without blocks are keywords
or functions.

One such example is the "main" block seen in the container. This tells
Hugo where to insert the contents of templates that inherit from this
one. In addition to `baseof.html`, Hugo requires the provision of two
other templates: `single.html` and `index.html`. The former provides
the template for all single pages; the latter, the template for the
site's main page. See a basic `single.html` below.

```html
{{ define "main" }}

<h1>{{ .Title }}</h1>
{{ .Content }}

{{ end }}
```

You can see that the `{{ define "main" }}` of the single page template
will slot neatly into the `{{ block "main" }}` of the base
template. The content of the page is actually inserted here. Hugo
separates the base from the single page template because you are also
permitted to make templates for pages that list single pages.

The `index.html` template inherits from the base template and enables
special formatting or content for the site's home page. Of course,
templates can be as granular as one desires. Of note for GitHub Pages,
a `404.html` template can also be created and will be automatically
displayed when an invalid URL is accessed.

Content files, appropriately, live in the `content` directory as
Markdown. They may be split up into subdirectories as desired, each
representing a distinct section of the site. Every content file must
contain Hugo front matter, depicted here.

```cfg
+++
title = "Hello World"
author = ["Name Here"]
+++
```

This sets the title and author of the page; many other variables
describing a page may also be set in the front matter, including
arbitrary variables. Front matter is only required in Markdown content
files, not in any templates or layouts. Also note that Hugo
automatically determines the layout based on file name and section.

Static sitewide resources are placed in the `static` directory. These
include CSS style sheets and images, like icons. During generation,
Hugo pulls together the layouts, content, and resources; the completed
site is output in the `public` directory.

Here is an example directory for a simple Hugo site. Some of the
autogenerated folders are unused; they could be deleted if
desired. The conceptual division between content, layouts, and
resources is apparent. Different layouts will apply to different
content based on directory structure and name.

```text
.
├── archetypes
│   └── default.md
├── data
├── themes
├── content
│   ├── posts
│   │   └── helloworld.md
│   ├── _index.md
│   ├── about.md
│   ├── blog.md
│   └── contact.md
├── layouts
│   ├── _default
│   │   ├── baseof.html
│   │   └── single.html
│   ├── posts
│   │   └── single.html
│   ├── index.html
│   └── 404.html
├── static
│   ├── img
│   └── css
│       └── main.css
└── config.toml
```


### Generating Content {#hugo-content}

Of course, with Hugo I still intended to author all of my content in
Emacs. Part of what drew me to Hugo is the presence of a well
maintained Org mode exporter that specifically targets Hugo
markdown. This exporter has useful features that completely changed
the way I create my site content for the better.


#### `ox-hugo` {#ox-hugo}

All of the Org exporter backends are named in the form ox-[target],
such as `ox-html` or `ox-md`. Thus, the exporter for Hugo is called
[`ox-hugo`](https://ox-hugo.scripter.co). This backend gives full access to Hugo features and sets
front matter, all using Org syntax that is much more comfortable than
TOML and Markdown.

The most powerful feature `ox-hugo` enables is keeping all the content
for an entire site in a single Org file. Subtrees can be singled out
for export as distinct files, divided into sections, and more. Every
page in my site, regular pages and blog posts alike, is generated from
a single Org file. Org property drawers are used to set output
filenames and any desired front matter variables.

I highly recommend exploring the `ox-hugo` website for further
information on the exporter. It is simple to get started using, but
there are many helpful features and a few caveats to be aware of. It
makes my publishing process practically effortless.

My content file is at `org/content.org` relative to my Hugo site
directory. I have indicated at the top of the file where this base
directory is. When I press the key combination `C-c C-e H A`, all of
the subtrees in my file are exported to their Markdown content files,
with front matter generated.


#### Multiple Repositories {#multiple-repositories}

Hugo does not integrate with GitHub Pages, so only the generated site
may be placed in the repository from which the site is served. This
necessitates creating two repositories: one for the site source and
one for the generated site which GitHub serves at my URL. The Hugo
website provides [some advice](https://gohugo.io/hosting-and-deployment/hosting-on-github/), which I used for my site.

The site source now resides at a new repository I created; I made the
`public` directory a git submodule with its remote at the
`asterane.github.io` repository. I use the `deploy.sh` script shown on
the above linked page to push my generated site to GitHub after
changing it. To manage the source repo, I just use Magit.

Even though Hugo vastly simplifies most steps of my site publishing
process, I still wanted a unified interface to my commonly used
operations. I created a simple Makefile, shown here, that can serve my
site locally, publish it to `public`, deploy `public`, and clean up
generated files.

```makefile
.PHONY: deploy serve publish

deploy:
        @./deploy.sh

serve:
        @echo "Serving..."
        hugo server -D --bind 0.0.0.0

publish:
        @echo "Publishing..."
        hugo

clean:
        @echo "Cleaning generated files..."
        @rm -rvf public/*
        @rm -rvf content/*
```

Now, a few keystrokes in Emacs export all of my content to Markdown
ready for Hugo. Just a couple `make` commands later, my changes are
pushed live. I can then go ahead and commit the site source to ensure
that everything is tracked and backed up.


## Comparison {#comparison}

As you have seen, I created a complete static site and publishing
system from scratch using Jekyll, and then using Hugo. I recommend
Hugo over Jekyll for anybody seeking to create a static
website. Jekyll may be slightly easier to understand at first, but
every other advantage lies with Hugo.

Hugo as an application is smaller than Jekyll, being compiled. It is
also significantly faster at its work, generating almost all sites in
far less than a second. Jekyll, however, takes a second or longer to
generate even sites with only a few pages.

The organization of Hugo site source is cleaner, makes more sense, and
offers greater flexibility than that of Jekyll. Clutter is absent,
conceptual distinctions are clear, and there are many more ways to
organize and interact with content.

Templates are key to pages with dynamic generation; Hugo has the
advantage here too. I did not explore the template, partial, and
shortcode systems in this post, but I did use them for this site, and
they are far more powerful than their counterparts from Jekyll.

I know many site creators may not value this aspect, but Hugo has far
better integration with Emacs and Org mode, which makes it much easier
to author site content than it would otherwise be. My interface to my
site is clean and uncluttered thanks to these tools.

My efforts in putting up a personal site taught me a lot about web
development and have resulted in an excellent place to share my
work. I encourage everyone to try putting up their own blog or
portfolio. If you do, create a static site, and remember to use Hugo
to generate it. That is, unless something better[^fn:1] comes along
in the meantime.

[^fn:1]: See [Blades](https://github.com/grego/blades).
