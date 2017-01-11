namespace :my_namespace do
  desc "TODO"
  task send_email: :environment do
    WarningWorker.perform_async
  end
end
