require "openai"

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    openai_client = OpenAI::Client.new(api_key: ENV.fetch("OPENAI_API_KEY"), default_engine: "ada")

    @prompt = "What is the weather like today?"
    @model = "text-davinci-002"

    # Create Completion
    response = openai_client.completions(
      engine: @model,
      prompt: @prompt,
      max_tokens: 2048,
      temperature: 0.5,
      top_p: 1,
      frequency_penalty: 0,
      presence_penalty: 0
    )

    @generated_response = response["choices"][0]["text"]
  end
end
