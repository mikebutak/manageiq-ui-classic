describe MiqPolicyController do
  before do
    stub_user(:features => :all)
  end
  context "::Policies" do
    context "#miq_policy_edit" do
      render_views

      before do
        FactoryBot.create(:miq_event_definition, :name => "containergroup_compliance_check")
        FactoryBot.create(:miq_action, :name => "compliance_failed")
        allow(controller).to receive(:policy_get_node_info)
        allow(controller).to receive(:get_node_info)
      end

      it "Correct active tree node is saved in @sb after Policy is added" do
        new = {}
        new[:mode] = "compliance"
        new[:towhat] = "ContainerGroup"
        new[:description] = "Test_description"
        new[:expression] =  {">" => {"count" => "ContainerGroup.advanced_settings", "value" => "1"}}
        controller.instance_variable_set(:@edit, :new     => new,
                                                 :current => new,
                                                 :typ     => "basic",
                                                 :key     => "miq_policy_edit__new")
        session[:edit] = assigns(:edit)
        active_node = "xx-compliance_xx-compliance-containerGroup"
        allow(controller).to receive(:replace_right_cell)
        controller.instance_variable_set(:@sb, :trees       => {:policy_tree => {:active_node => active_node}},
                                               :active_tree => :policy_tree)
        controller.params = {:button => "add"}
        controller.miq_policy_edit
        sb = assigns(:sb)
        expect(sb[:trees][sb[:active_tree]][:active_node]).to include("#{active_node}_p-")
        expect(assigns(:flash_array).first[:message]).to include("added")
      end

      it "Renders the control policy creation form correctly" do
        active_node = "xx-compliance_xx-compliance-containerGroup"
        session[:sandboxes] = {"miq_policy" => {:trees       => {:policy_tree => {:active_node => active_node}},
                                                :active_tree => :policy_tree,
                                                :folder      => "compliance-containerGroup",
                                                :nodeid      => "containerGroup"}}
        session[:edit] = {:new => {:mode => "compliance", :towhat => "ContainerGroup"}}
        post :x_button, :params => {:pressed => "miq_policy_new", :typ => "basic"}
        expect(response).to render_template("layouts/exp_atom/_editor")
        expect(response).to render_template("layouts/_exp_editor")
        expect(response).to render_template("miq_policy/_policy_details")
      end
    end
  end
end
