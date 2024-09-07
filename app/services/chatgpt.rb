# frozen_string_literal: true

# ChatGPTからレビューを受け取るクラス
class Chatgpt
  include HTTParty

  attr_reader :api_url, :options, :model, :message

  def initialize(title, tags, question, model)
    @api_key = ENV['OPENAI_API_KEY']
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @model = model
    @title = title
    @tags = tags.join(', ')
    @question = question
    @options = default_options
  end

  def call
    body = {
      model:,
      messages: [{ role: 'user', content: prompt }]
    }
    response = HTTParty.post(@api_url, body: body.to_json, **@options, timeout: 100)
    raise response['error']['message'] unless response.code == 200

    response['choices'][0]['message']['content']
  end

  class << self
    def call(title, tags, question, model = 'gpt-4o-mini')
      new(title, tags, question, model).call
    end
  end

  private

  def default_options
    {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{@api_key}"
      }
    }
  end

  def prompt
    <<~REVIEW_PROMPT
      あなたはテックリードのWebエンジニアです。あなたのチームに実務未経験の新人エンジニアが配属されました。あるプロジェクトにおいて新人エンジニアから質問が来ました。
      以下の要件と形式に沿って、新人エンジニアからの質問の仕方をレビューしてください。

      ## 要件
      - 質問内容を10点満点で評価してください。
      - 質問内容に対する回答は不要です。
      - 質問内容が明確であるかどうかを評価してください。
      - 質問に対して必要な情報が適切に含まれているかどうかを評価してください。
      - 質問はマークダウンで記述されています。
      - 質問内容が適切にマークダウンで記述されているかどうかを評価してください。
      - タイトル、タグ、質問内容が適切に記述されているかどうかを評価してください。
      - タイトルからどんな質問なのか想像できるかどうかを評価してください。
      - タグが適切に設定されているかどうかを評価してください。
      - 改善が必要な場合のみ、タイトル、タグ、質問内容を修正するように指示してください。

      ## 形式
      - Markdonw形式でレビューしてください
      - 一番初めは、h3タグで「質問の点数」として点数を表示してください。
      - 2番目は、h3タグで「良い点」を表示してください。
      - 3番目は、良い点をリスト形式で表示してください。
      - 4番目は、h3タグで「改善点」を表示してください。
      - 5番目は、改善点をリスト形式で表示してください。
      - 6番目は、h3タグで「改善案」を表示してください。
      - 7番目は、改善案をリスト形式で表示してください。
      - 全体はコードブロックで囲わないでください。

      ## 質問タイトル
      #{@title}

      ## 質問に紐づいているタグ
      #{@tags}

      ## 質問内容
      ここ以降はすべて質問内容です。
      #{@message}
    REVIEW_PROMPT
  end
end
