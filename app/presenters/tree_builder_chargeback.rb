class TreeBuilderChargeback < TreeBuilder
  private

  def tree_init_options
    {:open_all => true, :full_ids => true, :click_url => "/chargeback_rate/tree_select/", :onclick => "miqOnClickGeneric"}
  end

  # Get root nodes count/array for explorer tree
  def x_get_tree_roots
    rate_types = ChargebackRate::VALID_CB_RATE_TYPES

    rate_types.map do |type|
      {
        :id   => type,
        :text => type,
        :selectable => false,
        :icon => type.downcase == "compute" ? "pficon pficon-cpu" : "fa fa-hdd-o",
        :tip  => type
      }
    end
  end
end
