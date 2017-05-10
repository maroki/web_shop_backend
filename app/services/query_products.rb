class QueryProducts
  PRODUCTS_ON_PAGE = 10

  def initialize(scope, attrs)
    @params = attrs
    @scope = scope
  end

  def search
    search_by_query
    search_by_min_price
    search_by_max_price
    sort
    pagination

    scope
  end


  private
  attr_accessor :scope, :params

  def sort
    if params[:sort].present?
      return self.scope = scope.order(:price) if params[:sort] == 'price'
      self.scope = scope.order(:name)
    else
      # Default sorting by name
      self.scope = scope.order(:name)
    end
  end

  def search_by_query
    if params[:q].present?
      self.scope = scope.where("LOWER(name) ~ ?", "\\m#{params[:q].downcase}")
    end
  end

  def search_by_min_price
    if params[:min].present?
      self.scope = scope.where('price > ?', params[:min])
    end
  end

  def search_by_max_price
    if params[:max].present?
      self.scope = scope.where('price < ?', params[:max])
    end
  end

  def pagination
    if params[:page].present?
      self.scope = scope.offset((params[:page].to_i-1) * PRODUCTS_ON_PAGE).limit(PRODUCTS_ON_PAGE)
    else
      self.scope = scope.limit(PRODUCTS_ON_PAGE)
    end
  end
end
