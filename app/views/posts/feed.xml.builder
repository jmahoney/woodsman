atom_feed(root_url: "http://iterative.co.nz", url: "http://iterative.co.nz/feed") do |feed|
    feed.title(t('defaults.feed_title'))
    feed.updated(@posts[0].published_at) if @posts.length > 0

    @posts.each do |post|
      feed.entry(post) do |entry|
        entry.url(post_path(post))
        entry.title(post.title)
        entry.content(render_intro_and_content(post), type: 'html')
        entry.author do |author|
          author.name(t("defaults.title"))
        end
        entry.updated(post.published_at.strftime("%Y-%m-%dT%H:%M:%SZ"))
      end
    end
  end