defmodule ExCucumber.Exceptions.Messages.UnableToAutoMatchParam do
  @moduledoc false
  alias ExCucumber.{
    Exceptions.MatchFailure,
    Utils,
  }
  alias ExCucumber.Exceptions.Messages.Common, as: CommonMessages

  def render(%MatchFailure{error_code: :unable_to_auto_match_param} = f, :brief) do
    module_name = f.ctx.__struct__.module_name(f.ctx)

    """
    Unable To Auto Match Param: #{Utils.smart_quotes(f.ctx.sentence)} in `#{module_name}`
    """
  end

  def render(%MatchFailure{error_code: :unable_to_auto_match_param} = f, :verbose) do
    module_name = f.ctx.__struct__.module_name(f.ctx)

    """
    # Unable To Auto Match Param
    ## Summary
    While traversing the `feature` file, a line was encountered that could
    not be matched with any of the `cucumber expressions` in the `module`,
    causing it to `raise` this `exception`.

    ## Quick Fix
    Introduce the required `cucumber expression` inside the `module`: `#{module_name}`
    residing in the file: `#{f.ctx.module_file}`
    by copy and pasting therein the following:

    #{CommonMessages.render(:macro_usage, f.ctx, f.ctx.sentence)}

    ## Details
    * Error: Unable To Match
    * Feature File: `#{
      Exception.format_file_line(f.ctx.feature_file, f.ctx.location.line, f.ctx.location.column)
    }`
    * Module: `#{module_name}`
    * Cause: Missing `cucumber expression` for: #{Utils.smart_quotes(f.ctx.sentence)}
    """

    # * Gherkin Keyword: #{f.ctx.keyword}
    # * Gherkin Keyword Token: #{f.ctx.token}
    # * Macro: #{f.ctx.inferred.macro}
    # * Location Feature File:
    #   - Line: #{f.ctx.location.line}
    #   - Column: #{f.ctx.location.column}
  end
end
