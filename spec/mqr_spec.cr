require "./spec_helper"

module Goban
  describe MQR do
    describe ".encode_string" do
      qr = MQR.encode_string(SAMPLE_STR_2, ECC::Level::Low)

      it "reports correct version" do
        qr.version.value.should eq(3)
      end

      it "reports correct ec level" do
        qr.ecl.should eq(ECC::Level::Low)
      end

      it "encodes properly" do
        rows = convert_canvas(qr.canvas)
        rows.should eq(SAMPLE_RESULT_MODS_MQR)
      end

      it "raises if text is too long" do
        long_str = String.build do |io|
          36.times { io << '0' } # Numeric mode can contain upto 35 characters
        end

        expect_raises(Exception, "Text too long") do
          MQR.encode_string(long_str, ECC::Level::Low)
        end
      end
    end

    describe ".encode_segments" do
      qr = MQR.encode_segments(SAMPLE_SEGS_2, ECC::Level::Low, 3)

      it "reports correct version" do
        qr.version.value.should eq(3)
      end

      it "reports correct ec level" do
        qr.ecl.should eq(ECC::Level::Low)
      end

      it "encodes properly" do
        rows = convert_canvas(qr.canvas)
        rows.should eq(SAMPLE_RESULT_MODS_MQR)
      end
    end
  end
end
