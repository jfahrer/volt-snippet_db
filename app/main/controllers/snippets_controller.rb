module Main
  class SnippetsController < Volt::ModelController
    model :store

    def snippets
      store.snippets.all
    end

    def new
      self.model = store.snippets.buffer
    end

    def edit
      self.model = current_snippet.buffer
    end

    def current_snippet
      store.snippets.where(id: params.id).first
    end

    def delete_snippet(snippet)
      snippet.destroy.then do
        params.id = nil
      end.fail do |err|
        flash._errors << err
      end
    end

    def save_snippet
      self.model.save!.then do |snippet|
        redirect_to("/snippets/#{snippet.id}")
      end.fail do |err|
        flash._errors "Failed: #{err}"
      end
    end

  end
end
