class Admin::DownloadsController < Admin::BaseController
  def show
    respond_to do |format|
      format.pdf {send_category_pdf}
      if Rails.env.development?
        format.html {render_sample_html}
      end
    end
  end

  private
  def category
    @category = Category.find_by id: params[:category_id]
    unless @category
      flash[:danger] = t "do_not_find_item"
      redirect_to :back
    end
    @category
  end

  def category_pdf
    CategoryPdf.new category
  end

  def send_category_pdf
    send_file category_pdf.to_pdf, filename: category_pdf.filename,
      type: "application/pdf", disposition: "inline"
  end

  def render_sample_html
    render template: "admin/categories/pdf", layout: "category_pdf",
      locals: {category: @category}
  end
end
