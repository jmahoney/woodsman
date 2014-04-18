atom_feed(root_url: "https://iterative.co.nz", url: "https://iterative.co.nz/feed") do |feed|
    feed.title(t('defaults.feed_title'))
    feed.updated(@posts[0].published_at) if @posts.length > 0

    @posts.each do |post|
      feed.entry(post, published: post.published_at, updated: post.updated_at) do |entry|
        entry.url(post_path(post))
        entry.title(post.title)
        entry.content(render_intro_and_content(post), type: 'html')
        entry.author do |author|
          author.name(t("defaults.title"))
        end
      end
    end
  end
