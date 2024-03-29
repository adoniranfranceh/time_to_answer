namespace :dev do
  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, "lib", "tmp")

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do

  show_spinner("Apagando BD...") {%x(rails db:drop)}

  show_spinner("Criando BD...") {%x(rails db:create)}
  
  show_spinner("Migrando BD...") {%x(rails db:migrate)}

  show_spinner("Cadastrando administrador padrão...") {%x(rails dev:add_default_admin)}

  show_spinner("Cadastrando administrador extra...") {%x(rails dev:add_admin_extra)}

  show_spinner("Cadastrando usuário padrão...") {%x(rails dev:add_default_user)}

  show_spinner("Cadastrando assuntos padrões...") {%x(rails dev:add_subjects)}

  show_spinner("Cadastrando perguntas e respostas...") {%x(rails dev:add_answers_and_questions)}

  end
  
  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
   end

  desc "Adiciona o administrador extra"
  task add_admin_extra: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
     end
   end


  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do

  User.create!(
    email: 'user@user.com',
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD
  )
  end

  desc "Adiciona Assuntos Padrões"
  task add_subjects: :environment do
  file_name = "subjects.txt"
  file_path = File.join(DEFAULT_FILES_PATH, file_name)

  File.open(file_path, "r").each do |line|
    Subject.create!(description: line.strip)
  end  
  end

  desc "Adiciona perguntas e respostas"
  task add_answers_and_questions: :environment do
    Subject.all.each do |subject|
      rand(5..10).times do |i|

       params = create_question_params(subject)
       answer_array = params[:question][:answers_attributes]

       add_answer(answer_array)
       elect_true(answer_array)

       Question.create!(params[:question])
      end
    end
  end

  desc "Reseta subjects"
  task reset_subject: :environment do
    show_spinner("Resetando subjects...") do 
      Subject.find_each do |subject|
        Subject.reset_counters(subject.id, :questions)
      end  
    end  
  end

  private

  def create_question_params(subject = Subject.all.sample)
    { question: {description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
         subject: subject, 
         answers_attributes: []
       }
     }
  end

  def create_answer_params(correct = false)
    { description: Faker::Lorem.sentence, correct: correct }
  end

  def add_answer(answer_array = [])
    rand(2..5).times do |j|
      answer_array.push(create_answer_params)
    end
  end

  def elect_true(answer_array)
    selected_index = rand(answer_array.size)
    answer_array[selected_index] = create_answer_params(true)
  end

  def show_spinner(msg_start, msg_end = "Concluído com sucesso!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}") 
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")     
  end
end
