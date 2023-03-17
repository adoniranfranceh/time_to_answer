module SearchHelper
  def msg_jumbotron
    case params[:action]
    when 'index'
      'Last questions registered'
    when 'questions'
      "Results to \"#{params[:term]}\"..."
    when 'subject'
      "Subjects of \"#{params[:subject]}\"..."
    end
  end
end