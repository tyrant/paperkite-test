class UpdateProductsFromApiJob
  include Sidekiq::Job

  def perform
    UpdateProductsFromApiService.execute
  end
end