require "./spec_helper"

module Goban
  struct QR::Canvas
    def reserve_modules_for_test
      reserve_modules(8, 8, 7, 7)
    end
  end

  describe QR::Canvas do
    describe "#draw_function_patterns" do
      it "draws all function patterns" do
        canvas = QR::Canvas.new(QR::Version.new(7), QR::ECLevel::Low)
        canvas.draw_function_patterns

        canvas.modules.should eq(FUNCTION_PATTERN_MODS)
      end
    end

    describe "#draw_data_codewords" do
      it "fills codewords properly" do
        canvas = QR::Canvas.new(QR::Version.new(1), QR::ECLevel::Low)
        canvas.reserve_modules_for_test

        codewords = Array(UInt8).new(21 ** 2 - 7 ** 2, 154)
        canvas.draw_data_codewords(codewords)

        canvas.modules.should eq(CODEWORDS_FILL_MODS)
      end
    end

    describe "#apply_best_mask" do
      it "applies best mask" do
        canvas = QR::Canvas.new(QR::Version.new(1), QR::ECLevel::Low)
        canvas.modules.map_with_index! { |_, idx| idx.odd? }

        canvas.apply_best_mask.value.should eq(2)
      end
    end
  end
end