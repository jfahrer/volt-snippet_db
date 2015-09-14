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
      self.model = store.snippets.where(id: params.id).first.buffer
    end

    def delete_snippet(snippet)
      snippet.destroy.fail do |err|
        flash._errors << err
      end
    end

    def save_snippet
      self.model.save!.then do 
        redirect_to("/snippets")
      end.fail do |err|
        flash._errors "Failed: #{err}"
      end
    end

  end
end
