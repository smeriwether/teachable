module Teachable
  class UsersResource < Teachable::Resource
    def current_user
      transform(client.http_client.get("/api/users/current_user/edit.json"))
    end

    def register(email:, password:, password_confirmation:)
      transform(
        client.http_client.post(
          "/users.json",
          user: { email: email, password: password, password_confirmation: password_confirmation }
        )
      )
    end

    def authenticate(email:, password:)
      transform(client.http_client.post("/users/sign_in.json", user: { email: email, password: password }))
    end

    private

    def model_klass
      User
    end
  end
end
