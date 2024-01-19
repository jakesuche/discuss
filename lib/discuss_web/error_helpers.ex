defmodule DiscussWeb.ErrorHelpers do
 use Phoenix.HTML



 @spec error_tag(atom() | %{:errors => [{any(), any()}], optional(any()) => any()}, atom()) ::
         list()
 def error_tag(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      content_tag(:div, class: "help-block flex mt-1") do
        raw(
          "<span style='margin-left:5px'>#{translate_error(error)}</span>"
        )
      end
    end)
  end

def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate "is invalid" in the "errors" domain
    #     dgettext("errors", "is invalid")
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # Because the error messages we show in our forms and APIs
    # are defined inside Ecto, we need to translate them dynamically.
    # This requires us to call the Gettext module passing our gettext
    # backend as first argument.
    #
    # Note we use the "errors" domain, which means translations
    # should be written to the errors.po file. The :count option is
    # set by Ecto and indicates we should also apply plural rules.
    if count = opts[:count] do
      Gettext.dngettext(DiscussWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(DiscussWeb.Gettext, "errors", msg, opts)
    end
  end

end
