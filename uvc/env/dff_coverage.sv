class dff_coverage extends uvm_subscriber #(dff_item);
   `uvm_component_utils(dff_coverage)

   dff_item trans;

  covergroup cov_inst ;
    option.per_instance = 1;

    // 1. Kiểm tra Reset
    CP_RST: coverpoint trans.rst;
    CP_RST_TRANS: coverpoint trans.rst {
        bins active_deactive[] = (0 => 1), (1 => 0);
    }

    // 2. Kiểm tra Dữ liệu vào
    CP_DIN: coverpoint trans.data_in;
    CP_DIN_TRANS: coverpoint trans.data_in {
        bins data_toggling[] = (0 => 1), (1 => 0);
    }

    // 3. Kiểm tra Dữ liệu ra
    CP_DOUT: coverpoint trans.data_out;

    // 4. Cross quan trọng: Sự hiệu quả của Reset
    // Đảm bảo Reset thắng dữ liệu đầu vào
    X_RST_PRIORITY: cross CP_RST, CP_DIN, CP_DOUT {
        bins reset_priority = binsof(CP_RST) intersect {1} && binsof(CP_DOUT) intersect {0};
    // 2. Đánh dấu các trạng thái KHÔNG THỂ XẢY RA (RST=1 nhưng DOUT=1)
    // Nếu kịch bản này xảy ra, trình mô phỏng sẽ báo lỗi Fatal ngay lập tức
    illegal_bins rst_fail = binsof(CP_RST) intersect {1} && binsof(CP_DOUT) intersect {1};
    }

    // 5. Cross quan trọng: Sự truyền dẫn dữ liệu
    // Đảm bảo dout đi theo din khi không có reset
    DATAPATH: cross CP_RST, CP_DIN, CP_DOUT {
        ignore_bins rst_on = binsof(CP_RST) intersect {1};
        bins path_0 = binsof(CP_DIN) intersect {0} && binsof(CP_DOUT) intersect {0};
        bins path_1 = binsof(CP_DIN) intersect {1} && binsof(CP_DOUT) intersect {1};
    }
endgroup

   function new (string name = "dff_coverage", uvm_component parent = null);
       super.new(name, parent);
       cov_inst = new();
   endfunction

   virtual function void write(dff_item t);
       trans = t;
       cov_inst.sample();
   endfunction

endclass

