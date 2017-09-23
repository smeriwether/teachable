module Teachable
  class UsersResource < Teachable::Resource
    def current_user
      transform(client.http_client.get("/api/users/current_user/edit.json"))
    end

    private

    def model_klass
      User
    end
  end
end
