class Admin::StatisticController < ApplicationController
  def index
    @customer_uploads = []
    @customer_downloads = []
    @categories = []
    statistic
    respond_to do |format|
      format.json do
        render json: [
          {categories: @categories},
          {type: t(".column"), name: t(".customer_download"),
            data: @customer_downloads, yAxis: Settings.number_one,
            tooltip: {valueSuffix: " downloads"}},
          {type: t(".spline"), name: t(".upload_count"),
            data: @customer_uploads, tooltip: {valueSuffix: " uploads"}}
        ]
      end
    end
  end

  private

  def statistic
    upload_count
    download_count
    categories
  end

  def upload_count
    current_date = Time.now - Settings.number_seven_1
    Settings.number_seven.times.each do
      @customer_uploads << Document.upload_count(
        current_date.strftime(Settings.format_date)
      )
      current_date += Settings.number_one.day
    end
  end

  def download_count
    current_date = Time.now - Settings.number_seven_1
    Settings.number_seven.times.each do
      @customer_downloads << Download.download_count(
        current_date.strftime(Settings.format_date)
      )
      current_date += Settings.number_one.day
    end
  end

  def categories
    current_date = Time.now - Settings.number_seven_1
    Settings.number_seven.times.each do
      @categories << current_date.strftime(Settings.format_date_show)
      current_date += Settings.number_one.day
    end
  end
end
