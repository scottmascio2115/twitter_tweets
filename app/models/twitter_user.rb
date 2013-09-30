class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def fetch_tweets!
    tweets = Twitter.user_timeline(self.user_name)
    tweets.each do |tweet|
      self.tweets << Tweet.create(text: tweet.text)
    end
  end

  def tweets_stale?
    if self.tweets.empty?
      fetch_tweets!
    else
      total_time = 0
      self.tweets[-11..-1].each do |tweet|
        total_time += (tweet.created_at - Tweet.find(tweet.id - 1).created_at)
      end
      avg_time = total_time / self.tweets[-11..-1].count
      Time.now - self.tweets.first.created_at < avg_time
    end
  end
end
