require "./abstract/*"
require "./mqr/*"
require "./ecc/*"

module Goban
  # Object that represents an encoded Micro QR Code symbol.
  struct MQR < AbstractQR
    extend Encoder

    # Version of the Micro QR Code symbol. Version in QR Code does not refer to its revision,
    # but simply indicates the size format of the QR Code symbol.
    getter version : Version
    # Error correction level of the Micro QR Code symbol.
    getter ecl : ECC::Level
    # Returns the canvas of the Micro QR Code symbol. Canvas contains information about
    # each single module (pixel) in the symbol.
    getter canvas : Matrix(UInt8)
    # Length of a side in the symbol.
    getter size : Int32
    # Mask applied to this Micro QR Code symbol.
    getter mask : Mask

    protected def initialize(@version, @ecl, @canvas, @mask)
      @size = @version.symbol_size
    end
  end
end
