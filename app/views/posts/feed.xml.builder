atom_feed do |feed|
    feed.title(t('defaults.feed_title'))
    feed.updated(@posts[0].created_at) if @posts.length > 0

    @posts.each do |post|
      feed.entry(post) do |entry|
        entry.title(post.title)
        entry.content(render_intro_and_content(post), type: 'html')
        entry.author do |author|
          author.name(t("defaults.title"))
        end
      end
    end
  end