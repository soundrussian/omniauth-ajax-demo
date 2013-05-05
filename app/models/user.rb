class User < ActiveRecord::Base

  # find or create user with given provider and uid
  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  # creating with given info
  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      # luckily, all providers return the same hash here,
      # but you might want to add more logic for storing email, urls, etc
      user.name = auth["info"]["name"]
    end
  end

  # used in /me route
  def to_json
    return {
      name: name,
      provider: provider
    }.to_json
  end
end
